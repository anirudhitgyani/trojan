<?php
include('../../connection.php');

$sql = mysql_query("select * from student_register where id = '".$_SESSION['user_id']."' ");
$row = mysql_fetch_array($sql);
?>
<?php if($_SESSION['user_id']) { ?>
     <h1>Hello <?php echo $row['user_name']; ?></h1>
     
     <li class="nav-header"> fullname</li>
<li><?php echo $row['first_name']."   ".$row['last_name']; ?></li>
<li class="nav-header"> Email</li>
<li><?php echo $row['fb_id']; ?></li>

<div><a href="logout.php">Logout</a></div>

<?php } ?>
