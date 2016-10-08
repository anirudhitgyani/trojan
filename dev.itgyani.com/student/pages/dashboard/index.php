<?php include('../../connection.php');

	if(!isset($_SESSION['user_id'])) {
		header("location:".$RootPath);
		exit();
	}

 ?>
<?php include('../../header.php');

$sql_user = mysql_query("select * from  `registered_users` where `id` = '".$_SESSION['user_id']."' ");
$row_user = mysql_fetch_array($sql_user);

 ?>

<div class="middle-content">

	Welcome, <?php echo $row_user['user_name']; ?> 
    
    <a href="<?php echo $RootPath; ?>pages/dashboard/logout.php"> logout </a>
</div>

<?php include('../../footer.php'); ?>