<?php
session_start();
// added in v4.0.0
include('autoload.php');

use Facebook\FacebookSession;
use Facebook\FacebookRedirectLoginHelper;
use Facebook\FacebookRequest;
use Facebook\FacebookResponse;
use Facebook\FacebookSDKException;
use Facebook\FacebookRequestException;
use Facebook\FacebookAuthorizationException;
use Facebook\GraphObject;
use Facebook\Entities\AccessToken;
use Facebook\HttpClients\FacebookCurlHttpClient;
use Facebook\HttpClients\FacebookHttpable;
// init app with app id and secret
FacebookSession::setDefaultApplication( '1280237475343277','f17ad6b49694fb48ddb04ee3cb9ef190' );
// login helper with redirect_uri
    $helper = new FacebookRedirectLoginHelper('http://www.itgyani.com/pages/student/facebook_login/fbconfig.php' );
try {
  $session = $helper->getSessionFromRedirect();
} catch( FacebookRequestException $ex ) {
  // When Facebook returns an error
} catch( Exception $ex ) {
  // When validation fails or other local issues
}
// see if we have a session
if ( isset( $session ) ) {
    mysql_connect("localhost","itgyani_staging","staging") or die(mysql_error());
    mysql_select_db("itgyani_staging") or die(mysql_error());
  // graph api request for user data
  $request = new FacebookRequest( $session, 'GET', '/me' );
  $response = $request->execute();
  // get response
  $graphObject = $response->getGraphObject();
     	$fbid = $graphObject->getProperty('id');              // To Get Facebook ID
 	    $fbfullname = $graphObject->getProperty('name'); // To Get Facebook full name
	    $femail = $graphObject->getProperty('email');    // To Get Facebook email ID
            
            $getname = explode(' ',$fbfullname);

            $first_name = $getname[0];

            $last_name = $getname[1];
                
	/* ---- Session Variables -----*/
	    $_SESSION['FBID'] = $fbid;  
            $_SESSION['id'] = $fbid;  
        $_SESSION['FULLNAME'] = $fbfullname;
	    $_SESSION['EMAIL'] =  $femail;
    /* ---- header location after session ----*/
            
        $check = mysql_query("select * from `profile` where fb_id='".$fbid."'") or die(mysql_error());
        $check = mysql_num_rows($check);

	if (empty($check)) { // if new user . Insert a new record		

	
            $sql = mysql_query("insert into `profile` set IsFaceBook = '1' , FBID = '".$fbid."' , ProfileFirstName = '".$first_name."' , ProfileLastName = '".$last_name."' , ProfileName = '".$fbfullname."' , ProfileEmail = '".$femail."' , IsFaceGmail = '0', IsPaid = '0', IsActive = '1', IsActived='1',IsDeleted='0' ") or die(mysql_error());

            $LastID = mysql_insert_id();

            $_SESSION["id"] = $LastID;
        
        } else {
            
            $sql = mysql_query("update `profile` set ProfileFirstName = '".$first_name."' , ProfileLastName = '".$last_name."' , ProfileName = '".$fbfullname."' where FBID = '".$fbid."'  ") or die(mysql_error());

            $sql1 = mysql_query("select * from `profile` where FBID = '".$fbid."' ");
            $row1 = mysql_fetch_array($sql1);
            $_SESSION["stud_id"] = $row1['ProfileID'];
            
        }
        
        
  header("Location:http://www.itgyani.com/pages/student/");
} else {
  $loginUrl = $helper->getLoginUrl();
 header("Location: ".$loginUrl);
}
?>