<?php include('connection.php');
if(isset($_SESSION['stud_id'])){
$sql_user = mysql_query("select * from `profile` where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
$row_user = mysql_fetch_array($sql_user);
}


?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>IT Gyani</title>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,500,700,300|Roboto+Condensed' rel='stylesheet' type='text/css'>

<link rel="stylesheet" type="text/css" href="<?php echo $RootPath; ?>css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<?php echo $RootPath; ?>css/style.css" />
<link rel="stylesheet" type="text/css" href="<?php echo $RootPath; ?>css/font-awesome.min.css" />
 <meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.js"></script>
<script type="text/javascript" src="<?php echo $RootPath; ?>js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<?php echo $RootPath; ?>css/plyr.css">
</head>

<body>
<header class="header dashbord-header">
<div class="container v-center">
<a class="logo" href="<?php echo $RootPath; ?>"><img src="<?php echo $RootPath; ?>images/logo.png" /></a>
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
<span class="avtar-image">
	<?php if($row_user['ProfilePicture']!='') { ?>
    	<img src="<?php echo $RootPath; ?>upload_images/stud_images/<?php echo $row_user['ProfilePicture']; ?>" />
	<?php } else { ?>
    	<img src="<?php echo $RootPath; ?>images/avtar-image.png" />
    <?php } ?>

</span>
 <?php echo $row_user['ProfileName'] ?>
    <span class="caret"></span></div>
    <ul class="dropdown-menu">
      <li><a href="<?php echo $RootPath; ?>pages/student/">Dashbord <img src="<?php echo $RootPath; ?>images/dashbord/dashbord-icon.png" /></a></li>
      <li><a href="javascript:void(0);">Profile <img src="<?php echo $RootPath; ?>images/dashbord/profile-icon.png" /></a></li>
      <li><a href="javascript:void(0);">Resume <img src="<?php echo $RootPath; ?>images/dashbord/resume-icon.png" /></a></li>
      <li><a href="javascript:void(0);">Account <img src="<?php echo $RootPath; ?>images/dashbord/account-icon.png" /></a></li>
      <li><a href="<?php echo $RootPath; ?>pages/student/logout.php">Log Out <img src="<?php echo $RootPath; ?>images/dashbord/logout-icon.png" /></a></li>
    </ul>
</div>
</div>
</div>

</header>
