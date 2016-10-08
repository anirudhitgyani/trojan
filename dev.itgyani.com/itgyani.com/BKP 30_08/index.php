<?php
include_once('config/ITGStandardPHPPageDBConfig.php');
session_start();
  if (isset($_SESSION["profile"]))
   {      
     // echo '<script> window.location = "studentdashboard.php" </script> ';
   }
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

<link rel="stylesheet" href="css/flip_one/common.css">
<link rel="stylesheet" href="css/flip_one/demo.css">



<link href="css/custom.css" rel="stylesheet">
<!-- Responsive -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link href="css/responsive.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="css/page_switch/pagescroll.css"> 

<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
</head>

<body>

<div class="page-wrapper" id="container" >
<div class="sections" >

    <!--Preloader Box-->
    <!-- <div class="preloader"></div> -->
    
    <!-- Header Start -->
    <header class="main-header" >
     	<nav class="navbar navbar-default main-navigation">
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
                            <li><a href="student.php">Student</a></li>
                            <li><a href="corporate.php">Corporate</a></li>
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
    
    <!--Banner-->
    <section class="section section-1" style="padding-top:0px">
    	
       <!--new_carousel-->
  <div id="carousel-example" class="carousel slide" data-ride="carousel" >
  <ol class="carousel-indicators">
    <li data-target="#carousel-example" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example" data-slide-to="1"></li>
    <li data-target="#carousel-example" data-slide-to="2"></li>
  </ol>

  <div class="carousel-inner">
    <div class="item active">
      <a href="#"><img src="images/Banner_11.jpg" /></a>
      <div class="carousel-caption">
        <!-- <h3>Meow</h3>
        <p>Just Kitten Around</p> -->
      </div>
    </div>
    <div class="item">
      <a href="#"><img src="images/Banner_22.jpg" /></a>
      <div class="carousel-caption">
       <!--  <h3>Meow</h3>
        <p>Just Kitten Around</p> -->
      </div>
    </div>
    <div class="item">
      <a href="#"><img src="images/Banner_33.jpg" /></a>
      <div class="carousel-caption">
        <!-- <h3>Meow</h3>
        <p>Just Kitten Around</p> -->
      </div>
    </div>
  </div>

  <a class="left carousel-control" href="#carousel-example" data-slide="prev">
    <span class="fa fa-chevron-left"></span>
  </a>
  <a class="right carousel-control" href="#carousel-example" data-slide="next">
    <span class="fa fa-chevron-right"></span>
  </a>
</div>
		<!--new_carousel-->
	    <div class="heading-group">
		<h3 class="text-center">One program that guarantees fresh graduates get their first IT job</h3>
	   </div>
	   	  <!--  <p class="text-center arrow"><a href="#below1"><img src="images/explore-arrow.png" alt=""></a></p> -->
	  </section>
    
	<!-- <div class="pagination1" style="width:25px;">
			<ul id="paginacao" class="pagination">
				<li><a href="#one"></a></li>
				<li ><a href="#two"></a></li>
				<li ><a href="#three"></a></li>
			</ul>
		</div> -->
		
		<style>
	<!-- 	.pagination1{position:fixed;right:0px;top:50%;z-index:99}

