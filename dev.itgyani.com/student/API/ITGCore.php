<?php
include_once('../config/ITGStandardPHPPageDBConfig.php'); 
include_once('../config/ez_sql_core.php'); 
include_once('../config/ez_sql_mysql.php');
include_once('../class.phpmailer.php');
date_default_timezone_set('Etc/UTC');
require '../PHPMailerAutoload.php';

if(isset($_GET['CallID']))
 {
    if($_GET['CallID']=='BrizBVKStandardFunFillDropDown') //Register Student
    {  
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $DropDown = $ITGObjStandardDB->get_results( $_GET['DSAPI'] );
        $results = array();
        foreach ( $DropDown as $Select ) {
            $string = str_replace('�', '-', $Select->value); 
            preg_replace('/[^A-Za-z0-9\-]/', '', $string);
            $results[] = array(
                  'ID' => $Select->ID,
                  'Value' => $string
               );
        }
        if( json_encode($results) == false)
        {
            $json = json_encode(utf8ize($results));                        
        }
        else
        {
            $json = json_encode($results);                        
        }
        
        echo $json;
    }
}
function utf8ize($d) {
    if (is_array($d)) {
        foreach ($d as $k => $v) {
            $d[$k] = utf8ize($v);
        }
    } else if (is_string ($d)) {
        return utf8_encode($d);
    }
    return $d;
}
function BrizBVKStandardFunFillDropDown()
{
    echo 'called';
}