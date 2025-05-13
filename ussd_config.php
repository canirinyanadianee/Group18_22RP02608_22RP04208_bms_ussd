<?php
define('USSD_SERVICE_CODE', '*384*74733#');
define('USSD_SESSION_TIMEOUT', 300);

define('SMS_ENABLED', true);
define('SMS_PROVIDER', 'africastalking');
define('SMS_API_KEY', 'atsk_718ce6c1ead4a25a42099d30974efbee2ec5661e66f527fbeb44e4e6223ffe1785635de9');
define('SMS_USERNAME', 'MIMI');

define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'bms_ussd');

define('EMERGENCY_NUMBER', '112');
define('BLOOD_BANK_NUMBER', '0788402907');
define('MAIN_HOSPITAL_NUMBER', '0798063990');

$GLOBALS['BLOOD_TYPES'] = [
    '1' => 'A+','2' => 'A-','3' => 'B+','4' => 'B-',
    '5' => 'AB+','6' => 'AB-','7' => 'O+','8' => 'O-'
];

$GLOBALS['ERROR_MESSAGES'] = [
    'invalid_option' => 'END Invalid option selected',
    'registration_failed' => 'END Registration failed. Please try again.',
    'profile_not_found' => 'END Profile not found',
    'session_expired' => 'END Your session has expired. Please dial ' . USSD_SERVICE_CODE . ' again.',
    'system_error' => 'END System error. Please try again later.'
];

$GLOBALS['SUCCESS_MESSAGES'] = [
    'registration_success' => 'END Registration successful!',
    'request_success' => 'END Blood request submitted successfully!',
    'profile_updated' => 'END Profile updated successfully!'
];
?>