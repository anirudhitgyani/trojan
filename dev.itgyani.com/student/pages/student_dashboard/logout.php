<?php include('../../connection.php');

	unset($_SESSION['user_id']);
	header("location:".$RootPath);
	exit();
	

 ?>
