<?php

require 'vendor/autoload.php';
use AfricasTalking\SDK\AfricasTalking;

class SmsService {
    protected $phone;
    protected $AT;
    private $apiKey = "atsk_718ce6c1ead4a25a42099d30974efbee2ec5661e66f527fbeb44e4e6223ffe1785635de9";

    public function __construct($phone) {
        $this->phone = $phone;
        $this->AT = new AfricasTalking("sandbox", $this->apiKey);
    }

    public function sendSms($message, $recipients) {
        try {
            $sms = $this->AT->sms();
            $result = $sms->send([
                'username' => 'sandbox',
                'to' => $recipients,
                'message' => $message,
                'from' => "MIMI"
            ]);
            return $result;
        } catch (Exception $e) {
            error_log("SMS Error: " . $e->getMessage());
            return false;
        }
    }
}


function sendSMS($phoneNumber, $message) {
    $smsService = new SmsService($phoneNumber);
    $result = $smsService->sendSms($message, $phoneNumber);
    
    if ($result && isset($result['status']) && $result['status'] === 'success') {
        return 'success';
    }
    return 'error';
}