.pagination>li>a, .pagination>li>span {
    position:relative;display:inline-block;width:15px;height:15px;border-radius:100%;
    float:left;
    padding:6px;
    margin-left:-1px;margin-bottom:5px;
    line-height:1.42857143;
    color:#337ab7;
    text-decoration:none;
    background-color:#fff;
    border:1px solid #72C9F1;
} -->
	</style>
						<!--New_Flip-->
		<div class=" section section-2" id="below1" style="margin-bottom:48px">
		<div class="container" >
        <div class="heading-group " >
            <h1 class="text-center">Real People Real Jobs</h1>
        </div>
        <div class="section__content clearfix">
          <div class="margin_auto">
		  <div class="card effect__random col-md-4 col-xs-12 col-lg-4" data-id="1">
            <div class="card__front">
                <img src="images/ankita.PNG" style="min-width:50px;min-height:50px;  " alt="profile" class="img-responsive">
			<h3 class="back_two">Ankita Kumari</h3>
			<!-- <h5 class="back_two">Perl Developer</h5> -->
			<h3 class="back_two"><strong>Primus Global</strong></h3>
            </div>
            <div class="card__back">
                <img src="images/mukesh.png" alt="profile" class="img-responsive">
			<h3 class="back_one">Mukesh Sinha</h3>
			<!-- <h5 class="back_one">Java Developer</h5> -->
			<h3 class="back_one"><strong>TCS</strong></h3>
            </div>
          </div><!-- /card -->
		  
		  <div class="card effect__random col-md-4  col-xs-12" data-id="2">
            <div class="card__front">
                <img src="images/pallavi.png" alt="profile" class="img-responsive">
			<h3 class="back_two">Pallavi Priya</h3>
			<!-- <h5 class="back_two">Perl Developer</h5> -->
			<h3 class="back_two"><strong>Allegis Tech System</strong></h3>
            </div>
            <div class="card__back">
                <img src="images/rakhi.png" alt="profile" class="img-responsive">
			<h3 class="back_one">Rakhi Pathak</h3>
			<!-- <h5 class="back_one">Java Developer</h5> -->
			<h3 class="back_one"><strong>Oracle India Pvt. Ltd.</strong></h3>
            </div>
          </div><!-- /card -->
		  
		  <div class="card effect__random col-md-4  col-xs-12" data-id="3">
            <div class="card__front">
             <img src="images/Prerna.png" alt="profile" class="img-responsive">
			<h3 class="back_two">Prerna Sharma</h3>
			<!-- <h5 class="back_two">Perl Developer</h5> -->
			<h3 class="back_two"><strong>L&T Infotech</strong></h3>
            </div>
            <div class="card__back">
             	<img src="images/Khushboo.png" alt="profile" class="img-responsive">
			<h3 class="back_one">Khushboo</h3>
	    	<!-- <h5 class="back_one">Java Developer</h5> -->
			<h3 class="back_one"><strong>CitiusTech</strong></h3>
            </div>
          </div><!-- /card -->
		  
		   <div class="card effect__random col-md-4" data-id="4">
            <div class="card__front">
                <img src="images/Vikas.png" alt="profile" class="img-responsive">
			<h3 class="back_two">Vikas Singh</h3>
			<!-- <h5 class="back_two">Perl Developer</h5> -->
			<h3 class="back_two"><strong>Veracitiz</strong></h3>
            </div>
            <div class="card__back">
                <img src="images/Sagar Sengar.png" alt="profile" class="img-responsive">
			<h3 class="back_one">Sagar Sengar</h3>
			<!-- <h5 class="back_one">Java Developer</h5> -->
			<h3 class="back_one"><strong>HSBC</strong></h3>
            </div>
           </div><!-- /card -->
		  
		   <div class="card effect__random col-md-4" data-id="5">
            <div class="card__front">
             <img src="images/Ashutosh_Sharma.png" alt="profile" class="img-responsive">
			<h3 class="back_two">Ashutosh Khus</h3>
			<!-- <h5 class="back_two">Perl Developer</h5> -->
			<h3 class="back_two"><strong>KPIT</strong></h3>
            </div>
            <div class="card__back">
             	<img src="images/Deepak_Sharma.png" alt="profile" class="img-responsive">
			<h3 class="back_one">Deepak Sharma</h3>
			<!-- <h5 class="back_one">Java Developer</h5> -->
			<h3 class="back_one"><strong>Techno Flair Lab Pvt. Ltd.</strong></h3>
            </div>
          </div>
		  
		  <div class="card effect__random col-md-4" data-id="6">
            <div class="card__front">
             <img src="images/Manoj_Mehta.png" alt="profile" class="img-responsive">
			<h3 class="back_two">Manoj Mehta</h3>
			<!-- <h5 class="back_two">Perl Developer</h5> -->
			<h3 class="back_two"><strong>ATOS</strong></h3>
            </div>
            <div class="card__back">
             	<img src="images/Vikram_Sharma.png" alt="profile" class="img-responsive">
			<h3 class="back_one">Vikram Sharma</h3>
			<!-- <h5 class="back_one">Java Developer</h5> -->
			<h3 class="back_one"><strong>Techno Flair Lab Pvt. Ltd.</strong></h3>
            </div>
          </div>
		  
		  <div class="card effect__random col-md-4" data-id="7">
            <div class="card__front">
             <img src="images/Pradeep_Sahoo.png" alt="profile" class="img-responsive">
			<h3 class="back_two">Pradeep Sahoo</h3>
			<!-- <h5 class="back_two">Perl Developer</h5> -->
			<h3 class="back_two"><strong>L&T Infotech</strong></h3>
            </div>
            <div class="card__back">
             	<img src="images/Sandeep_Janardan.png" alt="profile" class="img-responsive">
			<h3 class="back_one">Sandeep Janardan</h3>
			<!-- <h5 class="back_one">Java Developer</h5> -->
			<h3 class="back_one"><strong>Talentain Technologies Pvt. Ltd.</strong></h3>
            </div>
          </div>
		  
		  <div class="card effect__random col-md-4" data-id="8">
            <div class="card__front">
             <img src="images/Prabhat_Akhouri.png" alt="profile" class="img-responsive">
			<h3 class="back_two">Prabhat Akhouri</h3>
			<!-- <h5 class="back_two">Perl Developer</h5> -->
			<h3 class="back_two"><strong>Capgemini</strong></h3>
            </div>
            <div class="card__back">
             	<img src="images/Rati_R_Gavhane.png" alt="profile" class="img-responsive">
			<h3 class="back_one">Rati R Gavhane</h3>
			<!-- <h5 class="back_one">Java Developer</h5> -->
			<h3 class="back_one"><strong>Techno Flair Lab Pvt Ltd</strong></h3>
            </div>
          </div>
          </div>
		 
		</div><!-- /card -->
      </div><!-- /section -->
      </div><!-- /section -->
	
		<!--New_Flip-->
   
    <div class="clearFix"></div>
   
    <!-- Clients Section-->
    <section class="clients section section-3">
    	<div class="container">
		<div class="heading-group center" >
            <h1>Currently Hiring</h1>
        </div>
	
	<div class="slideshow"
    data-cycle-fx="carousel"
    data-cycle-speed="11000"
    data-cycle-timeout="1"
    data-cycle-easing="linear"
    >
		<img src="images/logo1.png">
		<img src="images/logo2.png">
		<img src="images/logo3.png">
		<img src="images/logo4.png">
		<img src="images/logo5.png">
		<img src="images/logo6.png">
	</div>
	
		<div class="row footer_second">
		
		<div class="col-md-4 col-sm-3">
		<h5></h5>
		<ul>
		<li><a href="#"></a></li>
		<li><a href="#"></a></li>
		<li><a href="#"></a></li>
		<li><a href="#"></a></li>
		<li><a href="#"></a></li>
		<li><a href="#"></a></li>
		<li><a href="#"></a></li>
		<li><a href="#"></a></li>
		</ul>
		</div>
		
		<div class="col-md-4 col-sm-3">
		<h5>Techno Flair Lab Private Limited</h5>
		<ul>
                    <li><a href="#">About</a></li>
                    <li><a href="#">The Team</a></li>
		<li><a href="#">News</a></li>
		<li><a href="#">Blog</a></li>
		<li><a href="#">Jobs</a></li>
		<li><a href="#">Legal</a></li>
                <li><a href="#">Contact us</a></li>
		</ul>
		</div>
		
				
		<div class="col-md-4 col-sm-3">
		<h5>Social Media Links</h5>
		<ul class="social_links">
		<li class="fb"><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
		<li class="twi"><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
		<li class="plus"><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
		<li class="linked"><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
		</ul>
		</div>
		
		</div>
		</div>
		
		<footer class="main-footer">
		<!-- Footer Mid -->
        <div class="footer-mid">
        	<div class="auto-box">
			
            	<p>Copyright &copy; 2016, All Right Reserved <a href="#">Techno Flair Lab Private Limited</a></p>
            </div>
        </div>
       
		</footer>
	</section>
 </div>
 
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
<script src="js/flip_one/demo.js"></script>
<script src="js/zenscroll-min.js"></script>

