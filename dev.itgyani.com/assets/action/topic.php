<?php include('../connection.php'); 
    $action = $_REQUEST['action'];
	$TopicID = $_REQUEST['TopicID'];
        
	if($action=="delete") {
	
		$sql = mysql_query("delete from topic where TopicID = '".$TopicID."' ") or die(mysql_error());
		exit();
	
	}
	
	if($action=="update") {
		
		 $sql_topic = mysql_query("SELECT * FROM `topic` where TopicID = '".$TopicID."' ") or die(mysql_error());
		 $row_topic = mysql_fetch_array($sql_topic);
		
		$TopicDesc = mysql_real_escape_string($_REQUEST['TopicDesc']);
		$URL01 = mysql_real_escape_string($_REQUEST['URL01']);
		$URL02 = mysql_real_escape_string($_REQUEST['URL02']);
		$URL03 = mysql_real_escape_string($_REQUEST['URL03']);
		$URL04 = mysql_real_escape_string($_REQUEST['URL04']);
		$Doc01 = mysql_real_escape_string($_REQUEST['Doc01']);
		$Doc02 = mysql_real_escape_string($_REQUEST['Doc02']);
		$Doc03 = mysql_real_escape_string($_REQUEST['Doc03']);
		$Doc04 = mysql_real_escape_string($_REQUEST['Doc04']);
		
		$sql = mysql_query("update `topic` set TopicDesc = '".$TopicDesc."' ,  URL01 = '".$URL01."' , URL02 = '".$URL02."' , URL03 = '".$URL03."' , URL04 = '".$URL04."'  , Doc01 = '".$Doc01."' , Doc02 = '".$Doc02."' , Doc03 = '".$Doc03."' , Doc04 = '".$Doc04."' where TopicID = '".$TopicID."' "); 
		$_SESSION['success'] = "Your Topic Successfully Updated...";
		header("location:".$AdminPath."pages/topic/topic.php?CourseID=".$row_topic['CourseID']);
		exit();
	
	}
?>	