<?php
include_once('../config/ITGStandardPHPPageDBConfig.php'); 
include_once('../config/ez_sql_core.php'); 
include_once('../config/ez_sql_mysql.php');
include_once('../class.phpmailer.php');
date_default_timezone_set('Etc/UTC');
require_once('../PHPMailer/PHPMailerAutoload.php');
 
//include_once( '../PHPMailer/class.phpmailer.php');
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * ITGyaniRegisteration
 * ITGyaniRegisteration2016
 */

if(isset($_GET['CallID']))
 {
    if($_GET['CallID']=='XXX001') //Register Student
    {  
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        if($_GET['XXX03'] != "null")
        {
           $_GET['XXX03'] = sha1($_GET['XXX03']); 
        }
        $user = $ITGObjStandardDB->get_row("CALL ManagePortalStudentRegisteration( '" . $_GET['XXX01'] . "' , '" . $_GET['XXX02'] . "' , '" . $_GET['XXX03']. "' , '" . $_GET['XXX04']. "' , '" . $_GET['XXX05']."' , '" . $_GET['XXX06'].  "');");
        $mail = new PHPMailer();
        $mail->CharSet =  "utf-8";
        $mail->IsSMTP();
        $mail->SMTPAuth = true;
        $mail->Username = "info.itgyani@gmail.com";
        $mail->Password = "Itgyani@123";
        $mail->SMTPSecure = "ssl";  
        $mail->Host = "smtp.gmail.com";
        $mail->Port = "465";

        $mail->setFrom('info.itgyani@gmail.com',  'ITGyani' );
        $mail->AddAddress($_GET['XXX02'] , $_GET['XXX01'] );

        $mail->Subject  =  'Welcome to the IT Gyani program.';
        $mail->IsHTML(true);
        $mail->MsgHTML($message); 
        $mail->CharSet="utf-8";
        $mail->Body    = 'Dear ' . $_GET['XXX02'] . ', <br/><br/>
                           <bold style="color:green;font-weight:1em;"> Welcome to the IT Gyani program.</bold> <br/><br/>
                            This program ensures that you have the requisite skills -both technical and soft- to secure a job in the IT industry.<br/>
                                <br/>
                           <h3 style="color:blue;"> There are 4 broad parts to the program..</h3><br/>
                                <br/>
                            1. In foundation courses you will be exposed to the world of IT careers and basic communication skills.<br/>
                            2. In counseling you will be evaluated psychometrically and based on your choice and performance you will guided to a career track based on industry requirements <br/>
                            3. In Career track you will be taught complete stack courses for the career along with Advanced soft skills like interview techniques etc.<br/>
                            4. Live environment will be provided for hands in experience in your tech stack<br/>
                            The duration of the course will be around 6 months if you are an average student and spend about 2 hours on the site, however it will vary as it is online and the number of tracks you do.<br/>
                            You will have access to the libraries and courses as long as you wish...<br/>
                            Through the program you can also Chat with counselors, instructors and course mates online.<br/>
                            Apart from this you can enjoy the following benefits as part of the program.<br/>
                                <br/>
                           <bold> (Other benefits from website not mentioned here) </bold> <br/>
                                <br/>
                           <bold style="color:green;font-weight:1em;"> The IT Gyani program is also currently offering 100% job guarantee, which means we will refund your entire fees if you don\'t secure a job within 6 months after you graduate.</bold> <br/>
                                <br/>
                            Warm regards <br/> 
                                <br/>
                            Team IT Gyani <br/>
                            www.itgyani.com <br/>
                            Thanks & Regards, <br/>
                            Boraste Sagar | IT Consultant | Techno Flair Lab Pvt. Ltd. <br/>
                            Level-5, Tech Park-1, Airport Road, Yerwada, Pune - 411006, India <br/>
                            O: + 91.20.4011 1336 | F : + 91.020. 40111105 | M : +91 758 817 3431 / +91 954 575 2552 <br/>
                            Website: www.itgyani.com | Email ID: sagar@itgyani.com <br/>';
          $success ;
         if($mail->Send())
         {
            $success = "sent";
         }
         else
         {
            $success = "canceled";
         }

        $results = array();
        $profile = array();
        $results[] = array(
              'ResultID' => $user->ResultID,
              'TransMessage' => $user->TransMessage,
              'TransMessageId' => $user->TransMessageId,
              'TransControl' => $user->TransControl
           );                
        $json = json_encode($results);
        echo $json;
    }
}
if(isset($_GET['CallID']))
 {
    if($_GET['CallID']=='GetLogin') //Register Student
    {  $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $Registeration = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '108' , '' ,'" . $_GET['Email'] . "' , '0' );");
            $profile[] = array(
              'GroupID' => $Registeration[0]->GroupID,
              'ProfileID' => $Registeration[0]->ProfileID,
              'ProfileName' => $Registeration[0]->ProfileName,
              'ProfileEmail' => $Registeration[0]->ProfileEmail,
              'ProfilePassword' => $Registeration[0]->ProfilePassword,
              'ProfilePicture' => $Registeration[0]->ProfilePicture,
              'IsFaceBook' => $Registeration[0]->IsFaceBook,
              'IsFaceGmail' => $Registeration[0]->IsFaceGmail,
              'IsPaid' => $Registeration[0]->IsPaid,
              'ExpiryDate' => $Registeration[0]->ExpiryDate,
              'IsActive' => $Registeration[0]->IsActive,
              'IsDeleted' => $Registeration[0]->IsDeleted
           );
            session_start();
            
            $_SESSION['profile'] = $profile ;
            $json = json_encode($profile);
        echo $json;
    }
 }
 if(isset($_GET['CallID']))
 {
     if($_GET['CallID']=='RegisterationMail')
     {
         global $error;
	$mail = new PHPMailer();  // create a new object
	$mail->IsSMTP(); // enable SMTP
	$mail->SMTPDebug = 0;  // debugging: 1 = errors and messages, 2 = messages only
	$mail->SMTPAuth = false;  // authentication enabled
	$mail->SMTPSecure = 'tls'; // secure transfer enabled REQUIRED for GMail
	$mail->Host = 'smtp.gmail.com';
	$mail->Port = 587; 
	$mail->Username = 'ITGyaniRegisteration';  
	$mail->Password = 'ITGyaniRegisteration2016';           
	$mail->SetFrom('ITGyaniRegisteration@gmail.com');
	$mail->Subject = $_GET['XXX02'];
	$mail->Body = $_GET['XXX02'];
	$mail->AddAddress($_GET['XXX02']); // XXX02
	if(!$mail->Send()) {
		$error = 'Mail error: '.$mail->ErrorInfo; 
		return false;
	} else {
		$error = 'Message sent!';
		return true;
	}
     }
 }
 if(isset($_GET['CallID']))
 {
    if($_GET['CallID']=='SignIn')
       {    
           //$cipher = new Cipher(MCRYPT_BLOWFISH, MCRYPT_MODE_ECB);
           $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
           $user = $ITGObjStandardDB->get_row("CALL ManagePortalSignIn( '" . $_GET['XXX01'] . "' , '" . md5($_GET['XXX02']) . "');");
           $results = array();
           $results[] = array(
                 'ResultID' => $user->ResultID,
                 'TransMessage' => $user->TransMessage,
                 'TransMessageId' => $user->TransMessageId,
                 'TransControl' => $user->TransControl
              );
           $json = json_encode($results);
           echo $json;

       }
 }