<?php include('../connection.php'); 

	$action = $_REQUEST['action'];
	
	if($action == 'insert') {
		
		$user_name = $_REQUEST['user_name'];
		$first_name = $_REQUEST['first_name'];
		$last_name = $_REQUEST['last_name'];
		$company_name = $_REQUEST['company_name'];
		$mobile = $_REQUEST['mobile'];
		$dateofbirth = $_REQUEST['dateofbirth'];
		$gender = $_REQUEST['gender'];
		$email = $_REQUEST['email'];
		$password = $_REQUEST['password'];
		$created_date = date('Y-m-d');
		
		$sql_email = mysql_query("select * from  registered_users where email = '".$email."' OR user_name = '".$user_name."' ");
		$total_email = mysql_num_rows($sql_email);
		
		if($total_email=='0') {
	
			$sql = mysql_query("insert into  registered_users set `user_name` = '".$user_name."' , `first_name` = '".$first_name."' , `last_name` = '".$last_name."' , `company_name` = '".$company_name."' , `mobile` = '".$mobile."' , `dateofbirth` = '".$dateofbirth."' , `gender` = '".$gender."' , `email` = '".$email."' , `password` = '".md5($password)."' , `created_date` = '".$created_date."' , `status` = '0' ") or die(mysql_error());
			$Lastid = mysql_insert_id();
                        $sql = mysql_query("insert into  `profile` set GroupID = '3' , `ProfileName` = '".$user_name."' , `ProfileFirstName` = '".$first_name."' , `ProfileLastName` = '".$last_name."' , `ProfileMobile` = '".$mobile."' , `ProfileDBO` = '".$dateofbirth."' ,  `ProfileGender` = '".$gender."' , `ProfileEmail` = '".$email."' , `ProfilePassword` = '".md5($password)."' , IsFaceBook = '0',IsFaceGmail = '0', IsPaid = '0', IsActive = '1', IsActived='1',IsDeleted='0', AddUserID='0' ") or die(mysql_error());
			$_SESSION['Success'] = "Your Register Successfully Done Please check your email";
			
			
	
			$to = $email;
			$subject = "Corporate Registration";
			$active_link = $RootPath."action/corporate.php?action=active_link&id=".$Lastid;
			$message = "
			<html>
			<head>
			<title>Corporate Registration</title>
			</head>
			<body>
			
			<p>Dear ".$user_name." </p><br/> 


			<p>Welcome abroad the ITgyani Portal </p>

			<p>Now, here for the first time ever you can hire freshers based on your business need from the comfort of your office!

			Apart from that you will get an insight into their performance on the various tech they have learnt here along with their detailed CV.

			If there is any candidate that you would like to shortlist, interview, make an offer, etc the options will be available on line.

			Since we are in the first few months you may not see many students but let us assure you that it is only a matter of time when they can fill your requirements. We will get back to you when we are fully operational on that front.
Looking forward to serving you… </p>

		<p>
		Warm regards
		<br/>
		Team IT Gyani
		</p>	
			
			<a href='".$active_link."'> Please Activate Your Account </a>
			
			<p>
				(Other benefits from website not mentioned here)
				<br/>
				The IT Gyani program is also currently offering 100% job guarantee, which means we will refund your entire fees if you don't secure a job within 6 months after you graduate.
				<br/><br/>
				Warm regards 
				<br/>
				Team IT Gyani
				www.itgyani.com
				<br/><br/>
				Thanks & Regards,
				<br/>
				Boraste Sagar | IT Consultant | Techno Flair Lab Pvt. Ltd.
				<br/>
				Level-5, Tech Park-1, Airport Road, Yerwada, Pune - 411006, India
				<br/>
				O: + 91.20.4011 1336 | F : + 91.020. 40111105 | M : +91 758 817 3431 / +91 954 575 2552
				<br/>
				Website: www.itgyani.com | Email ID: sagar@itgyani.com
				<br/>
</p>

			</body>
			</html>
			";
			
			// Always set content-type when sending HTML email
			$headers = "MIME-Version: 1.0" . "\r\n";
			$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
			
			// More headers
			$headers .= 'From: <info.itgyani@gmail.com>' . "\r\n";
			//$headers .= 'Cc: myboss@example.com' . "\r\n";
			
			mail($to,$subject,$message,$headers);
			
			echo "0";
			exit();
 
			
		} else {
			//$_SESSION['Error'] = "Email OR Username Already Register Please Try With Other One.";
			echo "1";
			exit();
		}
		//header("location:".$RootPath."pages/corporate/registration.php");
		//exit();
 		
	}
	
	if($action=='active_link') {
		
		$id = $_REQUEST['id'];
		$sql = mysql_query("update `registered_users` set status = '1' where id = '".$id."' ");
		
		$sql_user = mysql_query("select * from `registered_users` where id = '".$id."' ");
		$row_user = mysql_fetch_array($sql_user);
		
			$to = $row_user['email'];
			$subject = "Thank You For Registration";
			$login_link = $RootPath."pages/corporate";
			$message = "
			<html>
			<head>
			<title>Corporate Registration</title>
			</head>
			<body>
			<p>This email contains to Thank You For Register</p>
			<p> Thank you for register our website please click below link for register </p>
			<a href='".$login_link."'> Please click for login</a>
			</body>
			</html>
			";
			
			// Always set content-type when sending HTML email
			$headers = "MIME-Version: 1.0" . "\r\n";
			$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
			
			// More headers
			$headers .= 'From: <info.itgyani@gmail.com>' . "\r\n";
			//$headers .= 'Cc: myboss@example.com' . "\r\n";
			
			mail($to,$subject,$message,$headers);
 
		
		
		header("location:".$RootPath."pages/corporate/thank_you.php");
		exit();
	
	}
	
	if($action=='login') {
		$user_name = $_REQUEST['user_name'];
		$password = $_REQUEST['password'];
		
		$sql = mysql_query("select * from `registered_users` where user_name = '".$user_name."' AND password = '".md5($password)."' ");
		$row = mysql_fetch_array($sql);
		
		if(empty($row)) {
			//$_SESSION['Error'] = "Please Check Your Username And Password";
			//header("location:".$RootPath."pages/corporate");
			echo "0";
			exit();
		} else {
			if($row['status']=='0') {
				//$_SESSION['Error'] = "Please Activate Your Account...";
				//header("location:".$RootPath."pages/corporate");
				echo "1";
				exit();
			} else {
				$_SESSION['user_id'] = $row['id'];
				echo "2";
				//header("location:".$RootPath."pages/dashboard");
				exit();
			}
		}
	}
	
	
	if($action=='forgot_password') {
		
		$f_email = $_REQUEST['f_email'];
		
		$sql_femail = mysql_query("select * from `registered_users` where email = '".$f_email."' ");
		$totalrow_email = mysql_num_rows($sql_femail);
		
		if($totalrow_email!='0') {
			$row_femail = mysql_fetch_array($sql_femail);
			
			$_SESSION['success'] = "Your Password Is Send To Your Email Please Check Your Email";
			
			$to = $f_email;
			$subject = "HR Forgot Password";
			$active_link = $RootPath."/pages/corporate/";
			$message = "
			<html>
			<head>
			<title>HR Forgot Password</title>
			</head>
			<body>
			<p>This email contains to HR Forgot Password</p>
			<p> Your Password : ".md5($row_femail['password'])." </p>
			<a href='".$active_link."'> Click For Login</a>
			</body>
			</html>
			";
			
			// Always set content-type when sending HTML email
			$headers = "MIME-Version: 1.0" . "\r\n";
			$headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
			
			// More headers
			$headers .= 'From: <info.itgyani@gmail.com>' . "\r\n";
			//$headers .= 'Cc: myboss@example.com' . "\r\n";
			
			mail($to,$subject,$message,$headers);
			echo "0";
			exit();
			
			
		} else {
			//$_SESSION['error'] = "Your Email Not Register In Our Website Please Check Your Email";
			echo "1";
			exit();
		}
		
	
		//header("location:".$RootPath."pages/corporate/forgot_password.php");
		//exit();
	}


?>