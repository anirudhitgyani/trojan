<?php include('../connection.php');

	$email = $_REQUEST['email'];
	$subject = $_REQUEST['subject'];
	$message = $_REQUEST['message'];
	
	
	$to = 'support@itgyani.com';
	//$to = 'shaikh.avwal@gmail.com';
	$subject = "Itgyani Contact";
	$active_link = $RootPath;
	$message = "
	<html>
	<head>
	<title>Contact Detail</title>
	</head>
	<body>
		
		<table align='center' border:'1px solid black'>
			<tr>
				<th> Email </th>
				<td> ".$email." </td>
			</tr>
			<tr>
				<th> Subject </th>
				<td> ".$subject." </td>
			</tr>
			<tr>
				<th> Message </th>
				<td> ".$message." </td>
			</tr>
		</table>
	
	</body>
	</html>
	"; 
	
	 $header = "From:support@itgyani.com \r\n";
	 $header .= "MIME-Version: 1.0\r\n";
	 $header .= "Content-type: text/html\r\n";
	 //echo $header;
	 //exit();
	 $retval = mail ($to,$subject,$message,$header);
	
	if($retval) {
		echo "0";
	} else {
		echo "1";
	}
	
	//echo "0";
	exit();

?>
