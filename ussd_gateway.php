<?php
require_once 'dbconfig.php';
require_once 'ussd_config.php';
require_once 'sms_helper.php';
require_once 'sms.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

$logFile = 'ussd_log.txt';
file_put_contents($logFile, date('Y-m-d H:i:s') . " - Request: " . print_r($_POST, true) . "\n", FILE_APPEND);

class USSDGateway {
    private $conn, $sessionId, $phoneNumber, $text, $serviceCode, $sessionData, $smsHelper, $errorMessages, $successMessages;
    public function __construct($conn) {
        $this->conn = $conn;
        $this->sessionId = $_POST['sessionId'] ?? '';
        $this->phoneNumber = $_POST['phoneNumber'] ?? '';
        $this->text = $_POST['text'] ?? '';
        $this->serviceCode = $_POST['serviceCode'] ?? '';
        $this->sessionData = $this->getSessionData();
        $this->smsHelper = new SMSHelper();
        $this->errorMessages = array_map(function($msg) {
            return strpos($msg, 'END') === 0 ? $msg : 'END ' . $msg;
        }, $GLOBALS['ERROR_MESSAGES']);
        $this->successMessages = $GLOBALS['SUCCESS_MESSAGES'];
    }
    private function getSessionData() {
        $stmt = $this->conn->prepare("SELECT session_data FROM ussd_sessions WHERE session_id = ?");
        $stmt->bind_param("s", $this->sessionId);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $sessionData = json_decode($row['session_data'], true);
            // Initialize default values for session data
            return array_merge([
                'registration_step' => '',
                'request_step' => '',
                'sms_step' => '',
                'name' => '',
                'email' => '',
                'location' => ''
            ], $sessionData);
        }
        // Return default initialized array if no session exists
        return [
            'registration_step' => '',
            'request_step' => '',
            'sms_step' => '',
            'name' => '',
            'email' => '',
            'location' => ''
        ];
    }
    private function saveSessionData($data) {
        $jsonData = json_encode($data);
        $stmt = $this->conn->prepare("INSERT INTO ussd_sessions (session_id, phone_number, session_data) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE session_data = ?");
        $stmt->bind_param("ssss", $this->sessionId, $this->phoneNumber, $jsonData, $jsonData);
        $stmt->execute();
    }
    public function processRequest() {
        $text = $this->text;
        $response = "";
        if (empty($text)) {
            $response = "CON Welcome to BMS USSD Service\n";
            $response .= "1. Register as Donor\n2. Request Blood\n3. Check Blood Availability\n4. View My Profile\n5. Emergency Contact\n6. SMS Services";
        } else {
            $textArray = explode('*', $text);
            $level = count($textArray);
            switch ($level) {
                case 1:
                    switch ($textArray[0]) {
                        case "1":
                            $response = "CON Enter your full name:";
                            $this->sessionData['registration_step'] = 'name';
                            break;
                        case "2":
                            $response = "CON Select your blood type:\n1. A+\n2. A-\n3. B+\n4. B-\n5. AB+\n6. AB-\n7. O+\n8. O-";
                            $this->sessionData['request_step'] = 'blood_type';
                            break;
                        case "3":
                            $response = "CON Select blood type to check:\n1. A+\n2. A-\n3. B+\n4. B-\n5. AB+\n6. AB-\n7. O+\n8. O-";
                            break;
                        case "4":
                            $response = $this->getUserProfile();
                            // Send SMS for profile view
                            $profile = $this->getUserProfileData();
                            if ($profile) {
                                $smsMsg = "Profile viewed: Name: {$profile['full_name']}, Blood Type: {$profile['blood_type']}, Last Donation: {$profile['last_donation_date']}.";
                                sendSMS($this->phoneNumber, $smsMsg);
                            }
                            break;
                        case "5":
                            // Send SMS for emergency contacts first
                            $smsMsg = "Emergency Contacts: National: " . EMERGENCY_NUMBER . ", Blood Bank: " . BLOOD_BANK_NUMBER . ", Main Hospital: " . MAIN_HOSPITAL_NUMBER . ".";
                            sendSMS($this->phoneNumber, $smsMsg);
                            $response = "END Emergency contacts have been sent to your phone via SMS.";
                            break;
                        case "6":
                            $response = "CON SMS Services:\n1. Subscribe to Blood Alerts\n2. Unsubscribe from Alerts\n3. Send Emergency Alert\n4. View SMS Balance";
                            break;
                        default:
                            $response = $this->errorMessages['invalid_option'];
                    }
                    break;
                case 2:
                    if ($this->sessionData['registration_step'] == 'name') {
                        $this->sessionData['name'] = $textArray[1];
                        $response = "CON Enter your email:";
                        $this->sessionData['registration_step'] = 'email';
                    } elseif ($this->sessionData['request_step'] == 'blood_type') {
                        $selectedType = $GLOBALS['BLOOD_TYPES'][$textArray[1]] ?? '';
                        if ($selectedType) {
                            $response = $this->checkBloodAvailability($selectedType);
                            // Send SMS notification about blood availability using new SMS service
                            $units = $this->getBloodUnits($selectedType);
                            $smsMsg = "Blood type {$selectedType} availability: {$units} units currently available at BMS.";
                            sendSMS($this->phoneNumber, $smsMsg);
                        } else {
                            $response = $this->errorMessages['invalid_option'];
                        }
                    } elseif ($textArray[0] == "2") {
                        // Request Blood transaction
                        $smsMsg = "Your blood request has been received. We will notify you when a matching donor is found. Thank you for using BMS.";
                        sendSMS($this->phoneNumber, $smsMsg);
                    } elseif ($textArray[0] == "6") {
                        switch ($textArray[1]) {
                            case "1":
                                $this->subscribeToAlerts();
                                $response = "END You have been subscribed to blood alerts. You will receive notifications about blood availability and emergency requests.";
                                break;
                            case "2":
                                $this->unsubscribeFromAlerts();
                                $response = "END You have been unsubscribed from blood alerts.";
                                break;
                            case "3":
                                $response = "CON Enter your emergency message:";
                                $this->sessionData['sms_step'] = 'emergency_message';
                                break;
                            case "4":
                                $response = $this->getSMSBalance();
                                break;
                            default:
                                $response = $this->errorMessages['invalid_option'];
                        }
                    }
                    break;
                case 3:
                    if ($this->sessionData['registration_step'] == 'email') {
                        $this->sessionData['email'] = $textArray[2];
                        $response = "CON Enter your location:";
                        $this->sessionData['registration_step'] = 'location';
                    } elseif ($this->sessionData['sms_step'] == 'emergency_message') {
                        $message = $textArray[2];
                        $response = $this->sendEmergencyAlert($message);
                    }
                    break;
                case 4:
                    if ($this->sessionData['registration_step'] == 'location') {
                        $this->sessionData['location'] = $textArray[3];
                        $response = $this->completeRegistration();
                    }
                    break;
            }
        }
        $this->saveSessionData($this->sessionData);
        return $response;
    }
    private function getUserProfile() {
        $stmt = $this->conn->prepare("SELECT u.*, d.blood_type, d.last_donation_date FROM users u LEFT JOIN donors d ON u.user_id = d.user_id WHERE u.phone = ?");
        $stmt->bind_param("s", $this->phoneNumber);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            $response = "END Your Profile:\n";
            $response .= "Name: " . $row['full_name'] . "\n";
            $response .= "Blood Type: " . ($row['blood_type'] ?? 'Not set') . "\n";
            $response .= "Last Donation: " . ($row['last_donation_date'] ?? 'Never');
        } else {
            $response = $this->errorMessages['profile_not_found'];
        }
        return $response;
    }
    private function checkBloodAvailability($bloodType) {
        $stmt = $this->conn->prepare("SELECT COUNT(*) as count FROM donors WHERE blood_type = ?");
        $stmt->bind_param("s", $bloodType);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        $response = "END Blood Type " . $bloodType . ":\nAvailable Units: " . $row['count'];
        return $response;
    }
    private function completeRegistration() {
        $name = $this->sessionData['name'];
        $email = $this->sessionData['email'];
        $location = $this->sessionData['location'];
        $password = substr(md5(rand()), 0, 8);
        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
        $stmt = $this->conn->prepare("INSERT INTO users (full_name, email, password, phone, role) VALUES (?, ?, ?, ?, 'donor')");
        $stmt->bind_param("ssss", $name, $email, $hashedPassword, $this->phoneNumber);
        if ($stmt->execute()) {
            $userId = $stmt->insert_id;
            $stmt = $this->conn->prepare("INSERT INTO donors (user_id, location) VALUES (?, ?)");
            $stmt->bind_param("is", $userId, $location);
            $stmt->execute();
            
            // Send registration SMS using the new SMS service
            $smsMsg = "Thank you for registering as a donor with BMS. Your password is: {$password}. Please log in to complete your profile.";
            sendSMS($this->phoneNumber, $smsMsg);
            
            $response = $this->successMessages['registration_success'];
            $response .= "\nYour password is: " . $password;
            $response .= "\nPlease login to complete your profile.";
        } else {
            $response = $this->errorMessages['registration_failed'];
        }
        return $response;
    }
    private function subscribeToAlerts() {
        $stmt = $this->conn->prepare("INSERT INTO sms_subscribers (phone_number, status) VALUES (?, 'active') ON DUPLICATE KEY UPDATE status = 'active'");
        $stmt->bind_param("s", $this->phoneNumber);
        $stmt->execute();
    }
    private function unsubscribeFromAlerts() {
        $stmt = $this->conn->prepare("UPDATE sms_subscribers SET status = 'inactive' WHERE phone_number = ?");
        $stmt->bind_param("s", $this->phoneNumber);
        $stmt->execute();
    }
    private function sendEmergencyAlert($message) {
        $stmt = $this->conn->prepare("SELECT phone_number FROM sms_subscribers WHERE status = 'active'");
        $stmt->execute();
        $result = $stmt->get_result();
        
        $emergencyMessage = "EMERGENCY ALERT: " . $message . "\nPlease respond if you can help.";
        $successCount = 0;
        $totalCount = 0;
        
        while ($row = $result->fetch_assoc()) {
            $totalCount++;
            if (sendSMS($row['phone_number'], $emergencyMessage) === 'success') {
                $successCount++;
            }
        }
        
        return "END Emergency alert has been sent to {$successCount} out of {$totalCount} subscribers.";
    }
    private function getSMSBalance() {
        // This would typically call the SMS provider's API to get the balance
        // For now, we'll return a placeholder message
        return "END Your SMS balance: 100 credits";
    }
    // Helper to get user profile data for SMS
    private function getUserProfileData() {
        $stmt = $this->conn->prepare("SELECT u.full_name, d.blood_type, d.last_donation_date FROM users u LEFT JOIN donors d ON u.user_id = d.user_id WHERE u.phone = ?");
        $stmt->bind_param("s", $this->phoneNumber);
        $stmt->execute();
        $result = $stmt->get_result();
        if ($row = $result->fetch_assoc()) {
            return $row;
        }
        return null;
    }
    // Helper to get blood units for SMS
    private function getBloodUnits($bloodType) {
        $stmt = $this->conn->prepare("SELECT COUNT(*) as count FROM donors WHERE blood_type = ?");
        $stmt->bind_param("s", $bloodType);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();
        return $row['count'];
    }
}

$createTableSQL = "CREATE TABLE IF NOT EXISTS ussd_sessions (
    session_id VARCHAR(255) PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL,
    session_data TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)";
$conn->query($createTableSQL);

$ussd = new USSDGateway($conn);
$response = $ussd->processRequest();
file_put_contents($logFile, date('Y-m-d H:i:s') . " - Response: " . $response . "\n", FILE_APPEND);
header('Content-type: text/plain');
echo $response;
?>