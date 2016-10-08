<?php include('../connection.php'); 
    
	$action = $_REQUEST['action'];
	
	if($action=="message") {
	
		$Message = mysql_real_escape_string($_REQUEST['Message']);
		$InviteID = $_REQUEST['InviteID'];
		$CreatedDate = date('Y-m-d H:i:s');
		$sql_invite = mysql_query("select * from `invite` where InviteID = '".$InviteID."' ") or die(mysql_error());
		$row_invite = mysql_fetch_array($sql_invite);
		
		$sql_update = mysql_query("update `invite` set SendDate = '".$CreatedDate."' , Status = 'message_hr' where InviteID = '".$InviteID."' ") or die(mysql_error());
		
		$sql_con = mysql_query("insert into `conversation` set InviteID = '".$InviteID."' , SenderID = '".$_SESSION['AdminID']."' , ReceivedID = '".$row_invite['CorporateID']."' , StudentID = '".$row_invite['StudentID']."' , ReadMessage = '1' , SendDate = '".$CreatedDate."' , Message = '".$Message."' , Status = '1' "); 
		
		$sql_user = mysql_query("select * from `profile` where ProfileID = '".$row_invite['CorporateID']."' ");
		$row_user = mysql_fetch_array($sql_user);
		
			$to = $row_user['ProfileEmail'];
			$subject = "Student Detail ";
			$message = "
			<html>
			<head>
			<title>Student Interview Detail</title>
			</head>
			<body>
			<p>This email contains to Student Interview Detail</p>
			<p> ".$Message." </p>
			</body>
			</html>
			";
			
			$header = "From:support@itgyani.com \r\n";
			 //$header .= "Cc:anirudh272@gmail.com \r\n";
			 $header .= "MIME-Version: 1.0\r\n";
			 $header .= "Content-type: text/html\r\n";
			 
			 $retval = mail ($to,$subject,$message,$header);
			
			if($retval){
				echo "0";
				exit();
			} else {
				echo "1";
				exit();
			}
		exit();
	}
	
	if($action=="accept") {
		$InviteID = $_REQUEST['InviteID'];
		$sql = mysql_query("update `invite` set Status = 'accept' where InviteID = '".$InviteID."' ");
		exit();
	}
	
	if($action=="reject") {
		$InviteID = $_REQUEST['InviteID'];
		$sql = mysql_query("update `invite` set Status = 'reject' where InviteID = '".$InviteID."' ");
		exit();
	}
?> 