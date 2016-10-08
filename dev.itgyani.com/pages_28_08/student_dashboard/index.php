<?php include('../../connection.php');

	if(!isset($_SESSION['stud_id'])) {
		header("location:".$RootPath);
		exit();
	}

 ?>
<?php include('../../header.php');

$sql_user = mysql_query("select * from  `student_register` where `id` = '".$_SESSION['stud_id']."' ");
$row_user = mysql_fetch_array($sql_user);

 ?>

<div class="middle-content">

	Welcome, <?php echo $row_user['user_name']; ?> 
        
        firstname, <?php echo $row_user['first_name']; ?> 
        
        lastname, <?php echo $row_user['last_name']; ?> 
    
    <a href="<?php echo $RootPath; ?>pages/student_dashboard/logout.php"> logout </a>
</div>

<?php include('../../footer.php'); ?>