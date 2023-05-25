<?php

$json = '{
   "amount": 1000,
   "msisdn": 256750482089,
   "reason": "your reason for the transaction",
   "currency": "UGX",
   "environment": "production",
   "callback": ""
}';

$data = json_decode($json, true);

foreach ($data as $key => $value) {
    echo "Key: " . $key . ", Value: " . $value . "\n";
}

?>
