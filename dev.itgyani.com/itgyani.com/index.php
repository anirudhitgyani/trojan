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
<div class="login-buttons">
    <?php if(!isset($_SESSION['ProfileID'])) { ?>
        <a href="<?php echo $RootPath; ?>pages/student" class="blue-back student-login">STUDENT</a>
    <?php } ?>
    <?php if(!isset($_SESSION['stud_id'])) { ?>
        <a href="<?php echo $RootPath; ?>pages/corporate" class="dark-back corporate-login">CORPORATE</a>
    <?php } ?>
</div>
<div class="v-center"><a class="logo" href="#"><img src="images/logo.png" /></a><h1>DISCOVER.CHOOSE.KNOW</h1>
<h2>Empowered To Learn.</h2></div>
</div>

</header>




<div class="middle-content">
<!-- Service Section ----------------->
<div class="service-section container">
<div class="row-fluid blue-back"><div class="col-sm-8 col-md-7 col-xs-12 pull-right text-right"><img src="images/student-images.jpg" /></div><div class="col-sm-4 col-md-5 col-xs-12">
<div class="block-content students"><img src="images/student-icon.svg" />
<h2>STUDENT</h2>
<h5>One program that ensures you get your first IT job.</h5>
<p>Get Everything  you need to qualify for your first break in IT. Best content from basic foundation courses to specialisation based on personalised counselling. You can learn both technical and soft skills at your own pace from anywhere!</p>
</div>
</div></div>
<div class="row-fluid dark-back"><div class="col-sm-8 col-md-7 col-xs-12"><img src="images/corporate-images.jpg" /></div><div class="col-sm-4 col-md-5 col-xs-12">
<div class="block-content corporate">
<img src="images/corporate-icon.svg" /><h2>Corporate</h2>
<h5>Get Pretrained candidates.</h5>
<p>Campus recruitment based your skill requirement and candidates complete profile, right from your office! View performance and history and screen from thousands of resumes based on business unit requirements. Achieve unbelievable TAT for billable resources.</p>
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
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Naveen.jpg" /><p><strong>Naveen Sharma</strong> <br/>Tech Mahindra</p></div>
                      <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Khushboo.jpg" /><p><strong>Khushboo Sharma</strong> <br/> Citius Tech</p></div>
                      <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Vikas.jpg" /><p><strong>Vikas Singh</strong> <br/> Veracitiz</p></div>
                	
                	  
                	</div><!--/row-fluid-->
                </div><!--/item-->
                 
                <div class="item">
                	<div class="row-fluid">
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Sandeep.jpg" /><p><strong>Sandeep Janardan</strong> <br/>Talentain Technologies Pvt. Ltd.</p></div>
                      <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Pradeep.png" /><p><strong>Pradeep Sahoo</strong> <br/>L & T Infotech</p></div>
                      <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Pankaj.jpg" /><p><strong>Pankaj Goel</strong> <br/>ZTE Corporation</p></div>
                	  
                	</div><!--/row-fluid-->
                </div><!--/item-->
                 
                <div class="item">
                	<div class="row-fluid">
                	  <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Nilesh.jpg" /><p><strong>Nilesh Deolkar</strong> <br/>Emphasis</p></div>
                      <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Nitin.jpg" /><p><strong>Nitin Sharma</strong> <br/>Internet Office Pvt Ltd</p></div>
                      <div class="col-sm-4 col-xs-4 col-md-4"><img class="img-circle" src="images/students/Kailash.jpg" /><p><strong>Kailash Kaushik</strong> <br/> DCB Bank</p></div>
                	  
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
<h2>Currently Hiring</h2>
<div class="slideshow"
    data-cycle-fx="carousel"
    data-cycle-speed="11000"
    data-cycle-timeout="1"
    data-cycle-easing="linear"
    >
		<img src="images/core1.png">
		<img src="images/neptune.png">
		<img src="images/kaps1.png">
		<img src="images/airvak1.PNG">
		<img src="images/lapp.png">
		<img src="images/yellow.png">
                <img src="images/oyster.PNG">
	</div>
    <!--
<div class="profile-builder row">
<div class="col-sm-12 col-xs-12 col-md-12 profile-box">
<ul class="odd-menu"><li><a href="<?php // echo $RootPath; ?>pages/about/">About us</a></li>
<li><a href="#">The Team</a></li>
<li><a href="#">News</a></li>
<li><a href="#">Blog</a></li>
<li><a href="#">Jobs</a></li>
<li><a href="#">Legal</a></li>
<li><a href="#">Contact us</a></li>
</ul>
</div>
</div>-->
</div>
</div>

<footer id="footer">
<div class="container">
<a href="#" class="footer-logo"><img src="images/logo.png" /></a>
<!--
<div class="social-login footer-login text-center"><p>social media links</p>
<a href="https://www.facebook.com/ITgyani"><i class="fa fa-facebook"></i></a>
<a href="#"><i class="fa fa-twitter"></i></a>
<a href="https://plus.google.com/u/0/100206678218261154294"><i class="fa fa-google-plus"></i></a><a href="https://www.linkedin.com/company/itgyani"><i class="fa fa-linkedin"></i></a>
</div>
-->
<div class="social-login footer-login text-center">
    <p>social media links</p>
        <a target="_blank"  href="https://www.facebook.com/ITgyani"><i class="fa fa-facebook"></i></a>
        <a target="_blank" href="https://twitter.com/info_itgyani"><i class="fa fa-twitter"></i></a>
        <a target="_blank" href="https://plus.google.com/u/0/100206678218261154294"><i class="fa fa-google-plus"></i></a>
        <a target="_blank" href="https://www.linkedin.com/company/itgyani"><i class="fa fa-linkedin"></i></a>
</div>

<div class="footer-menu">
<a href="<?php echo $RootPath; ?>pages/about/">About us</a>
<a href="<?php echo $RootPath; ?>pages/our-team/">The Team</a>
<a href="#">News</a>
<a href="#">Blog</a>
<a href="<?php echo $RootPath; ?>pages/Jobs/">Jobs</a>
<a href="<?php echo $RootPath; ?>pages/terms/">Legal</a> 
<a href="<?php echo $RootPath; ?>pages/contact-us/">Contact us</a>
</div>
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