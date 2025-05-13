<?php
$conn = new mysqli('localhost', 'root', '', 'bms_ussd');
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>