<script>$( '.slideshow' ).cycle();</script>
<script>
$(document).ready(function(){
$('.carousel').carousel({
  interval: 1000 * 10
});

});
</script>

<!--  <script>
    $('a[href*=#]:not([href=#])').click(function() { 
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') || location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
               if (target.length) {
                 $('html,body').animate({
                     scrollTop: target.offset().top
                }, 1000);
                return false;
            }
        }
    });
    </script> -->
	
<script type="text/javascript" src="js/page_switch/PageScroll.js"></script> 
<script type="text/javascript">
	
	$("#container").PageScroll({
		
		selectors : {
			sections : ".sections",
			section : ".section",
			insection : ".insection",
			page : ".pages",
			active : ".active",
			controlPrev : ".control-prev",
			controlNext : ".control-next"
		},
		
		index : 0,	
		
		easing : "ease",		
		
		duration : 500,
		
		loop : false,
		
		pagination : true,
		
		keyboard :true,
		
		direction : "vertical",
		
		callback : ""
	});
	
	</script>	
	
	<script>
	$(document).keydown(function(e) {
	if (e.keyCode === 37) {
	   // Previous
	   $(".carousel-control.left").click();
	   return false;
	}
	if (e.keyCode === 39) {
	   // Next
	   $(".carousel-control.right").click();
	   return false;
	}
});
	</script>
	
	
</body>
</html>