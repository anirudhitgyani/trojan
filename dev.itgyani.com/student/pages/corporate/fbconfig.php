<?php
include('../../connection.php');
$redirect_link = $RootPath."pages/corporate/fbconfig.php";
//session_start();      
// added in v4.0.0
require_once 'autoload.php';
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
FacebookSession::setDefaultApplication( $fb_api_key,$fb_secret_key );
// login helper with redirect_uri
    //$helper = new FacebookRedirectLoginHelper('http://itgyani.com/staging/pages/student/fbconfig.php' );
    $helper = new FacebookRedirectLoginHelper($redirect_link);
try {
  $session = $helper->getSessionFromRedirect();
} catch( FacebookRequestException $ex ) {
  // When Facebook returns an error
} catch( Exception $ex ) {
  // When validation fails or other local issues
}
// see if we have a session
if ( isset( $session ) ) {
    //include('../../connection.php');
   //mysql_connect("localhost","technofl_stiff","Stiff@Solutions") or die(mysql_error());
   //mysql_select_db("technofl_stiff") or die(mysql_error());
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
             //$_SESSION['user_id'] = $fbid;  
         $_SESSION['FULLNAME'] = $fbfullname;
	     $_SESSION['EMAIL'] =  $femail;
    /* ---- header location after session ----*/
            
            
            //exit();
            
        $check = mysql_query("select * from `registered_users` where fb_id='".$fbid."'") or die(mysql_error());
        $check = mysql_num_rows($check);

	if (empty($check)) { // if new user . Insert a new record		

	
            $sql = mysql_query("insert into `registered_users` set fb_id = '".$fbid."' , first_name = '".$first_name."' , last_name = '".$last_name."' , user_name = '".$fbfullname."' , email = '".$femail."' , status = '1' ") or die(mysql_error());

            $LastID = mysql_insert_id();

            $_SESSION["user_id"] = $LastID;
        
        } else {
            
            $sql = mysql_query("update `registered_users` set first_name = '".$first_name."' , last_name = '".$last_name."' ,  user_name = '".$fbfullname."' , email = '".$femail."' , status = '1' where fb_id = '".$fbid."'  ") or die(mysql_error());

            $sql1 = mysql_query("select * from `registered_users` where fb_id = '".$fbid."' ");
            $row1 = mysql_fetch_array($sql1);
            //$_SESSION["id"] = $row1['id'];
            $_SESSION['user_id'] = $row1['id'];
           
            
        }
        
    header("location:".$RootPath."pages/corporate");
    //exit();    
  //header("Location: dashboard.php");
} else {
  $loginUrl = $helper->getLoginUrl();
 header("Location: ".$loginUrl);
}
?>