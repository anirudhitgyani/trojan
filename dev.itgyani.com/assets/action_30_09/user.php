<?php include('../connection.php'); 
    $action = $_REQUEST['action'];
    $ProfileID = $_REQUEST['ProfileID'];
        
    if($action=="delete") {

            $sql = mysql_query("delete from `profile` where ProfileID = '".$ProfileID."' ") or die(mysql_error());
            header("location:".$AdminPath."pages/users/");
            exit();

    }
    
    
    if($action=="delete1") {

            $sql = mysql_query("delete from `profile` where ProfileID = '".$ProfileID."' ") or die(mysql_error());
            header("location:".$AdminPath."pages/users/corporate.php");  
            exit();

    }
    
	
	
?>	