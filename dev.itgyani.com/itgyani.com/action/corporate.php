<?php include('../connection.php'); 

	$action = $_REQUEST['action'];
	
	if($action == 'insert') {
		
		$user_name = $_REQUEST['user_name'];
		$first_name = $_REQUEST['first_name'];
		$last_name = $_REQUEST['last_name'];
		$company_name = $_REQUEST['company_name'];
		$mobile = $_REQUEST['mobile'];
		$dateofbirth = strtotime('Y-m-d',$_REQUEST['dateofbirth']);
		$gender = $_REQUEST['gender'];
		$email = $_REQUEST['email'];
		$password = $_REQUEST['password'];
		$created_date = date('Y-m-d H:i:s');
		
		//$NewDBO = date('Y-m-d', strtotime($dateofbirth));
		
		$sql_email = mysql_query("select * from  `profile` where ProfileEmail = '".$email."' OR ProfileName = '".$user_name."' ");
		$total_email = mysql_num_rows($sql_email);
		
		if($total_email=='0') {
	
			/*$sql = mysql_query("insert into  registered_users set `user_name` = '".$user_name."' , `first_name` = '".$first_name."' , `last_name` = '".$last_name."' , `company_name` = '".$company_name."' , `mobile` = '".$mobile."' , `dateofbirth` = '".$dateofbirth."' , `gender` = '".$gender."' , `email` = '".$email."' , `password` = '".md5($password)."' , `created_date` = '".$created_date."' , `status` = '0' ") or die(mysql_error());*/
			
            $sql = mysql_query("insert into  `profile` set GroupID = '3' , `ProfileName` = '".$user_name."' , `ProfileFirstName` = '".$first_name."' , `ProfileLastName` = '".$last_name."' , `ProfileMobile` = '".$mobile."' , `ProfileDBO` = '".$dateofbirth."' ,  `ProfileGender` = '".$gender."' , `ProfileEmail` = '".$email."' , `ProfilePassword` = '".md5($password)."' , ProfileCompanyName = '".$company_name."' , IsFaceBook = '0',IsFaceGmail = '0', IsPaid = '0', IsActive = '0', IsActived='1',IsDeleted='0', AddUserID='0', AddUserTime = '".$created_date."' ") or die(mysql_error());
			$Lastid = mysql_insert_id();
			$_SESSION['Success'] = "Your Register Successfully Done Please check your email";
			
			$to = $email;
			$subject = "Corporate Registration";
			$active_link = $RootPath."action/corporate.php?action=active_link&ProfileID=".$Lastid;
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
				Team IT Gyani<br/>
				www.itgyani.com
				<br/><br/>
				
</p>

			</body>
			</html>
			";
			
			 $header = "From:support@itgyani.com \r\n";
			 //$header .= "Cc:anirudh272@gmail.com \r\n";
			 $header .= "MIME-Version: 1.0\r\n";
			 $header .= "Content-type: text/html\r\n";
			 
			 $retval = mail ($to,$subject,$message,$header);
			
			
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
		
		$ProfileID= $_REQUEST['ProfileID'];
		$sql = mysql_query("update `profile` set status = '1' where ProfileID = '".$ProfileID."' ");
		
		$sql_user = mysql_query("select * from `profile` where ProfileID = '".$ProfileID."' ");
		$row_user = mysql_fetch_array($sql_user);
		
		$to = $row_user['ProfileEmail'];
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
		
		$header = "From:support@itgyani.com \r\n";
		 //$header .= "Cc:anirudh272@gmail.com \r\n";
		 $header .= "MIME-Version: 1.0\r\n";
		 $header .= "Content-type: text/html\r\n";
		 
		 $retval = mail ($to,$subject,$message,$header);
			

	
		
		header("location:".$RootPath."pages/corporate/thank_you.php");
		exit();
	
	}
	
	if($action=='login') {
		$user_name = $_REQUEST['user_name'];
		$password = $_REQUEST['password'];
		
		$sql = mysql_query("select * from `profile` where (ProfileName = '".$user_name."' OR ProfileEmail = '".$user_name."' ) AND ProfilePassword = '".md5($password)."' AND GroupID = '3'  ");
		$row = mysql_fetch_array($sql);
		
		if(empty($row)) {
			echo "0";
			exit();
		} else {
			if($row['IsActive']=='0') {
				echo "1";
				exit();
			} else {
				$_SESSION['ProfileID'] = $row['ProfileID'];
				echo "2";
				exit();
			}
		}
	}
	
	
	if($action=='forgot_password') {
		
		$f_email = $_REQUEST['f_email'];
		
		$sql_femail = mysql_query("select * from `profile` where ProfileEmail = '".$f_email."' ");
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
			<p> Your Password : ".md5($row_femail['ProfilePassword'])." </p>
			<a href='".$active_link."'> Click For Login</a>
			</body>
			</html>
			"; 
		 
			$header = "From:support@itgyani.com \r\n";
			 //$header .= "Cc:anirudh272@gmail.com \r\n";
			 $header .= "MIME-Version: 1.0\r\n";
			 $header .= "Content-type: text/html\r\n";
			 
			 $retval = mail ($to,$subject,$message,$header);
			
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
	
	if($action == 'change_state') {
		$stateval = $_REQUEST['stateval'];
		$sql_city = mysql_query("select CityID,CityName from `city` where StateID = '".$stateval."' AND IsActive = '1' ");
		?>
        
        <div id="city_div" class="col-xs-12 col-md-3 col-sm-2">
            <select class="selectpicker show-tick form-control city" id="CityID" name="CityID" >
            	<?php while($row_city = mysql_fetch_array($sql_city)) { ?>
                	<option value="<?php echo $row_city['CityID']; ?>" ><?php echo $row_city['CityName']; ?></option>
                <?php } ?>
            </select>
        </div>
        
        <?php 
		exit();
		
	}
	
	if($action=="edit_profile") {
		
		$ProfileID = $_REQUEST['ProfileID'];
		$ProfileLastName = $_REQUEST['ProfileLastName'];
		$ProfileFirstName = $_REQUEST['ProfileFirstName'];
		$ProfileDBO = $_REQUEST['ProfileDBO'];
		$ProfileGender = $_REQUEST['ProfileGender'];
		$ProfileEmail = $_REQUEST['ProfileEmail'];
		$ProfileMobile = $_REQUEST['ProfileMobile'];
		$ProfileCompanyName = $_REQUEST['ProfileCompanyName'];
		$ProfilePincode = $_REQUEST['ProfilePincode'];
		$ProfileAddress = $_REQUEST['ProfileAddress'];
		$ProfileAddress1 = $_REQUEST['ProfileAddress1'];
		$ProfileCountry = $_REQUEST['ProfileCountry'];
		$StateID = $_REQUEST['StateID'];
		$CityID = $_REQUEST['CityID'];
		$created_date = date('Y-m-d H:i:s');
		
		$NewDBO = date('Y-m-d', strtotime($ProfileDBO)); 
		
		$sql = mysql_query("update `profile` set ProfileLastName = '".$ProfileLastName."' , ProfileFirstName = '".$ProfileFirstName."' , ProfileDBO = '".$NewDBO."' , ProfileGender = '".$ProfileGender."' , ProfileEmail = '".$ProfileEmail."' , ProfileMobile = '".$ProfileMobile."' , ProfileCompanyName = '".$ProfileCompanyName."' , ProfilePincode = '".$ProfilePincode."' , ProfileAddress = '".$ProfileAddress."' ,ProfileAddress1 = '".$ProfileAddress1."' , ProfileCountry = '".$ProfileCountry."' , StateID = '".$StateID."' , CityID = '".$CityID."' , UpdateUserTime = '".$created_date."' where ProfileID = '".$ProfileID."' ") or die(mysql_error());
		
		$HrImage = $_FILES['HrImage']['name'];
		
		
		if($HrImage != ''){
		
			$Image = "HrImage_".$_SESSION['ProfileID'].strrchr(basename($HrImage),'.');
			copy($_FILES["HrImage"]["tmp_name"],"../upload_images/hr_images/".$Image);
			
			$sql = mysql_query("update `profile` set ProfilePicture = '".$Image."' where ProfileID = '".$_SESSION['ProfileID']."' ");
		
		}
		
		$_SESSION['Success'] = "Your Profile Successfully Updated...";
		header("location:".$RootPath."pages/corporate/edit_profile.php");
		exit();
		
	}

	if($action=='invite') {
		
		$Name = $_REQUEST['Name'];
		$Email = $_REQUEST['Email'];
		$Location = $_REQUEST['Location'];
		$AreaofInterest = $_REQUEST['AreaofInterest'];
		$Qualification = $_REQUEST['Qualification'];
		$stud_id = $_REQUEST['stud_id'];
                $created_date = date('Y-m-d H:i:s');
		
		$sql = mysql_query("insert into `invite` set CorporateID = '".$_SESSION['ProfileID']."' , StudentID = '".$stud_id."' , CreatedDate = '".$created_date."' , Status = '1' ") or die(mysql_error());
		
		$to = "support@itgyani.com";
		//$to = "shaikh.avwal@gmail.com";
		$subject = "Invitation";
		$message = "
		<html>
		<head>
		<title>Invitation Detail</title>
		</head>
		<body>
		<p>This email contains to Invite Student Detail</p>
		<p> Name : ".$Name." </p>
		<p> Email : ".$Email." </p>
		<p> Location : ".$Location." </p>
		<p> AreaofInterest : ".$AreaofInterest." </p>
		<p> Qualification : ".$Qualification." </p>
		</body>
		</html>
		";
		
		 $header = "From:support@itgyani.com \r\n";
		 $header .= "MIME-Version: 1.0\r\n";
		 $header .= "Content-type: text/html\r\n";
		 
		 $retval = mail ($to,$subject,$message,$header);
			 
		if($retval){
			echo "0";
		} else {
			echo "1";
		}
		exit();
		
	}
	
	
	if($action=='check_email'){
		$emailvalue = $_REQUEST['emailvalue'];
		
		$sql = mysql_query("select * from `profile` where ProfileEmail = '".$emailvalue."' ");
		$totalrows = mysql_num_rows($sql);
		$row = mysql_fetch_array($sql);
		
		if($totalrows!='0'){
			if($row['ProfileID']==$_SESSION['ProfileID']) {
				echo "0";
			} else {
				echo "1";
			}
		} else {
			echo "2";
		}
		exit();
	}
	
	if($action=="change_status"){
		$InviteID = $_REQUEST['InviteID'];		
		$sql = mysql_query("update `invite` set ReadByHR = '0' where InviteID = '".$InviteID."' ") or die(mysql_error());
		exit();
	}
	
	if($action=='messagetoadmin'){
		$Message = $_REQUEST['Message'];
		$InviteID = $_REQUEST['InviteID'];
		$CreatedDate = date('Y-m-d H:i:s');
		$sql_invite = mysql_query("select * from `invite` where InviteID = '".$InviteID."' ") or die(mysql_error());
		$row_invite = mysql_fetch_array($sql_invite);
		
		$sql_update = mysql_query("update `invite` set SendDate = '".$CreatedDate."' , Status = 'message_admin' where InviteID = '".$InviteID."' ") or die(mysql_error());
		
		$sql_con = mysql_query("insert into `conversation` set InviteID = '".$InviteID."' , SenderID = '".$_SESSION['ProfileID']."' , ReceivedID = '".$AdminID."' , StudentID = '".$row_invite['StudentID']."' , ReadMessage = '1' , SendDate = '".$CreatedDate."' , Message = '".$Message."' , Status = '1' "); 
		
			$to = $AdminEmail;
			$subject = "HR Mail To Admin For Student Invitation Detail ";
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
?>