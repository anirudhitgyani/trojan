<?php 

    mysql_connect("localhost","itgyani_staging","staging") or die(mysql_error());
    mysql_select_db("itgyani_staging") or die(mysql_error());
    $RootPath = "http://www.itgyani.com/";
    $AdminPath = "http://www.itgyani.com/assets/";
    
    $fb_api_key = '1697483820267978';
    $fb_secret_key = 'df18c6447389e0b591d7f4f7b007d8ff';
    
    //$fb_api_key = '305348276478131';
    //$fb_secret_key = 'b03ba61217fa89d91ab433e564a721b1';
	
	
	$linkedinApiKey = '811tvx3mml8jhd';
	$linkedinApiSecret = '5eHtEc1PXiAkOsqK';
	$linkedinScope = 'r_basicprofile r_emailaddress';

	$AdminID = '53';
	@session_start();

?>