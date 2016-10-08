<?php include('../connection.php'); 
    
	$action = $_REQUEST['action'];
	$QuestionSetID = $_REQUEST['QuestionSetID'];
        
	if($action=="delete") {
	
		$sql = mysql_query("delete from QuestionSet where QuestionSetID = '".$QuestionSetID."' ") or die(mysql_error());
		exit();
	
	}
	
	if($action=="update") {
	
		 $sql_faq = mysql_query("SELECT * FROM `QuestionSet` where QuestionSetID = '".$QuestionSetID."' ") or die(mysql_error());
		 $row_faq = mysql_fetch_array($sql_faq);
		
		$Question = mysql_real_escape_string($_REQUEST['Question']);
		$Answer01 = mysql_real_escape_string($_REQUEST['Answer01']);
		$Answer02 = mysql_real_escape_string($_REQUEST['Answer02']);
		$Answer03 = mysql_real_escape_string($_REQUEST['Answer03']);
		$Answer04 = mysql_real_escape_string($_REQUEST['Answer04']);
		$CorrectAnswer = mysql_real_escape_string($_REQUEST['CorrectAnswer']);
		if($CorrectAnswer=='1') {
			$IsAnswer01Ok = '1';
		} else if($CorrectAnswer=='2') {
			$IsAnswer02Ok = '1';
		} else if($CorrectAnswer=='3') {
			$IsAnswer03Ok = '1';
		} else if($CorrectAnswer=='4') {
			$IsAnswer04Ok = '1';
		}
		
		
		
		$sql = mysql_query("update `QuestionSet` set Question = '".$Question."' ,  Answer01 = '".$Answer01."' ,  Answer02 = '".$Answer02."' ,  Answer03 = '".$Answer03."' ,  Answer04 = '".$Answer04."'   , IsAnswer01Ok = '".$IsAnswer01Ok."'  , IsAnswer02Ok = '".$IsAnswer02Ok."'  , IsAnswer03Ok = '".$IsAnswer03Ok."'  , IsAnswer04Ok = '".$IsAnswer04Ok."' where QuestionSetID = '".$QuestionSetID."' ") or die(mysql_error()); 
		
		$_SESSION['success'] = "Your Question Successfully Updated...";
		header("location:".$AdminPath."pages/question_answers/qa.php?TopicID=".$row_faq['TopicID']);
		exit();
	
	}
?>	