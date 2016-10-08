<?php
session_start();
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//http://www.catswhocode.com/blog/php-fast-and-easy-sql-queries-using-ezsql
//http://technoflairlab.com:2082
//User: ITGyani Password: =zir4M0N[3LN
?>
<head>
    
    <style type="text/css" >

body {
	background: #eee !important;	
}

.wrapper {	
	margin-top: 80px;
  margin-bottom: 80px;
}

.form-signin {
  max-width: 380px;
  padding: 15px 35px 45px;
  margin: 0 auto;
  background-color: #fff;
  border: 1px solid rgba(0,0,0,0.1);  

  .form-signin-heading,
	.checkbox {
	  margin-bottom: 30px;
	}

	.checkbox {
	  font-weight: normal;
	}

	.form-control {
	  position: relative;
	  font-size: 16px;
	  height: auto;
	  padding: 10px;
		@include box-sizing(border-box);

		&:focus {
		  z-index: 2;
		}
	}

	#EwebTxtUserID {
	  margin-bottom: -1px;
	  border-bottom-left-radius: 0;
	  border-bottom-right-radius: 0;
	}

	#EwebTxtPassword {
	  margin-bottom: 20px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
}

</style>
</head>


<body>
    <div  class="wrapper" style="background-image: url('Images/BrizBImgProcessing.gif');background-repeat:no-repeat;background-position:center; ">
        <form id="EGuruSignIn" class="form-signin" style="visibility:hidden; ">       
          
            <h2 class="form-signin-heading">Please login</h2>
            <br><br>
            <input id="EwebTxtUserID" data-tooltip="Company Name To Register !!!" data-tooltip-more="Min:10 Char's & Max: 50 Char's." data-tooltip-animate-function="roll" data-tooltip-color="hot pink" data-tooltip-delay="500" data-tooltip-maxwidth="280" data-tooltip-stickto="top"  type="text" class="form-control" name="username" placeholder="Email Address" required="" autofocus="" />
            <br><br>
            <input id="EwebTxtPassword" type="password" class="form-control" name="password" placeholder="Password" required=""/>      
            <br><br>
            <button id="EwebBtnLogin" class="btn btn-lg btn-primary btn-block" type="button">Login</button>   
        </form>
  </div>
    
</body>


<?php

include_once('config/ITGStandardPHPPageDBConfig.php');

//$_SESSION['ITG001'] = "get";
//unset($_SESSION['ITG001']);
// $_SESSION["UserInfo"]
if(isset($_SESSION['UserInfo']))
{ 
  header('Location: '. "ITGPhpPageDesktop.php");

}
else
{    
   // include_once('API/ITGStandardPHPPageLogin.php');
}

?>
<script type="text/javascript" src="CoreJS.js"></script>
    <link rel="stylesheet" type="text/css" href="CoreCSS.css" />
    <script src="JsAjax/ITGStandardJSPageLogin.js"></script>