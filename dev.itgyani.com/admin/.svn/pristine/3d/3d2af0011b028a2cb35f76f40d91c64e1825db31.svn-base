<?php
include_once('config/ITGStandardPHPPageDBConfig.php'); 
include_once('config/ez_sql_core.php'); 
include_once('config/ez_sql_mysql.php'); 
include_once('config/Cipher.php');


/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

if(isset($_GET['CallID']))
 {
    if($_GET['CallID']=='ExecuteUI-UserRecord')
    {    
        //Select GroupID, AdminID, AdminEmail, AdminPassword, IsActive, IsDeleted  From adminpanel WHERE AdminEmail =  ParaTranString;
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $UIResult = $ITGObjStandardDB->get_row("CALL ExecuteUIControls( '" . $_GET['XXX01'] . "' , '" . $_GET['XXX02']. "' , '" . $_GET['XXX03']. "' , '" . $_GET['XXX04'] . "');");
        $results = array();
        $results[] = array(
              'GroupID' => $UIResult->GroupID,
              'AdminID' => $UIResult->AdminID,
              'AdminEmail' => $UIResult->AdminEmail,
              'IsActive' => $UIResult->IsActive,
              'IsDeleted' => $UIResult->IsDeleted
           );
        $_SESSION["UserInfo"] = $results;
        $json = json_encode($results);
    echo $json;

}
 }