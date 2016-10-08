<?php include('../connection.php'); 
    
	$action = $_REQUEST['action'];
	$FAQID = $_REQUEST['FAQID'];
        
	if($action=="delete") {
	
		$sql = mysql_query("delete from faq where FAQID = '".$FAQID."' ") or die(mysql_error());
		exit();
	
	}
	
	if($action=="update") {
	
		 $sql_faq = mysql_query("SELECT * FROM `faq` where FAQID = '".$FAQID."' ") or die(mysql_error());
		 $row_faq = mysql_fetch_array($sql_faq);
		
		$FAQ = $_REQUEST['FAQ'];
		$FAQAnswer = $_REQUEST['FAQAnswer'];
		
		$sql = mysql_query("update `faq` set FAQ = '".$FAQ."' ,  FAQAnswer = '".$FAQAnswer."'  where FAQID = '".$FAQID."' ") or die(mysql_error()); 
		$_SESSION['success'] = "Your FAQ Successfully Updated...";
		header("location:".$AdminPath."pages/faqs/faq.php?CourseID=".$row_faq['CourseID']);
		exit();
	
	}
?>	