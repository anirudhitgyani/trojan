<?php

$ch = curl_init();

curl_setopt($ch, CURLOPT_URL, 'https://www.instamojo.com/api/1.1/payment-requests/');
curl_setopt($ch, CURLOPT_HEADER, FALSE);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
curl_setopt($ch, CURLOPT_HTTPHEADER,
            array("X-Api-Key:0b871c4d559721941a332a59db064e6b",
                  "X-Auth-Token:09cc262646c9171982e6771e9236d1dd"));
$payload = Array(
    'purpose' => 'FIFA',
    'amount' => '250',
    'phone' => '1234567891',
    'buyer_name' => 'sager',
    'redirect_url' => 'http://itgyani.us.tempcloudsite.com/lms/' ,
    'send_email' => true,
    'webhook' => 'http://www.example.com/webhook/',
    'send_sms' => true,
    'email' => 'smamsahil7@gmail.com',
    'allow_repeated_payments' => false
);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($payload));
$response = curl_exec($ch);
curl_close($ch); 

echo $response;

?>