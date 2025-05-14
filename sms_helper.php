<?php
require_once 'ussd_config.php';

class SMSHelper {
    private $apiKey;
    private $username;
    private $provider;

    public function __construct() {
        $this->apiKey = SMS_API_KEY;
        $this->username = SMS_USERNAME;
        $this->provider = SMS_PROVIDER;
    }

    public function sendSMS($to, $message) {
        if (!SMS_ENABLED) return false;
        switch ($this->provider) {
            case 'africastalking':
                return $this->sendViaAfricasTalking($to, $message);
            default:
                error_log("Unsupported SMS provider: " . $this->provider);
                return false;
        }
    }

    private function sendViaAfricasTalking($to, $message) {
        $url = 'https://api.africastalking.com/version1/messaging';
        $data = [
            'username' => $this->username,
            'to' => $to,
            'message' => $message,
            'from' => 'BMS'
        ];
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Accept: application/json',
            'Content-Type: application/x-www-form-urlencoded',
            'apiKey: ' . $this->apiKey
        ]);
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        error_log("Africa's Talking SMS Response: " . $response);
        curl_close($ch);
        return $httpCode === 201;
    }

    public function sendRegistrationConfirmation($phone, $password) {
        $message = "Welcome to BMS!\nYour registration is successful.\nPassword: {$password}\nPlease login to complete your profile.";
        return $this->sendSMS($phone, $message);
    }
}
?>