<?php
?>

<?php
$connection = mysql_connect('localhost', 'itgyani_register', 'register');
if (!$connection){
    die("Database Connection Failed" . mysql_error());
}
$select_db = mysql_select_db('itgyani_register');
if (!$select_db){
    die("Database Selection Failed" . mysql_error());
}
?>