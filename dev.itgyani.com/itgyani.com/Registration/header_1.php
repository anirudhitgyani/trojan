<?php include('connection.php');
if(isset($_SESSION['ProfileID'])) {
$sql_user = mysql_query("select * from `profile` where ProfileID = '".$_SESSION['ProfileID']."' ") or die(mysql_error());
$row_user = mysql_fetch_array($sql_user);
}


?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>IT Gyani</title>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,500,700,300|Roboto+Condensed' rel='stylesheet' type='text/css'>

<link rel="stylesheet" type="text/css" href="<?php echo $RootPath; ?>css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<?php echo $RootPath; ?>css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="<?php echo $RootPath; ?>css/style.css" />
<link rel="stylesheet" type="text/css" href="<?php echo $RootPath; ?>css/font-awesome.min.css" />


 <meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="<?php echo $RootPath; ?>js/jquery.min.js"></script>
<script type="text/javascript" src="<?php echo $RootPath; ?>js/bootstrap.min.js"></script>
<script type="text/javascript" src="<?php echo $RootPath; ?>js/jquery.dataTables.min.js"></script>

<link rel="stylesheet" href="<?php echo $RootPath; ?>css/plyr.css">
</head>

<body>

    <header class="header dashbord-header">
<div class="container v-center">
<a class="logo" href="<?php echo $RootPath; ?>"><img src="<?php echo $RootPath; ?>images/logo.png" /></a>
<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                                        <span class="sr-only">Toggle navigation</span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                      </button>
<div class="search-hr-bar"><i class="fa fa-search"></i>
<form><input type="text" placeholder="Search here" /></form>
</div>
<div class="header-right">


<div class="dropdown profile-buttons hr-profile">
<div class="dropdown-toggle" data-toggle="dropdown">
<span class="avtar-image">
    <?php if($row_user['ProfilePicture']!='') { ?>
    	<img src="<?php echo $RootPath; ?>upload_images/hr_images/<?php echo $row_user['ProfilePicture']; ?>" />
    <?php } else { ?>
    	<img src="<?php echo $RootPath; ?>images/avtar-image.png" />
    <?php } ?>
</span>
 <div class="hr-name"><?php echo $row_user['ProfileName']; ?></div>
    <span class="caret"></span></div>
    
    <ul class="dropdown-menu">
      <li><a href="<?php echo $RootPath; ?>pages/corporate/dashboard.php">Dashbord <img src="<?php echo $RootPath; ?>images/dashbord/dashbord-icon.png" /></a></li>
      <li><a href="javascript:void(0);">Messages (0) <img src="<?php echo $RootPath; ?>images/dashbord/message-icon.png" /></a></li>
      <!--<li><a href="#">UI elements <img src="<?php echo $RootPath; ?>images/dashbord/ul-elements-icon.png" /></a></li>
      <li><a href="#">Exams <img src="<?php echo $RootPath; ?>images/dashbord/exam-icon.png" /></a></li>
      <li><a href="#">Projects<img src="<?php echo $RootPath; ?>images/dashbord/project-icon.png" /></a></li>
      <li><a href="#">Calender<img src="<?php echo $RootPath; ?>images/dashbord/calander-icon.png" /></a></li>
      <li><a href="#">Maps<img src="<?php echo $RootPath; ?>images/dashbord/maps-icon.png" /></a></li>-->
      <li><a href="<?php echo $RootPath; ?>pages/corporate/logout.php">Logout<img src="<?php echo $RootPath; ?>images/dashbord/logout-icon.png" /></a></li>
    </ul>
</div>
</div>
</div>

</header>
