<?php include('connection.php');
include('header.php'); ?>

<div class="middle-content">
<div class="container static-page text-left">
<h2 class="page-title">Current Opening</h2>
<div class="row">
<div class="col-sm-3 col-xs-12 col-md-5 text-center"><img src="<?php echo $RootPath; ?>images/job11.jpg" /></div>
<div class="col-sm-9 col-xs-12 col-md-7"><h4>Senior Content Manager</h4><p><strong>Single Position to fill for Senior Content Manager
</strong><strong></br></br>Location - </strong> Pune, INDIA</br></br><strong>Position Type - </strong> Permanent</br></br><strong>Responsibility - </strong>You will be responsible for managing website blogs, article section available on the website. You will also proofread and structure raw content and then put it in simple and easy way to form easy to understand tutorials and e-books, which can be used for self-learning purpose.</br></br><strong>Renumeration - </strong> The best in Industry</br></br><strong>Experience - </Strong> Minimum 4-5 years of experience in Content Preparation, Training, Presentation, Promotion and overall Management.</br></br></p></div>
</div>

<hr />
<div class="row">
<div class="col-sm-3 col-xs-12 col-md-5 text-center pull-right"><img src="<?php echo $RootPath; ?>images/job12.jpg" /></div>
<div class="col-sm-9 col-xs-12 col-md-7"><h4>Subject Matter Experts</h4><p><strong>4 Positions to fill for Subject Matter Experts with writing skills 
</strong><strong></br></br>Location - </strong> Pune, INDIA</br></br><strong>Position Type - </strong>Permanent, Contract Basis and Freelancers, choose what suits you.</br></br><strong>Responsibility - </strong> You will be responsible for doing R&D in your subject for the new concepts and then put the content in simple and easy way to form tutorials and e-books, which can be used for self-learning purpose.
</br></br>
<strong>Renumeration - </strong> The best in Industry</br></br><strong>Experience - </Strong> Minimum 4-5 years of experience in any of the following subjects:
</br></br>
1.Salesforce</br>
2.Cloud Computing</br>
3.Virtualization</br>
4.Software testing</br>
5.Big Data related technologies</br>
6.BI and associated tools</br>
7.Digital Marketing</br>
8.Microsoft Technologies</br>
9.Android developer</br>
10.Web Developer</br></br>
</p>

</div>
</div>
<strong>You have the best opportunity for learning new technologies every day, get great exposure and satisfaction to produce e-books and tutorials for a big internet community.</strong>
<hr />

</div>
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
<a href="#">Jobs</a>
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