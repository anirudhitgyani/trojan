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
		$created_date = date('Y-m-d H:i:s');
		$newdateofbirth = date('Y-m-d',strtotime($dateofbirth));
		$sql_email = mysql_query("select * from  `profile` where `ProfileEmail` = '".$email."' ") or die(mysql_error());
		$total_email = mysql_num_rows($sql_email);
		
		if($total_email=='0') {
	
			//$sql = mysql_query("insert into  `student_register` set `user_name` = '".$user_name."' , `first_name` = '".$first_name."' , `last_name` = '".$last_name."' , `mobile` = '".$mobile."' , `dateofbirth` = '".$dateofbirth."' ,  `gender` = '".$gender."' , `email` = '".$email."' , `password` = '".md5($password)."' , `created_date` = '".$created_date."' , `status` = '0' ") or die(mysql_error());
			
			$sql = mysql_query("insert into  `profile` set GroupID = '2' , `ProfileFirstName` = '".$first_name."' , `ProfileLastName` = '".$last_name."' , `ProfileMobile` = '".$mobile."' , `ProfileDBO` = '".$newdateofbirth."' ,  `ProfileGender` = '".$gender."' , `ProfileEmail` = '".$email."' , `ProfilePassword` = '".md5($password)."' , IsFaceBook = '0',IsFaceGmail = '0', IsPaid = '0', IsActive = '1', IsActived='1',IsDeleted='0', AddUserID='0' , ProfileStatus = '25' ") or die(mysql_error());
			$Lastid = mysql_insert_id();
			//$_SESSION['Success1'] = "Your Register Successfully Please Check Your Email";
			
			
			$to = $email;
			$subject = "Student Registration";
			$active_link = $RootPath."action/student.php?action=active_link&ProfileID=".$Lastid;
			$message = "
			<html>
			<head>
			<title>Student Registration</title>
			</head>
			<body>
			<p>Dear ".$first_name."</p>
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
			
			//$_SESSION['Error1'] = "Email OR Username Already Register Please Try With Other One.";
			echo "1";
			exit();
		}
		//header("location:".$RootPath."pages/student/registration.php");
		
 		
	}
	
	
	if($action=='active_link') {
		
		$ProfileID= $_REQUEST['ProfileID'];
		$sql = mysql_query("update `profile` set status = '1' where ProfileID = '".$id."' ");
		
		$sql_user = mysql_query("select * from `profile` where ProfileID = '".$id."' ");
		$row_user = mysql_fetch_array($sql_user);
		
			$to = $row_user['ProfileEmail'];
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
			
			$header = "From:support@itgyani.com \r\n";
			 //$header .= "Cc:anirudh272@gmail.com \r\n";
			 $header .= "MIME-Version: 1.0\r\n";
			 $header .= "Content-type: text/html\r\n";
			 
			 $retval = mail ($to,$subject,$message,$header);
 
		
		
		header("location:".$RootPath."pages/student/thank_you.php");
		exit();
	
	}
	
	if($action=='login') {
		
		$user_name = $_REQUEST['user_name'];
		$password = $_REQUEST['password'];
		
		$sql = mysql_query("select * from `profile` where ProfileEmail = '".$user_name."' AND ProfilePassword = '".md5($password)."' AND GroupID = '2' ") or die(mysql_error());
		$row = mysql_fetch_array($sql);
		
		if(empty($row)) {
			//$_SESSION['Error1'] = "Please Check Your Username And Password";
			//header("location:".$RootPath."pages/student");
			$_SESSION['ProfileEmail'] = $user_name;
			$_SESSION['ProfilePassword'] = $password;
			echo "0";
			exit();
		} else {
			if($row['IsActive']=='0') {
				//$_SESSION['Error1'] = "Please Activate Your Account...";
				//header("location:".$RootPath."pages/student");
				echo "1";
				exit();
			} else {
				$_SESSION['stud_id'] = $row['ProfileID'];
				//header("location:".$RootPath."pages/student_dashboard");
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
			
			//$_SESSION['success'] = "Your Password Is Send To Your Email Please Check Your Email";
			
			$to = $f_email;
			$subject = "Student Forgot Password";
			//$active_link = $RootPath."/pages/student/";
			$active_link = $RootPath."/pages/student/change_password.php?ProfileID=".$row_femail['ProfileID'];
			$message = "
			<html>
			<head>
			<title>Student Forgot Password</title>
			</head>
			<body>
			<p>This email contains to Student Forgot Password Link</p>
			<a href='".$active_link."'> Click Here For Change Password</a>
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
		
	
		//header("location:".$RootPath."pages/student/forgot_password.php");
		exit();
	}
	
	if($action=="biodata") {
		
		$sql = mysql_query("select * from `biodata` where ProfileID = '".$_SESSION['stud_id']."' ");
		$totalrows = mysql_num_rows($sql);
		
		$Address = $_REQUEST['Address'];
		$Address1 = $_REQUEST['Address1'];
		$StateID = $_REQUEST['StateID'];
		$CityID = $_REQUEST['CityID'];
		$PanCard = $_REQUEST['PanCard'];
		$PassportNo = $_REQUEST['PassportNo'];
		$PassportExpiryDate = $_REQUEST['PassportExpiryDate'];
		$created_date = date('Y-m-d H:i:s');
		$StudImage = $_FILES['StudImage']['name'];
		
		if($totalrows!='') {
			
			$sql = mysql_query("update `biodata` set Address = '".$Address."' , Address1 = '".$Address1."' , StateID = '".$StateID."' , CityID = '".$CityID."' , AddUserTime = '".$created_date."' , PanCard = '".$PanCard."' , PassportNo = '".$PassportNo."' ,  PassportExpiryDate = '".$PassportExpiryDate."' where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
			
		if($StudImage != ''){
		
			$Image = "ResumeImage_".$_SESSION['stud_id'].strrchr(basename($StudImage),'.');
			copy($_FILES["StudImage"]["tmp_name"],"../upload_images/resume_images/".$Image);
			
			$sql = mysql_query("update `biodata` set Photo = '".$Image."' where ProfileID = '".$_SESSION['stud_id']."' ");
		
		}
		
		} else {
			
		
		$sql = mysql_query("insert into `biodata` set Address = '".$Address."' , Address1 = '".$Address1."' , StateID = '".$StateID."' , CityID = '".$CityID."' , AddUserTime = '".$created_date."' , ProfileID = '".$_SESSION['stud_id']."' , PanCard = '".$PanCard."' , PassportNo = '".$PassportNo."' ,  PassportExpiryDate = '".$PassportExpiryDate."' ") or die(mysql_error());
		
		$sql2 = mysql_query("update `profile` set ProfileStatus = '60' where ProfileID = '".$_SESSION['stud_id']."' ");
		
		if($StudImage != ''){
		
			$Image = "ResumeImage_".$_SESSION['stud_id'].strrchr(basename($StudImage),'.');
			copy($_FILES["StudImage"]["tmp_name"],"../upload_images/resume_images/".$Image);
			
			$sql = mysql_query("update `biodata` set Photo = '".$Image."' where ProfileID = '".$_SESSION['stud_id']."' ");
		
		}
		
		}
		
		$_SESSION['Success'] = "Your Profile Successfully Updated...";
		header("location:".$RootPath."pages/student/profile.php");
		exit();
		
	}	
	
	if($action=='academic') {
		
		$sql = mysql_query("select * from academic where ProfileID = '".$_SESSION['stud_id']."' ");
		$totalrows = mysql_num_rows($sql);
		
		
		$TenSchoolName = mysql_real_escape_string($_REQUEST['10ThBoard']);
		$TenPassingYear = $_REQUEST['10ThPassingYear'];
		$TenPercentage = $_REQUEST['10ThPercentage'];
        $TenSchoolName_1 = mysql_real_escape_string($_REQUEST['10ThSchoolName']);
		$TwelveCollegeName = mysql_real_escape_string($_REQUEST['12ThBoard']);
		$TwelvePassingYear = $_REQUEST['12ThPassingYear'];
		$TwelvePercentage = $_REQUEST['12ThPercentage'];
        $TwelveCollegeName_1 = mysql_real_escape_string($_REQUEST['12ThCollegeName']);
		$GraduationUniversity = mysql_real_escape_string($_REQUEST['GraduationUniversity']);
        $GraduationCollegeName = mysql_real_escape_string($_REQUEST['GraduationCollegeName']);
		$GraduationPercentage = $_REQUEST['GraduationPercentage'];
		$GraduationPassingYear = $_REQUEST['GraduationPassingYear'];
        $Qualification = $_REQUEST['Qualification'];
		$GraduationPassing01Name = mysql_real_escape_string($_REQUEST['GraduationPassing01Name']);
		$GraduationPassing01Year = $_REQUEST['GraduationPassing01Year'];
		$GraduationPassing01Per = $_REQUEST['GraduationPassing01Per'];
		$GraduationPassing02Name = mysql_real_escape_string($_REQUEST['GraduationPassing02Name']);
		$GraduationPassing02Year = $_REQUEST['GraduationPassing02Year'];
		$GraduationPassing02Per = $_REQUEST['GraduationPassing02Per'];
		$GraduationPassing03Name = mysql_real_escape_string($_REQUEST['GraduationPassing03Name']);
		$GraduationPassing03Year = $_REQUEST['GraduationPassing03Year'];
		$GraduationPassing03Per = $_REQUEST['GraduationPassing03Per'];
		$GraduationPassing04Name = mysql_real_escape_string($_REQUEST['GraduationPassing04Name']);
		$GraduationPassing04Year = $_REQUEST['GraduationPassing04Year'];
		$GraduationPassing04Per = $_REQUEST['GraduationPassing04Per'];
		$ExternalCertificationName = mysql_real_escape_string($_REQUEST['ExternalCertificationName']);
		$ExternalCertificationPassingYear = $_REQUEST['ExternalCertificationPassingYear'];
		$ExternalCertificationPassingPer = $_REQUEST['ExternalCertificationPassingPer'];
		$InstituteID = mysql_real_escape_string($_REQUEST['InstituteID']);
		$AllCertificate = mysql_real_escape_string($_REQUEST['AllCertificate']);
		
		$created_date = date("Y-m-d H:i:s");
		
		
		if($totalrows!=''){
			
			$sql = mysql_query("update `academic` set  10ThBoard = '".$TenSchoolName."' ,  10ThPassingYear = '".$TenPassingYear."' , 10ThPercentage = '".$TenPercentage."' , 10ThSchoolName = '".$TenSchoolName_1."' , 12ThBoard = '".$TwelveCollegeName."' , 12ThPassingYear = '".$TwelvePassingYear."' , 12ThPercentage = '".$TwelvePercentage."' , 12ThCollegeName = '".$TwelveCollegeName_1."' , GraduationUniversity = '".$GraduationUniversity."' , GraduationCollegeName = '".$GraduationCollegeName."' , GraduationPercentage = '".$GraduationPercentage."' , GraduationPassingYear = '".$GraduationPassingYear."' , Qualification = '".$Qualification."' , GraduationPassing01Name = '".$GraduationPassing01Name."' , GraduationPassing01Year = '".$GraduationPassing01Year."' , GraduationPassing01Per = '".$GraduationPassing01Per."' , GraduationPassing02Name = '".$GraduationPassing02Name."' ,  GraduationPassing02Year = '".$GraduationPassing02Year."' , GraduationPassing02Per = '".$GraduationPassing02Per."' , GraduationPassing03Name = '".$GraduationPassing03Name."' , GraduationPassing03Year = '".$GraduationPassing03Year."' , GraduationPassing03Per = '".$GraduationPassing03Per."' , GraduationPassing04Name = '".$GraduationPassing04Name."' ,  GraduationPassing04Year = '".$GraduationPassing04Year."' ,  GraduationPassing04Per = '".$GraduationPassing04Per."' ,  ExternalCertificationName = '".$ExternalCertificationName."' ,  ExternalCertificationPassingYear = '".$ExternalCertificationPassingYear."' ,  ExternalCertificationPassingPer = '".$ExternalCertificationPassingPer."' ,   AddUserTime = '".$created_date."' , InstituteID = '".$InstituteID."' , AllCertificate = '".$AllCertificate."' where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
		
		} else {
		
			$sql = mysql_query("insert into `academic` set ProfileID = '".$_SESSION['stud_id']."' , 10ThBoard = '".$TenSchoolName."' ,  10ThPassingYear = '".$TenPassingYear."' , 10ThPercentage = '".$TenPercentage."' , 10ThSchoolName = '".$TenSchoolName_1."' , 12ThBoard = '".$TwelveCollegeName."' , 12ThPassingYear = '".$TwelvePassingYear."' , 12ThPercentage = '".$TwelvePercentage."' , 12ThCollegeName = '".$TwelveCollegeName_1."' , GraduationUniversity = '".$GraduationUniversity."' , GraduationCollegeName = '".$GraduationCollegeName."' , GraduationPercentage = '".$GraduationPercentage."' , GraduationPassingYear = '".$GraduationPassingYear."' , Qualification = '".$Qualification."' , GraduationPassing01Name = '".$GraduationPassing01Name."' , GraduationPassing01Year = '".$GraduationPassing01Year."' , GraduationPassing01Per = '".$GraduationPassing01Per."' , GraduationPassing02Name = '".$GraduationPassing02Name."' , GraduationPassing02Year = '".$GraduationPassing02Year."' , GraduationPassing02Per = '".$GraduationPassing02Per."' , GraduationPassing03Name = '".$GraduationPassing03Name."' , GraduationPassing03Year = '".$GraduationPassing03Year."' , GraduationPassing03Per = '".$GraduationPassing03Per."' , GraduationPassing04Name = '".$GraduationPassing04Name."' ,  GraduationPassing04Year = '".$GraduationPassing04Year."' ,  GraduationPassing04Per = '".$GraduationPassing04Per."' ,  ExternalCertificationName = '".$ExternalCertificationName."' ,  ExternalCertificationPassingYear = '".$ExternalCertificationPassingYear."' ,  ExternalCertificationPassingPer = '".$ExternalCertificationPassingPer."' , InstituteID = '".$InstituteID."' , AllCertificate = '".$AllCertificate."' , AddUserTime = '".$created_date."'  ") or die(mysql_error()); 
		
		
		
		$sql2 = mysql_query("update `profile` set ProfileStatus = '100' where ProfileID = '".$_SESSION['stud_id']."' ");
		
		
}
		
		
		$_SESSION['Success'] = "Your Profile Successfully Updated...";
		header("location:".$RootPath."pages/student/profile.php");
		exit();
		
	
	}
	
	if($action=='check_email'){
		$emailvalue = $_REQUEST['emailvalue'];
		
		$sql = mysql_query("select * from `profile` where ProfileEmail = '".$emailvalue."' ");
		$totalrows = mysql_num_rows($sql);
		$row = mysql_fetch_array($sql);
		
		if($totalrows!='0'){
			if($row['ProfileID']==$_SESSION['stud_id']) {
				echo "0";
			} else {
				echo "1";
			}
		} else {
			echo "2";
		}
		exit();
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
	if($action=="myaccount") {
		
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
		
		$sql = mysql_query("update `profile` set  ProfileLastName = '".$ProfileLastName."' , ProfileFirstName = '".$ProfileFirstName."' , ProfileDBO = '".$NewDBO."' , ProfileGender = '".$ProfileGender."' , ProfileEmail = '".$ProfileEmail."' , ProfileMobile = '".$ProfileMobile."' , ProfileCompanyName = '".$ProfileCompanyName."' , ProfilePincode = '".$ProfilePincode."' , ProfileAddress = '".$ProfileAddress."' ,ProfileAddress1 = '".$ProfileAddress1."' , ProfileCountry = '".$ProfileCountry."' , StateID = '".$StateID."' , CityID = '".$CityID."' , UpdateUserTime = '".$created_date."' where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
		
		$Stud_Image_Profile = $_FILES['Stud_Image_Profile']['name'];
		
		
		if($Stud_Image_Profile != ''){
		
			$Image = "Stud_Profile_".$_SESSION['stud_id'].strrchr(basename($Stud_Image_Profile),'.');
			copy($_FILES["Stud_Image_Profile"]["tmp_name"],"../upload_images/stud_images/".$Image);
			
			$sql = mysql_query("update `profile` set ProfilePicture = '".$Image."' where ProfileID = '".$_SESSION['stud_id']."' ");
		
		}
		
		$_SESSION['Success'] = "Your Profile Successfully Updated...";
		header("location:".$RootPath."pages/student/myaccount.php");
		exit();
		
	}
	
	
	if($action=="change_video"){
		$TopicID = $_REQUEST['TopicID'];
		$CourseID = $_REQUEST['CourseID'];
		$video_no = $_REQUEST['video_no'];
		$video_no = $video_no + 1;
		if($video_no=='2'){
			$field = "URL02";
                        $field_1 = "URL02Locked";
		} else if($video_no=='3'){
			$field = "URL03";
                        $field_1 = "URL03Locked";
		} else if($video_no=='4'){
			$field = "URL04";
                        $field_1 = "URL04Locked";
		} else {
			echo "0";
			exit();
		}
		
		$sql_topic_video = mysql_query("select * from `topic` where CourseID = '".$CourseID."' AND TopicID = '".$TopicID."' ") or die(mysql_error());
		$row_topic_video = mysql_fetch_array($sql_topic_video);
		
                $sql_user = mysql_query("select * from `profile` where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
                $row_user = mysql_fetch_array($sql_user);
                
                if($row_topic_video[$field]==NULL){
			echo "1";
			exit();
		} else {
                    
                    if($row_user['IsPaid']=='1') {
                        
                        echo $row_topic_video[$field];
                        exit();
                        
                    } else {
                    
                        if($row_topic_video[$field_1]=='1') {
                        //echo "3";
                        echo $row_topic_video[$field];
                        exit();
                        } else {
                            echo "2";
                            exit();
                        }
                    }
                    
                }
		exit();
	}
	
	if($action=="completed_test"){
		
		$TopicID = $_REQUEST['TopicID'];
		$CourseID = $_REQUEST['CourseID'];
		$created_date = date('Y-m-d H:i:s');
		
		$sql_test = mysql_query("select * from `test_detail` where  TopicID = '".$TopicID."' AND  ProfileID = '".$_SESSION['stud_id']."' ");
		$total_test_rows = mysql_num_rows($sql_test);
		
		if($total_test_rows!='0') {
			$sql = mysql_query("update `test_detail` set IsCompleted = '1' , TestDate = '".$created_date."' , Status = '1' where TopicID = '".$TopicID."' AND ProfileID = '".$_SESSION['stud_id']."' ");
			exit();
		} else {
			$sql = mysql_query("insert into `test_detail` set TopicID = '".$TopicID."' ,  CourseID = '".$CourseID."' , ProfileID = '".$_SESSION['stud_id']."' , IsCompleted = '1' , TestDate = '".$created_date."' , Status = '1' ");
		exit();
		}
		exit();
	}
	
	if($action=='career_goal'){
		
		$CareerGoal = mysql_real_escape_string($_REQUEST['CareerGoal']);
		$sql = mysql_query("update `academic` set CareerGoal = '".$CareerGoal."' where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
		
		$_SESSION['Success'] = "Your Career Goal Successfully Updated...";
		header("location:".$RootPath."pages/student/profile.php");
		exit();
		
	}
	
	if($action=='change_student_email'){
		$emailvalue = $_REQUEST['emailvalue'];
		
		$sql_email = mysql_query("update `profile` set `ProfileEmail` = '".$emailvalue."' where `ProfileID` = '".$_SESSION['stud_id']."' ") or die(mysql_error());
		echo "1";
		exit();
	}
	
	if($action=='change_password'){
		$password = $_REQUEST['password'];
                $ProfileID = $_REQUEST['ProfileID'];
		$sql_email = mysql_query("update `profile` set `ProfilePassword` = '".md5($password)."' where `ProfileID` = '".$ProfileID."' ") or die(mysql_error());
		echo "1";
		exit();
	}

	if($action=='refer_friend'){
		$emailvalue = $_REQUEST['emailvalue'];
		
		$sql_user = mysql_query("select * from `profile` where ProfileID = '".$_SESSION['stud_id']."' ");
		$row_user = mysql_fetch_array($sql_user);
		
		$to = $emailvalue;
		$subject = "Refer Link";
		$active_link = $RootPath;
		$message = "
		<html>
		<head>
		<title>Your Friend Refer To You</title>
		</head>
		<body>
		<p>This email contains to Reference Link</p>
                <p> Dear ".$emailvalue.",<br/>
                     You have been invited by your friend ".$row_user['ProfileName']." to join ITGYANI program to prepare you for your 1st IT Job. <br/><br/>
                          Reference Link is below - <br/>
                            <a href='".$active_link."'> ".$RootPath." </a>  <br/><br/>
                </p>                
		<p> From : ".$row_user['ProfileName']."</p> 
		<p> Name : ".$row_user['ProfileFirstName']." </p>
		<p> Email : ".$row_user['ProfileEmail']." </p> <br/>
                <p> Warm regards, <br/>
                    Team IT Gyani <br/>
                    <a href='www.itgyani.com'>www.itgyani.com</a></p>  

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
				
	}
	
	if($action=='save_user_answer'){
		
		$QuestionSetID = $_REQUEST['QuestionSetID'];
		$useranswer = $_REQUEST['useranswer'];
                //$PercentagePerQuestion = $_REQUEST['PercentagePerQuestion'];
		
		$sql = mysql_query("select * from QuestionSet where QuestionSetID = '".$QuestionSetID."' ") or die(mysql_error());
		$row = mysql_fetch_array($sql);
		
		if($useranswer=='1') {
			if($row['IsAnswer01Ok']=='1') {
				//echo "1";
                                $answerstatus = "true";
			} else {
				//echo "0";
                                $answerstatus = "false";
			}
		} else if($useranswer=='2') {
			if($row['IsAnswer02Ok']=='1') {
				//echo "1";
                                $answerstatus = "true";
			} else {
				//echo "0";
                                $answerstatus = "false";
			}
		} else if($useranswer=='3') {
			if($row['IsAnswer03Ok']=='1') {
				//echo "1";
                                $answerstatus = "true";
			} else {
				//echo "0";
                                $answerstatus = "false";
			}
		} else if($useranswer=='4') {
			if($row['IsAnswer04Ok']=='1') {
				//echo "1";
                                $answerstatus = "true";
			} else {
				//echo "0";
                                $answerstatus = "false";
			}
		}
              
                $sql_course = mysql_query("select * from `topic` where TopicID = '".$row['TopicID']."' ") or die(mysql_error());
                $row_course = mysql_fetch_array($sql_course);
              
                $sql2 = mysql_query("select * from `student_result` where ProfileID = '".$_SESSION['stud_id']."' AND CourseID = '".$row_course['CourseID']."' AND TopicID = '".$row['TopicID']."' AND  QuestionSetID = '".$QuestionSetID."' ") or die(mysql_error());
                $total_row2 = mysql_num_rows($sql2);
                
                if($total_row2=='0') {
                    $sql1 = mysql_query("insert into `student_result` set ProfileID = '".$_SESSION['stud_id']."' , CourseID = '".$row_course['CourseID']."' , TopicID = '".$row['TopicID']."' , QuestionSetID = '".$QuestionSetID."' , AnswerStatus = '".$answerstatus."' , Status = '1' ");
                    if($answerstatus=='true'){
                        echo "1";
                    } else {
                        echo "0";
                    }
                } else {
                    $sql1 = mysql_query("update `student_result` set  AnswerStatus = '".$answerstatus."' , Status = '1' where ProfileID = '".$_SESSION['stud_id']."' AND CourseID = '".$row_course['CourseID']."' AND TopicID = '".$row['TopicID']."' AND QuestionSetID = '".$QuestionSetID."' ");
                    if($answerstatus=='true'){
                        echo "1";
                    } else {
                        echo "0";
                    }
                }
                exit();
	}
        
        
        if($action=='change_question'){
            $TopicID = $_REQUEST['TopicID'];
            $CourseID = $_REQUEST['CourseID'];
            $NextQuestionID = $_REQUEST['NextQuestionID'];
            $sql_test = mysql_query("select * from `QuestionSet` where TopicID = '".$TopicID."' AND QuestionSetID = '".$NextQuestionID."' " ) or die(mysql_error());
            $row_test = mysql_fetch_array($sql_test);
            
            $sql_question_nextid= mysql_query("SELECT * FROM `QuestionSet` WHERE TopicID = '".$TopicID."' AND QuestionSetID > '".$row_test['QuestionSetID']."' ORDER BY QuestionSetID ASC  LIMIT 1") or die(mysql_error()); 
            $row_question_nextid = mysql_fetch_array($sql_question_nextid);
            $NextQuestionID = $row_question_nextid['QuestionSetID'];
            ?>

            <div style="margin-top: 20px;" id="Question_Div" >
    
                <input type="hidden" name="NextQuestionID" id="NextQuestionID" value="<?php echo $NextQuestionID; ?>" />
    
    Question <label> <?php echo $row_test['Question']; ?> </label> <br/><br/>
            Answers :  
			
			<!--option 1-->
            <?php if($row_test['Answer01']) { ?>
			<?php echo $row_test['Answer01'] ?>   <input type="radio" name="answer_1" id="answer_1" onclick="SaveAnswer('1','<?php echo $row_test['QuestionSetID']; ?>');" value="<?php echo $row_test['Answer01'] ?>" /> <br/><br/>
            <?php } ?>
                     
				<!--option 2-->
                <?php if($row_test['Answer02']) { ?>	 
					 <?php echo $row_test['Answer02'] ?>   <input type="radio" name="answer_2" id="answer_2" onclick="SaveAnswer('2','<?php echo $row_test['QuestionSetID']; ?>');" value="<?php echo $row_test['Answer02'] ?>" /> <br/><br/>   
                      <?php } ?>
                      
				<!--option 3-->
                <?php if($row_test['Answer03']) { ?>	  
					  <?php echo $row_test['Answer03'] ?>  <input type="radio" name="answer_3" id="answer_3" onclick="SaveAnswer('3','<?php echo $row_test['QuestionSetID']; ?>');" value="<?php echo $row_test['Answer03'] ?>" /> <br/><br/>  
                      <?php } ?>
				<!--option 4-->
                	<?php if($row_test['Answer04']) { ?>  
					  <?php echo $row_test['Answer04'] ?>   <input type="radio" name="answer_4" id="answer_4" onclick="SaveAnswer('4','<?php echo $row_test['QuestionSetID']; ?>');" value="<?php echo $row_test['Answer04'] ?>" /><br/><br/>
                  <?php } ?>    
                      
<img style="display:none;" id="right_img" src="<?php echo $RootPath; ?>images/right.png" height="100px;" width="100px;" />
<img style="display:none;" id="wrong_img" src="<?php echo $RootPath; ?>images/wrong.png" height="100px;" width="100px;" />                        


    <div  style="margin-top: 30px;"  class="buttons-box text-center">

        <?php if($NextQuestionID) { ?>
            <input type="button" id="Question_Button" onclick="NextQuestion('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" value="Next" class="green-butt green-back" />
        <?php } ?>
        <input type="button" onclick="CompletedTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" value="Submit" class="green-butt green-back" />
        <input type="button" onclick="CancelTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" class="green-butt" value="Cancel" />
        <input type="button" onclick="RestartTest();" class="green-butt green-back" value="Restart Test" />

    </div>

</div>

        <?php exit();
        }
		
		
        if($action=='change_password') {
            $password = $_REQUEST['password'];
            $ProfileID = $_REQUEST['ProfileID'];

            $sql = mysql_query("update `profile` set ProfilePassword = '".md5($password)."' where ProfileID = '".$ProfileID."' ") or die(mysql_error());      
            if($sql){
                echo "0";
                            exit();
            } else {
                echo "1";
                            exit();
            }
                    exit();
	}
        
        if($action="no_test"){
            
            $TopicID = $_REQUEST['TopicID'];
            $CourseID = $_REQUEST['CourseID'];
            $NextTopicID = $_REQUEST['NextTopicID'];
            
            $sql = mysql_query("select * from `topic` where TopicID = '".$NextTopicID."' AND CourseID = '".$CourseID."'  ") or die(mysql_error());
            echo $total_rows = mysql_num_rows($sql);
            exit();
            
            
        }
?>
