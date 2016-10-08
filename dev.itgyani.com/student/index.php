<?php include('connection.php'); ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>IT Gyani</title>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,500,700,300|Roboto+Condensed' rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script src="js/jquery.cycle2.js"></script>
<script src="js/jquery.cycle2.carousel.js"></script>
</head>

<body>
<header class="header home-header">
<div class="container" style="position:relative;">
<div class="login-buttons"><a href="<?php echo $RootPath; ?>pages/student" class="blue-back student-login">STUDENT</a><a href="<?php echo $RootPath; ?>pages/corporate" class="dark-back corporate-login">CORPORATE</a></div>
<div class="v-center"><a class="logo" href="#"><img src="images/logo.png" /></a><h1>kick start your career</h1>
<p>Get yout first IT job, guaranteed! Too many confusing options, <br/>Which one is yours?</p></div>
</div>

</header>




<div class="middle-content">
<!-- Service Section ----------------->
<div class="service-section container">
<div class="row-fluid blue-back"><div class="col-sm-8 col-md-7 col-xs-12 pull-right text-right"><img src="images/student-images.jpg" /></div><div class="col-sm-4 col-md-5 col-xs-12">
<div class="block-content students"><img src="images/student-icon.svg" />
<h2>STUDENT</h2>
<p>Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut</p>
</div>
</div></div>
<div class="row-fluid dark-back"><div class="col-sm-8 col-md-7 col-xs-12"><img src="images/corporate-images.jpg" /></div><div class="col-sm-4 col-md-5 col-xs-12">
<div class="block-content corporate">
<img src="images/corporate-icon.svg" /><h2>Corporate</h2>
<p>Lorem ipsum dolor sit amet conse ctetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut</p>
</div>
</div></div>
</div>

<!-- Real-peoplejob Section ----------------->
<div class="real-job-section">

<div class="container">
	<div class="row">
		<div class="col-sm-12 col-xs-12 col-md-12">
    	    <h2>Real People Real Jobs</h2>
                <div id="myCarousel" class="carousel slide">
                 
                
                 
                <!-- Carousel items -->
                <div class="carousel-inner">
                    
                <div class="item active">
                	<div class="row-fluid">
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                       <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                	  
                	</div><!--/row-fluid-->
                </div><!--/item-->
                 
                <div class="item">
                	<div class="row-fluid">
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                       <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                	  
                	</div><!--/row-fluid-->
                </div><!--/item-->
                 
                <div class="item">
                	<div class="row-fluid">
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                       <div class="col-sm-4 col-xs-4 col-md-4"><img src="images/real-people-job.jpg" /><p><strong>ram saste</strong> <br/>infosys</p></div>
                	  
                	</div><!--/row-fluid-->
                </div><!--/item-->
                 
                </div><!--/carousel-inner-->
                 
                <a class="left slide-control" href="#myCarousel" data-slide="prev"><i class="fa fa-chevron-left"></i></a>
                <a class="right slide-control" href="#myCarousel" data-slide="next"><i class="fa fa-chevron-right"></i></a>
                </div><!--/myCarousel-->
                 
          
		</div>
	</div>
</div>


</div>
<div class="bottom-section container text-center">
<div class="current-hire">
<h2>Currently hiring</h2>
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

<div class="profile-builder row">
<div class="col-sm-12 col-xs-12 col-md-12 profile-box">
<ul class="odd-menu"><li><a href="about.html">About us</a></li>
<li><a href="our-team.html">The Team</a></li>
<li><a href="#">News</a></li>
<li><a href="#">Blog</a></li>
<li><a href="#">Jobs</a></li>
<li><a href="#">Legal</a></li>
<li><a href="#">Contact us</a></li>
</ul>
</div>
</div>
</div>
</div>

<footer id="footer">
<div class="container">
<a href="#" class="footer-logo"><img src="images/logo.png" /></a>
<div class="social-login footer-login text-center"><p>social media links</p><a href="https://www.facebook.com/ITgyani"><i class="fa fa-facebook"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="https://plus.google.com/u/0/100206678218261154294"><i class="fa fa-google-plus"></i></a><a href="https://www.linkedin.com/company/itgyani"><i class="fa fa-linkedin"></i></a></div>
<p class="copyright">Copyright @ 2016, All Right Reserved Techno Flair Lab Private Ltd.</p>
</div>
</footer>
<script type="text/javascript">
$( document ).ready(function() {
$( '.slideshow' ).cycle();
$( '.slideshow2' ).cycle();
 $(".corporate-login-box").hide();
$(".student-login").click(function(){
    $(".student-login-box").show();
	$(".corporate-login-box").hide();
});
$(".corporate-login").click(function(){
    $(".student-login-box").hide();
	$(".corporate-login-box").show();
});

var $item = $('.home-header .container'); 
var $wHeight = $(window).height();
$item.height($wHeight); 

 $('#myCarousel').carousel({
	    interval: 3000
	});

 
});
$(window).on('resize', function (){
  $wHeight = $(window).height();
  $item.height($wHeight);
});
</script>
</body>
</html>
