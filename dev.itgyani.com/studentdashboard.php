<?php
session_start();
$Profile = $_SESSION['profile'];
//echo print_r( $Profile);
//echo '</br>';echo '</br>';echo '</br>';
//print_r($Profile[0]['ProfileName']);
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>IT Gyani</title>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,500,700,300|Roboto+Condensed' rel='stylesheet' type='text/css'>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />
 <meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/plyr.css">
</head>

<body>
<header class="header dashbord-header">
<div class="container v-center">
<a class="logo" href="#"><img src="images/logo.png" /></a>
<div class="header-right">
<a href="#" class="header-button pull-left"><i class="fa fa-chevron-down"></i> Upgrade Plane</a>
<div class="profile-update-box">
<strong>Profile Complete</strong>
<p>25% Complete</p>
<div class="progress-bar">
<span></span>
</div>
<p>Filling out <a href="#">Last Name</a> will bring Your profile to 50% Complete</p>
</div>
<div class="dropdown profile-buttons">
<div class="dropdown-toggle" data-toggle="dropdown">
<span class="avtar-image"><img src="images/avtar-image.jpg" /></span>
 <?php echo $Profile[0]['ProfileName'] ?>
    <span class="caret"></span></div>
    
    <ul class="dropdown-menu">
      <li><a href="#">Dashbord <img src="images/dashbord/dashbord-icon.png" /></a></li>
      <li><a href="#">Profile <img src="images/dashbord/profile-icon.png" /></a></li>
      <li><a href="#">Resume <img src="images/dashbord/resume-icon.png" /></a></li>
      <li><a href="#">Account <img src="images/dashbord/account-icon.png" /></a></li>
      <li><a href="logout.php">Log Out <img src="images/dashbord/logout-icon.png" /></a></li>
    </ul>
</div>
</div>
</div>

</header>

<div class="middle-content student-dashbord-content">
<div class="container">
<div class="row">
<div class="col-sm-3 col-xs-12 col-md-2">
<div class="dashbord-box my-course">
<h2>My Course</h2>
<div class="box-content"></div>
</div>
</div>
<div class="col-sm-9 col-xs-12 col-md-10 no-padding-left">
<div class="row">
<div class="col-sm-9 col-xs-12 col-md-10">
    <div class="dashbord-box video-box" >
<h2>Video</h2>
<div class="box-content" style="max-width:100%;min-width:100%;  ">
<video poster="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.jpg" controls crossorigin style="max-width:100%;min-width:100%;  ">
                    <!-- Video files -->
                    <source src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.mp4" type="video/mp4">
                    <source src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.webm" type="video/webm">

                    <!-- Text track file -->
                    <track kind="captions" label="English" srclang="en" src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.en.vtt" default>

                   
                </video>
</div>
</div>


</div>
<div class="col-sm-3 col-xs-12 col-md-2 no-padding"><div class="dashbord-box my-course-progress">
<h2>Course Progress</h2>
<div class="box-content"></div>
</div></div>
</div>
<div class="student-buttons">
<a href="#">Video Discription</a>
<a href="#">Next Video</a>
<a href="#">Next Document</a>
<a href="#">Start Test</a>
<a href="#">Next Topic</a>
</div> 
<div class="video-discription">
<h4>Video Discription</h4>
</div>
</div>
</div>
</div>

</div>


<footer id="footer">
<div class="container">
<a href="#" class="footer-logo"><img src="images/logo.png" /></a>
<div class="social-login footer-login text-center"><p>social media links</p><a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-linkedin"></i></a><a href="#"><i class="fa fa-linkedin"></i></a></div>
<p class="copyright">Copyright @ 2016, All Right Reserved Techno Flair Lab Private Ltd.</p>
</div>
</footer>
  <!-- Plyr core script -->
        <script src="js/plyr.js"></script>

        <!-- Docs script -->
      <script>plyr.setup();</script>
</body>
    <style type="text/css">
    .panel {
    /* border: aquamarine; */
    border-width: 2px;
}
.VideoDivider
{
    border-top-width: 2px;
    border-top-style: solid;
    border-top-color: #03a9f4;
    border-bottom-width: 2px;
    border-bottom-style: solid;
    border-bottom-color: #03a9f4;
    margin-bottom: 5px;
    background-color: lightgoldenrodyellow;
    font-family: fantasy;
    /* margin-left: 5px; */
    word-spacing: 2px;
}
</style>
<script src="js/BrizBStandardJSPageStandardCodeGallery.js"></script>
<script src="JsAjax/ITGStudentDashboard.js"></script>
<script src="js/videojs-ie8.min.js"></script>
<script src="js/video.js"></script>
<script src="js/Youtube.js"></script>
<script src="js/mediaelement-and-player.min.js"></script>
<script src="js/jquery.video-extend.js"></script>
<script type="text/javascript" src="js/flowplayer-3.1.4.min.js"></script>
</html>
