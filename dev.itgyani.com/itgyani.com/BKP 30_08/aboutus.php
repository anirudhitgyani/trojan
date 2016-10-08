<?php
session_start();
  if (isset($_SESSION["profile"]))
   {      
     // echo '<script> window.location = "studentdashboard.php" </script> ';
   }
   
include_once('config/ITGStandardPHPPageDBConfig.php');


/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>IT GYANI</title>
<!-- Stylesheets -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/owl.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet" href="css/demo-slideshow.css">
<link href="css/custom.css" rel="stylesheet">


<!-- Responsive -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link href="css/responsive.css" rel="stylesheet">
<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<script src="https://connect.facebook.net/en_US/all.js#xfbml=1"></script>
<script>
	

	
	  
	</script>
</head>

<body>
    <div id="fb-root"></div>

<div class="page-wrapper" >
    <!--Preloader Box-->
    <!-- <div class="preloader"></div> -->
    
    <!-- Header Start -->
    <header class="main-header student" >
     	<nav class="navbar navbar-default main-navigation" style="">
      	<div class="container">
        	<div class="row">
            	<div class="pull-left col-md-3 col-sm-4"><a class="logo" href="index.php" ></a></div>
               <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    </button>
                </div>
               <div class="col-md-9 col-sm-8 pull-right">
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <!-- <li><a href="corporate.php">Corporate</a></li> -->
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                </div>
            	<div class="clearfix"></div>
            </div>
        </div>
      	</nav>
    </header>
    <!-- END Header -->
    
	
	<!-- <div class="col-md-2">
	<div class="login_box text-center">
	<img src="images/logoadmin.png" alt="logo">
	<p>Sign in Your Account</p>
	<form class="login_form" action="">
	<div class="form-group">
	<p><input type="text" placeholder="Email" class="form_input"></p>
	<p><input type="text" placeholder="Password" class="form_input"></p>
	</div>
	</form>
	
	<p><a href="#">Forgot Password</a></p>
	<p><button type="button" class="btn btn-primary">Login</button></p>
	<p><button type="button" class="btn btn-sm">Register Now</button></p>
	</div>
	</div> -->
	<style>
	.login_section .btn_one p{margin-right:60px;margin-top:7px}
	</style>
	 <section class="login_section">
		<div class="container">
		<div class="row">
		
		<div class="col-md-3 col-sm-4">
		<div class="btn_one" >
		<p class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"><img src="images/Pricing Tab.png"></a></p>
		<!-- <p class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal"><img src="images/Free registration open.png"></a></p>-->
		</div> 
		</div>
		
		<div class="col-md-9 col-sm-8   col-xs-6 ">
		<form class="login_form" action="">
			<div class="row">
				<div class="col-md-3 col-sm-4 input_feilds">
					<p>Email</p>				
					<div class="form-group">
						<input type="text" id='ITGTxtLoginID' placeholder="" class="form_input">
					</div>					
				</div>			
				<div class="col-md-3 col-sm-4 input_feilds">
					<p>Password</p>
					<div class="form-group">
                                            <input id='ITGTxtPassword' type="password" placeholder="" class="form_input">
							<p class="pass"><a href="#">Forgot Password?</a></p>
						</div>					
				</div>				
				<div class="col-md-2 col-sm-4 login_btn">
					<button type="button" id='SignInUp' class="btn btn-primary login_button"  >Sign in / Sign up</button>
                                        <img id='ITGImgSignUp' src="images/WaitLoading.gif" width="100" height="40" style="display:none; margin-top:-10  " >
					<!-- data-target="#myModal2" <button type="button" class="btn btn-primary login_button1 bounce_demo" data-toggle="modal" data-target="#myModal">Sign up</button>  -->
				</div>
				
				<div class="col-md-4 col-sm-4 login_btn">
					 <p style="margin-top:-23px">OR Sign in with</p>
					 <div class="row" style="margin-top:3px">
                                             <div class="col-md-3"><a id="login" href="#" onclick=
                                                                    "  
                                                                      ">
                                                     <div class="social_image">
                                                         <img id='ITGImgFacebook' src="images/fb.jpg" style="width:35px;height:35px">
                                                         <img id='ITGImgSocial' src="images/WaitLoading.gif" width="100" height="40" style="display:none;  " >
                                                     </div></a>
                                             </div>
                                                                      
					<!-- <div class="col-md-3"><a href="#"><div class="social_image1"><img src="images/g_plus.jpg" style="width:35px;height:35px"></div></a></div> -->
					</div>
				</div>
				
			</div>
		</form>
		</div>
		</div>
		</div>
	</section>
	
	<!--modal_one-->
	<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
         
		  <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Close</button>
          <h2 class="modal-title text-center" style="display:inline-block">Registration Form</h2>          
        </div>
        <div class="wodry"></div>
        <div class="modal-body">
          <div class="row">
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Name:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <input id='ITGStudentName' type="text" class="form-control error" placeholder="Your Name">
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Country:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <select class="form-control">
                    <option value="1">India</option>
                    <option value="2">UK</option>
                    <option value="2">PAK</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Course Applied For:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <select class="form-control">
                    <option value="1">Java</option>
                    <option value="2">Scala</option>
                    <option value="3">Php</option>
                    <option value="4">Dot net</option>
                    <option value="5">Android</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Qualification:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <select class="form-control">
                    <option value="1">BE</option>
                    <option value="2">MCS</option>
                    <option value="3">MCA</option>
                    <option value="4">B.Tech</option>
                    <option value="4">B.C.S</option>
                  </select>
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Institute Name:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Institute Name">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Contact No:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Contact No">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Address:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Address">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Email-Id:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Email-Id">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>User Name:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="User Name">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Password:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Password">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Upload Resume:</label>
              </div>
              <div class="col-md-5 col-sm-5">
                <div class="form-input">
                  <input type="file">
                </div>
              </div>
              <div class="col-md-3 col-sm-3">
                <button type="button" class="btn btn-instagram btn-sm">Buy Now</button>
              </div>
              <div class="col-md-2 col-sm-2">
                <button type="button" class="btn btn-instagram btn-sm">Submit</button>                                
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
         <!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
        </div>
      </div>
    </div>
  </div>
	<!--modal_one-->
	
	<!--modal_two-->
	<div class="modal fade" id="myModal1" role="dialog">
    <div class="modal-dialog modal-lg modal_price">
      <div class="modal-content">
        <div class="modal-header text-center">
         <button type="button" class="btn btn-default pull-right" style="position:absolute;right:18px;top:8px" data-dismiss="modal">x</button>
          <h4 class="modal-title text-center" style="display:inline-block;color:#000">The ITGYANI Program - Get your first IT job. </h4>
        </div>
        <div class="wodry"></div>
        <div class="modal-body">
          <div class="row">
           <div class="col-md-8 col-sm-8 col-sm-offset-2 col-lg-8 col-lg-offset-2 col-md-offset-2" >
		   <!-- <p class="text-center">â€œKnow What You Love, Love What You Knowâ€?</p> -->
		<div class="table-responsive">
		<table class="table table-bordered">
		<thead>
		<tr>
		<th style="width:243px"></th>
		<th style="text-align:center">Free</th>
		<th style="text-align:center"><i class="fa fa-inr" aria-hidden="true"></i> 25000/- </th>
		</tr>
		</thead>
		
		<tbody>
		<tr>
		<td>Aptitude test</td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Foundation course</td>
		<td style="color:orange">Partial</td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Guarantee</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Counseling</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Trainer access</td>
		<td style="color:orange">Partial</td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Psychometric evaluation</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Specialized training tests</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes<i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Corporate access</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Interview preparation</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Live environment training</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		</tbody>
		</table>
		</div>
			<div class="two_buttons">
			<!-- <div class="col-md-5 col-sm-5"></div>
			<div class="col-md-3 col-sm-3"> -->
                <button type="button" class="btn btn-info join">Join Free <span class="fa fa-sign-in" ></span></button>
              <!-- </div> -->
			 <!--  <div class="col-md-1 col-sm-1"></div>
              <div class="col-md-3 col-sm-3"> -->
                <button type="button" class="btn  btn-info buy_now">Buy Now <span class="fa fa-money" ></span></button>
             <!--  </div> -->
             </div>
		<div class="clearFix"></div>
		</div>
          </div>
        </div>
        <div class="modal-footer">
			<p class="text-center" style="font-family:lucida sans;font-size:16px;font-weight:bold">Know What You Love, Love What You Do!</p>
          <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
        </div>
      </div>
    </div>
  </div>
	<!--modal_two-->
	
	<!--modal_three-->
	<div class="modal hide" id="myModal2" role="dialog">
    <div class="modal-dialog modal-lg modal_reg">
      <div class="modal-content">
        <div class="modal-header">
         
		  <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Close</button>
          <h2 class="modal-title text-center" style="display:inline-block">Registration Form</h2>
        </div>
        <div class="wodry"></div>
        <div class="modal-body">
          <div class="row">
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-4 col-sm-4">
                <label>Email:</label>
              </div>
              <div class="col-md-8 col-sm-8">
                  <input id='ITGRegisterationEmail' type="text" class="form-control error" placeholder="Email Id">
              </div>
            </div>
            
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-4 col-sm-4">
                <label>First name:</label>
              </div>
              <div class="col-md-8 col-sm-8">
                  <input id='ITGRegisterationFirstName' type="text" class="form-control error" placeholder="First name">
              </div>
            </div>
            
            
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-4 col-sm-4">
                <label>Last name:</label>
              </div>
              <div class="col-md-8 col-sm-8">
                  <input id='ITGRegisterationLastName' type="text" class="form-control error" placeholder="Last name">
              </div>
            </div>
            
            
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-4 col-sm-4">
                <label>Mobile:</label>
              </div>
              <div class="col-md-8 col-sm-8">
                  <input id='ITGRegisterationMobile' type="text" class="form-control error" placeholder="Mobile">
              </div>
            </div>
            
            
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-4 col-sm-4">
                <label>DOB:</label>
              </div>
              <div class="col-md-8 col-sm-8">
                  <input id='ITGRegisterationDOB' type="text" class="form-control error" placeholder="DOB">
              </div>
            </div>
            
            
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-4 col-sm-4">
                <label>Gender:</label>
              </div>  
              <div class="col-md-2 col-sm-4">
                  <input id='ITGRegisterationGender1'checked="checked" type="radio" name="gender" class="form-control error" value="Male" > Male
              </div>
              <div class="col-md-2 col-sm-4">
                  <input id='ITGRegisterationDOBGender2' type="radio" name="gender" class="form-control error" value="Female" > Female
              </div>
            </div>
            
		

			 <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-4 col-sm-4">
                <label>Password:</label>
              </div>
              <div class="col-md-8 col-sm-8">
                  <input id='ITGRegisterationPassword' type="password" class="form-control error" placeholder="Password">
              </div>
            </div>
			 <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-4 col-sm-4">
                <label>Confirm Password:</label>
              </div>
              <div class="col-md-8 col-sm-8">
                <input id='ITGRegisterationPasswordConfirm' type="password" class="form-control error" placeholder="Confirm Password">
              </div>
            </div>
         
          
            <div class="form-group col-md-12 col-sm-12">
             <div class="col-md-10 col-sm-10">
                <!-- <button type="button" class="btn btn-instagram btn-sm">Buy Now</button> -->
              </div>
              <div class="col-md-2 col-sm-2">
                <button id='ITGBtnSubmit' type="button" class="btn btn-instagram btn-sm pull-right">Submit</button>
                <img id='ITGImgSubmit' src="images/WaitLoading.gif" width="100" height="40" style="display:none;margin-left: -30px; " >
                
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
         <!--  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
        </div>
      </div>
    </div>
  </div>
	<!--modal_three-->
	
	
	 <style>
	/*.social_image{background-image:url('images/fb.png');background-position: -0px 0px;width:78px;height:30px;line-height:30px;
					background-repeat:no-repeat;position:static;}
	.social_image1{background-image:url('images/Google+1.jpg');width:78px;height:30px;line-height:30px;} */
						
		
	</style> 
   <section class="browse-topics slider_one" style="position:relative;padding-top:44px;padding-bottom:66px">
    	<div class="container">
		
		
		
		<div class="row" style="margin-top:20px">
		
	   <div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Knowledge transfer.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Knowledge transfer</h4> -->
			</div>
			<div class="back face center">
			<p>We test you to ensure that the content has been understood</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Personalized counselling.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Personalized counselling</h4> -->
			</div>
			<div class="back face center">
			<p>Based on your aptitude, behavioural skills, foundation training scores and market demand.</p>
			</div>
			</div>
		</div>
		</div>
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Unique Process.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Unique process</h4> -->
			</div>
			<div class="back face center">
			<p>Aptitude and Psychometric evaluation, Foundation courses, specialization based on  Personal Counselling, live environment training,etc.</p>
			</div>
			</div>
		 </div>
        </div>
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Psychometric evaluation.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Psychometric evaluation</h4> -->
			</div>
			<div class="back face center">
			<p>Our proprietary measuring tool BPCM, to measure skills and behavioural competencies with respect to the job profile</p>
			</div>
			</div>
		 </div>
		</div>
		
		</div>
		
		<div class="row" style="margin-top:20px">
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Live environment training.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Live environment training</h4> -->
			</div>
			<div class="back face center">
			<p>Apply your skills to projects. </p>
			</div>
			</div>
		 </div>
        </div>
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Campus Selection.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Campus selection</h4> -->
			</div>
			<div class="back face center">
			<p>You could land your job as soon as you graduate, because you would know more and be "floor ready"</p>
			</div>
			</div>
		 </div>
		</div>
		
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/24 X 7 support.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">24 X 7 support</h4> -->
			</div>
			<div class="back face center">
			<p>Get answers to specific queries..  Even if not in dB your queries will be answered.</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Softskill.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">24 X 7 support</h4> -->
			</div>
			<div class="back face center">
			<p> Soft skills training - Customized behavioral and language courses, all the way to interview prep.</p>
			</div>
			</div>
		 </div>
       </div>
		
		</div>
		</div>
	</section>	

    <footer class="main-footer">
		<div class="footer-mid">
			<div class="container">
			<div class="row  text-center">
			<div class="col-md-12">
			<ul class="col-md-8 col-md-offset-2">
                            <li><a href="#">About</a></li>
                        <li><a  href="student.php">Student</a></li>
			<li><a href="corporate.php">Corporate</a></li>
                        <li><a href="#">The Team</a></li>
			<li class="right_space" style="padding-right:21px"><a href="#">News</a></li>
			<li class="right_space" style="padding-right:21px"><a href="#">Blog</a></li>
			<li class="right_space" style="padding-right:21px"><a href="#">Jobs</a></li>
			<li class="right_space" style="padding-right:21px"><a href="#">Legal</a></li>
			<li><a href="#">Contact us</a></li>
		</ul>
		</div>
		</div>
		</div>
        	<div class="auto-box">
            	<p>Copyright &copy; 2016, All Right Reserved <a href="#">Techno Flair Lab Private Ltd.</a></p>
            </div>
        </div>
    </footer>
	
	<style>
	.main-footer ul li{float:left;text-align:center;padding:6px 16px}
	.main-footer ul li a{text-align:center}
	.right_space{padding-right:18px}
	</style>
	<!--last_form-->
  <div  title="Scroll Back to Top" style="position: fixed; bottom: 12px; right: 0px; opacity: 1; cursor: pointer;z-index:9999;">
        <div  id="collapseExample"  class="collapse" aria-expanded="false" >
        <div class="well" style="padding:5px 10px 5px 15px">
                    <form action="post" name="question" method="post" onsubmit="">
            <div class="form-group" style="margin-bottom:5px;">
              <label for="email">Name:</label>
              <input type="text" class="form-control form_footer" name="name" value="">
            </div>
            <div class="form-group" style="margin-bottom:5px;">
              <label for="email">Email address:</label>
              <input type="email" class="form-control form_footer" name="email" value="">
            </div>
            <div class="form-group" style="margin-bottom:5px;">
              <label for="pwd">Mobile no:</label>
              <input type="text" class="form-control form_footer" name="phone" value="">
            </div>
                       
            <input type="submit" name="question_submit" class="btn btn-info" value="Submit">
           
          </form>
        </div>
      </div>
      <a data-toggle="collapse" href="#collapseExample" aria-expanded="false"   aria-controls="collapseExample">
      <button type="button" class="btn btn-success active" >Chat</button></a> 
     </div>
<!--last_form-->
	
</div>
<!--End pagewrapper-->
<!-- https://console.developers.google.com/apis/credentials/consent?project=itgyani-1367 -->
<script src="js/jquery.js"></script> 
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.appear.js"></script>
<script src="js/bxslider.js"></script>
<script src="js/owl.js"></script>
<script src="js/jquery.easing.min.js"></script>
<script src="js/script.js"></script>

<script src="js/jquery.cycle2.js"></script>
<script src="js/jquery.cycle2.carousel.js"></script>
<script src="js/sdk.js"></script>
<script src="js/platform.js" async defer></script>
<script src="JsAjax/ITGStudent.js"></script>
<script src="js/bootbox.min.js"></script>
<script src="js/BrizBStandardJSPageStandardCodeGallery.js"></script>

<script>$( '.slideshow' ).cycle();</script>

</body>
</html>


