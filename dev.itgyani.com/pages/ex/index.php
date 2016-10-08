<?php include('../../head1.php');?>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert form</title>
<link type="text/css" media="all" rel="stylesheet" href="style.css">
</head>

<body style="background-image:url('<?php echo $RootPath ?>/images/banner1.jpg'); opacity: 0.7;filter: alpha(opacity=50);">
<div class="display" style="background-image:url('<?php echo $RootPath ?>/images/banner1.jpg');">

<form action="insert.php" method="post" name="insertform">
<p>
<h5 CLASS="text-center" style="color:black;text-shadow:  5px 5px 5px rgba(185, 160, 160, 0.78)">Register With ITGYANI</h5>
  <label for="name" id="preinput"> Full Name : </label>
  <input type="text" name="username" required placeholder="Enter your name" id="inputid"/>
</p>
<p>
  <label  for="email" id="preinput"> Email ID : </label>
  <input type="email" name="usermail" required placeholder="Enter your Email" id="inputid" />
</p>
<p>
  <label for="mobile" id="preinput"> Mobile Number : </label>
  <input type="text" name="usermobile" required placeholder="Enter your mobile number" id="inputid" />
</p>
<p>
  <input type="submit" name="send" value="Submit" id="inputid"  />
</p>
</form>
</div>
<!--<?php include('view.php'); ?>-->
</body>
</html>