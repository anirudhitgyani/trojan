<?php include('../connection.php'); 

	$action = $_REQUEST['action'];
	
	if($action == 'insert') {
		
		
		
		$user_name = $_REQUEST['user_name'];
		$first_name = $_REQUEST['first_name'];
		$last_name = $_REQUEST['last_name'];
		$mobile = $_REQUEST['mobile'];
		$dateofbirth = $_REQUEST['dateofbirth'];
		$gender = $_REQUEST['gender'];
		$email = $_REQUEST['email'];
		$password = $_REQUEST['password'];
		$created_date = date('Y-m-d');
		
		$sql_email = mysql_query("select * from  `student_register` where `email` = '".$email."' OR `user_name` = '".$user_name."' ");
		$total_email = mysql_num_rows($sql_email);
		
		if($total_email=='0') {
	
			$sql = mysql_query("insert into  `student_register` set `user_name` = '".$user_name."' , `first_name` = '".$first_name."' , `last_name` = '".$last_name."' , `mobile` = '".$mobile."' , `dateofbirth` = '".$dateofbirth."' ,  `gender` = '".$gender."' , `email` = '".$email."' , `password` = '".md5($password)."' , `created_date` = '".$created_date."' , `status` = '0' ") or die(mysql_error());
			$Lastid = mysql_insert_id();
			$sql = mysql_query("insert into  `profile` set GroupID = '2' , `ProfileName` = '".$user_name."' , `ProfileFirstName` = '".$first_name."' , `ProfileLastName` = '".$last_name."' , `ProfileMobile` = '".$mobile."' , `ProfileDBO` = '".$dateofbirth."' ,  `ProfileGender` = '".$gender."' , `ProfileEmail` = '".$email."' , `ProfilePassword` = '".md5($password)."' , IsFaceBook = '0',IsFaceGmail = '0', IsPaid = '0', IsActive = '1', IsActived='1',IsDeleted='0', AddUserID='0' ") or die(mysql_error());
			$_SESSION['Success1'] = "Your Register Successfully Please Check Your Email";
			
			
			$to = $email;
			$subject = "Student Registration";
			$active_link = $RootPath."action/student.php?action=active_link&id=".$Lastid;
			$message = "
			<html>
			<head>
			<title>Student Registration</title>
			</head>
			<body>
			<p>Dear ".$user_name."</p>
			<p>Welcome to the IT Gyani program.<br/>
This program ensures that you have the requisite skills -both technical and soft- to secure a job in the IT industry.</p><br/>
			<p>There are 4 broad parts to the program..</p><br/>
			<p>1. In foundation courses you will be exposed to the world of IT careers and basic communication skills. <br/>
			2. In counseling you will be evaluated psychometrically and based on your choice and performance you will guided to a career track based on industry requirements <br/>
			3. In Career track you will be taught complete stack courses for the career along with Advanced soft skills like interview techniques etc. <br/>
			4. Live environment will be provided for hands in experience in your tech stack
The duration of the course will be around 6 months if you are an average student and spend about 2 hours on the site, however it will vary as it is online and the number of tracks you do.
You will have access to the libraries and courses as long as you wish...
Through the program you can also Chat with counselors, instructors and course mates online.
Apart from this you can enjoy the following benefits as part of the program. </p>

			<p><a href='".$active_link."'> Please Activate Your Account </a></p>
			
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
			header("location:".$RootPath."index.php");
			echo "0";
			exit();
 
 		} else {
			
			//$_SESSION['Error1'] = "Email OR Username Already Register Please Try With Other One.";
			echo "1";
			exit();
		}
		//header("location:".$RootPath."pages/student/registration.php");
		
 		
	}
	
	
	if($action=='active_link') {
		
		$id = $_REQUEST['id'];
		$sql = mysql_query("update `student_register` set status = '1' where id = '".$id."' ");
		
		$sql_user = mysql_query("select * from `student_register` where id = '".$id."' ");
		$row_user = mysql_fetch_array($sql_user);
		
			$to = $row_user['email'];
			$subject = "Thank You For Registration";
			$login_link = $RootPath."pages/student";
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
 
		
		
		header("location:".$RootPath."pages/student/thank_you.php");
		exit();
	
	}
	
	if($action=='login') {
		
		$user_name = $_REQUEST['user_name'];
		$password = $_REQUEST['password'];
		
		$sql = mysql_query("select * from `student_register` where `user_name` = '".$user_name."' AND `password` = '".md5($password)."' ") or die(mysql_error());
		$row = mysql_fetch_array($sql);
		
		if(empty($row)) {
			//$_SESSION['Error1'] = "Please Check Your Username And Password";
			//header("location:".$RootPath."pages/student");
			echo "0";
			exit();
		} else {
			if($row['status']=='0') {
				//$_SESSION['Error1'] = "Please Activate Your Account...";
				//header("location:".$RootPath."pages/student");
				echo "1";
				exit();
			} else {
				$_SESSION['user_id'] = $row['id'];
				//header("location:".$RootPath."pages/student_dashboard");
				echo "2";
				exit();
			}
			
		}
	}
	
	
	if($action=='forgot_password') {
		
		$f_email = $_REQUEST['f_email'];
		
		$sql_femail = mysql_query("select * from `student_register` where email = '".$f_email."' ");
		$totalrow_email = mysql_num_rows($sql_femail);
		
		if($totalrow_email!='0') {
			$row_femail = mysql_fetch_array($sql_femail);
			
			//$_SESSION['success'] = "Your Password Is Send To Your Email Please Check Your Email";
			
			$to = $f_email;
			$subject = "Student Forgot Password";
			$active_link = $RootPath."/pages/student/";
			$message = "
			<html>
			<head>
			<title>Student Forgot Password</title>
			</head>
			<body>
			<p>This email contains to Student Forgot Password</p>
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
		
	
		//header("location:".$RootPath."pages/student/forgot_password.php");
		//exit();
	}


?>