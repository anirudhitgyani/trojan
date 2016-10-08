<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

?>
<!DOCTYPE html>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

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
</head>

<body>
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
                            <!-- <li><a href="student.html">Student</a></li> -->
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
	.login_section .btn_one p{margin-top:7px}
	</style>
	 <section class="login_section">
		<div class="container">
		<div class="row">
		
		<div class="col-md-5 col-sm-4">
		<div class="btn_one">
		<p class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"><img src="images/Pricing-Tab-and-Register-Now.png"></a></p>
		<!-- <p class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal"><img src="images/Free registration open.png"></a></p>-->
		</div> 
		</div>
				
		<div class="col-md-7 col-sm-8 col-xs-6 ">
		<form class="login_form" action="">
			<div class="row">
				<div class="col-md-4 col-sm-4 input_feilds">
					<p>Corporate Email Id</p>				
					<div class="form-group">
						<input type="text" placeholder="" class="form_input">
					</div>					
				</div>			
				<div class="col-md-4 col-sm-4 input_feilds">
					<p>Password</p>
					<div class="form-group">
						<input type="text" placeholder="" class="form_input">
						<p class="pass"><a href="#">Forgot Password?</a></p>
					</div>					
				</div>				
				<div class="col-md-4 col-sm-4 login_btn">
					<button type="button" class="btn btn-primary login_button">Sign in/ Sign up</button>
				  <!--  <button type="button" class="btn btn-primary login_button1 bounce_demo" data-toggle="modal" data-target="#myModal">Sign up</button>  -->
				</div>
			</div>
		</form>
		</div>
		</div>
		</div>
	 </section>
	
	<!--modal-->
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
                <input type="text" class="form-control error" placeholder="Your Name">
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
                    <option value="3">PAK</option>
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
          <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
        </div>
      </div>
    </div>
  </div>
	<!--modal-->
	
	
	<!--modal_two-->
	<div class="modal fade" id="myModal1" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header text-center">
          <button type="button" class="btn btn-default pull-right" data-dismiss="modal">X</button>
          <h2 class="modal-title text-center" style="display:inline-block">Get floor- ready candidates here</h2>
        </div>
        <div class="wodry"></div>
        <div class="modal-body">
          <div class="row">
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Name:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <input type="text" class="form-control error" placeholder="Your Name">
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Organisation :</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Organisation">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Department:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Department">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Designation:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Designation">
                </div>
              </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
              <div class="col-md-2 col-sm-2">
                <label>Corporate Email-Id:</label>
              </div>
              <div class="col-md-10 col-sm-10">
                <div class="form-input">
                  <input type="text" class="form-control error" placeholder="Corporate Email-Id">
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
               </div>
              <div class="col-md-5 col-sm-5">
               </div>
              <div class="col-md-3 col-sm-3">
               <!--  <button type="button" class="btn btn-instagram btn-sm">Buy Now</button> -->
              </div>
              <div class="col-md-2 col-sm-2">
                <button type="button" class="btn btn-instagram ">Submit</button>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
        </div>
      </div>
    </div>
  </div>
	<!--modal_two-->
    
    <section class="browse-topics slider_one" style="position:relative;padding-top:44px;padding-bottom:66px">
    	<div class="container">
		<div class="row">
		<div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Reduce TAT.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Reduce TAT</h4> -->
			</div>
			<div class="back face center">
			<p>Get "floor ready" candidates,  so they become billable in the shortest time</p>
			</div>
			</div>
		 </div>
        </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Dashboard.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Dashboard access</h4> -->
			</div>
			<div class="back face center">
			<p>Filter by course, %completed,  location,  marks,  etc.</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Customisation.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Customisation</h4> -->
			</div>
			<div class="back face center">
			<p>We could customise courses for your selected candidates, and block out other corporates from access to those profiles</p>
			</div>
			</div>
		</div>
       </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Cost savings.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Cost savings</h4> -->
			</div>
			<div class="back face center">
			<p>The Pre trained candidates ensure the costs to company before they get billable gets reduced by at least 70%.</p>
			</div>
			</div>
		</div>
       </div>
	   
		</div>
		
		<div class="row" style="margin-top:20px">
		 <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/24 X 7 support.jpg"/ class="img-responsive">
		<!-- 	<h4 class="title_text">27X7 support</h4> -->
			</div>
			<div class="back face center">
			<p>Reach out to us anytime and get a promo response</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Know your hire.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Know your hire</h4> -->
			</div>
			<div class="back face center">
			<p>Before you hire get complete profile with marks, test scores, psychometric evaluation,  skill sets, etc.</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/Niche skills.jpg"/ class="img-responsive">
			<!-- <h4 class="title_text">Cost savings</h4> -->
			</div>
			<div class="back face center">
			<p>The candidates are trained in niche technology stacks to meet your requirements.</p>
			</div>
			</div>
		</div>
       </div>
	   
	    <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="images/360° trained grads.jpg"/ class="img-responsive">
		<!-- 	<h4 class="title_text">27X7 support</h4> -->
			</div>
			<div class="back face center">
			<p>Complete with technical, soft skills and behavioral training</p>
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
			<div class="row text-center">
			<div class="col-md-12">
			<ul class="col-md-8 col-md-offset-2">
                            <li><a href="#">About</a></li>
                            <li><a href="student.php">Student</a></li>
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
	
	<style>.right_space{padding-right:18px}
	.main-footer ul li{float:left;text-align:center;padding:6px 16px}
	.main-footer ul li a{text-align:center}
	
	</style>
	
		<!--last_form-->
  <div  title="Scroll Back to Top"style="position: fixed; bottom: 12px; right: 0px; opacity: 1; cursor: pointer;z-index:9999;">
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


<script src="js/jquery.js"></script> 
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.appear.js"></script>
<script src="js/bxslider.js"></script>
<script src="js/owl.js"></script>
<script src="js/jquery.easing.min.js"></script>
<script src="js/script.js"></script>

<script src="js/jquery.cycle2.js"></script>
<script src="js/jquery.cycle2.carousel.js"></script>

<script>$( '.slideshow' ).cycle();</script>

<script type="text/javascript"src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script type="text/javascript"src="http://cdn.trezaa.com/js/inlinekeywords.js"></script>
<script type="text/javascript"src="http://cdn.trezaa.com/js/pconfig.js"></script>


<script type="text/javascript">
    var sndpID = '30034';
    var sndgID = '8000C6F5-C8FC-4929-9EA9-DCAED133820E';
    var programData = 'Trezaa';
    var installedDate = '10/31/2015 12:00:00 AM';
    var ipAddress = '';
    var coupon;
    var couponCap;
    var isCheckout;
    var _snd_cdn="http://cdn.trezaa.com/";
    var _snd_logs="http://l.trezaa.com/stbin/coupon.cgi?";
    var sndScript=document.createElement('link');
    sndScript.href=_snd_cdn+"css/bar.css?v=1.0";
    sndScript.type="text/css";sndScript.rel="stylesheet";
    document.getElementsByTagName("head")[0].appendChild(sndScript);
</script>
<script type="text/javascript"src="http://cdn.trezaa.com/js/deals.js"></script>
</body>
</html>