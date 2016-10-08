<?php
ob_start();
define('DB_SERVER', 'localhost');
define('DB_USERNAME', 'itgyani_register');
define('DB_PASSWORD', 'register');
define('DB_DATABASE', 'itgyani_register');
$connection = mysql_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD) or die(mysql_error());
$database = mysql_select_db(DB_DATABASE) or die(mysql_error());
?>