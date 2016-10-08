<?php include('../../head1.php'); ?>
<div class="container">  
<div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="panel-title text-center">ITGYANI Trainer Registration Form</div>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!--<title>Registration</title>-->
<link rel="stylesheet" href="css/style.css" />
</head>
<body>
<?php
 require('../../db.php');
 // If form submitted, insert values into the database.
 if (isset($_POST['username'])){
 <!--$username = $_POST['username'];-->
 $email = $_POST['email'];
 $firstname = $_POST['firstname'];
 <!--$username = stripslashes($username);
 $username = mysql_real_escape_string($username);-->
 $email = stripslashes($email);
 $email = mysql_real_escape_string($email);
 $firstname = stripslashes($firstname);
 $firstname = mysql_real_escape_string($firstname);
 <!--$trn_date = date("Y-m-d H:i:s");
 $query = "INSERT into `users` (firstname, lastname, email,) VALUES ('$username', '".md5($password)."', '$email', '$trn_date')";
 $result = mysql_query($query);
 if($result){
 echo "<div class='form'><h3>You are registered successfully.</h3><br/>Click here to <a href='login.php'>Login</a></div>";
 }
 }else{
?>
<div class="form">
<!--<h1>Registration</h1>-->

<form name="registration" action="" method="post">

<input type="email" name="email" placeholder="Email" required /></br></br>
<input type="text" name="firstname" placeholder="First Name" required /></br></br>
<input type="text" name="lastname" placeholder="Last Name" required /></br></br>
<input type="submit" name="submit" value="Register" />
</form>
</div>
<?php } ?>
</body>
</html>