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
		
		$sql_email = mysql_query("select * from  `profile` where `ProfileEmail` = '".$email."' OR `ProfileName` = '".$user_name."' ") or die(mysql_error());
		$total_email = mysql_num_rows($sql_email);
		
		if($total_email=='0') {
	
			//$sql = mysql_query("insert into  `student_register` set `user_name` = '".$user_name."' , `first_name` = '".$first_name."' , `last_name` = '".$last_name."' , `mobile` = '".$mobile."' , `dateofbirth` = '".$dateofbirth."' ,  `gender` = '".$gender."' , `email` = '".$email."' , `password` = '".md5($password)."' , `created_date` = '".$created_date."' , `status` = '0' ") or die(mysql_error());
			
			$sql = mysql_query("insert into  `profile` set GroupID = '2' , `ProfileName` = '".$user_name."' , `ProfileFirstName` = '".$first_name."' , `ProfileLastName` = '".$last_name."' , `ProfileMobile` = '".$mobile."' , `ProfileDBO` = '".$dateofbirth."' ,  `ProfileGender` = '".$gender."' , `ProfileEmail` = '".$email."' , `ProfilePassword` = '".md5($password)."' , IsFaceBook = '0',IsFaceGmail = '0', IsPaid = '0', IsActive = '0', IsActived='1',IsDeleted='0', AddUserID='0' ") or die(mysql_error());
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
		$sql = mysql_query("update `profile` set IsActive = '1' where ProfileID = '".$ProfileID."' ");
		
		$sql_user = mysql_query("select * from `profile` where ProfileID = '".$ProfileID."' ");
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
		
		$sql = mysql_query("select * from `profile` where ProfileName = '".$user_name."' AND ProfilePassword = '".md5($password)."' AND GroupID = '2' ") or die(mysql_error());
		$row = mysql_fetch_array($sql);
		
		if(empty($row)) {
			//$_SESSION['Error1'] = "Please Check Your Username And Password";
			//header("location:".$RootPath."pages/student");
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
			$active_link = $RootPath."/pages/student/";
			$message = "
			<html>
			<head>
			<title>Student Forgot Password</title>
			</head>
			<body>
			<p>This email contains to Student Forgot Password</p>
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
		
	
		//header("location:".$RootPath."pages/student/forgot_password.php");
		exit();
	}
	
	if($action=="biodata") {
		
		$sql = mysql_query("select * from `biodata` where ProfileID = '".$_SESSION['stud_id']."' ");
		$totalrows = mysql_num_rows($sql);
		
		$MiddleName = $_REQUEST['MiddleName'];
		$LastName = $_REQUEST['LastName'];
		$FirstName = $_REQUEST['FirstName'];
		$DateOfBirth = $_REQUEST['DateOfBirth'];
		$Gender = $_REQUEST['Gender'];
		$Email = $_REQUEST['Email'];
		$Mobile = $_REQUEST['Mobile'];
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
			
			$sql = mysql_query("update `biodata` set MiddleName = '".$MiddleName."' , LastName = '".$LastName."' , FirstName = '".$FirstName."' , DateOfBirth = '".$DateOfBirth."' , Gender = '".$Gender."' , Email = '".$Email."' , Mobile = '".$Mobile."' , Address = '".$Address."' , Address1 = '".$Address1."' , StateID = '".$StateID."' , CityID = '".$CityID."' , AddUserTime = '".$created_date."' , PanCard = '".$PanCard."' , PassportNo = '".$PassportNo."' ,  PassportExpiryDate = '".$PassportExpiryDate."' where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
			
		if($StudImage != ''){
		
			$Image = "ResumeImage_".$_SESSION['stud_id'].strrchr(basename($StudImage),'.');
			copy($_FILES["StudImage"]["tmp_name"],"../upload_images/resume_images/".$Image);
			
			$sql = mysql_query("update `biodata` set Photo = '".$Image."' where ProfileID = '".$_SESSION['stud_id']."' ");
		
		}
		
		} else {
			
		
		$sql = mysql_query("insert into `biodata` set MiddleName = '".$MiddleName."' , LastName = '".$LastName."' , FirstName = '".$FirstName."' , DateOfBirth = '".$DateOfBirth."' , Gender = '".$Gender."' , Email = '".$Email."' , Mobile = '".$Mobile."' , Address = '".$Address."' , Address1 = '".$Address1."' , StateID = '".$StateID."' , CityID = '".$CityID."' , AddUserTime = '".$created_date."' , ProfileID = '".$_SESSION['stud_id']."' , PanCard = '".$PanCard."' , PassportNo = '".$PassportNo."' ,  PassportExpiryDate = '".$PassportExpiryDate."' ") or die(mysql_error());
		
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
		$TwelveCollegeName = mysql_real_escape_string($_REQUEST['12ThBoard']);
		$TwelvePassingYear = $_REQUEST['12ThPassingYear'];
		$TwelvePercentage = $_REQUEST['12ThPercentage'];
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
			
			$sql = mysql_query("update `academic` set  10ThBoard = '".$TenSchoolName."' ,  10ThPassingYear = '".$TenPassingYear."' , 10ThPercentage = '".$TenPercentage."' , 12ThBoard = '".$TwelveCollegeName."' , 12ThPassingYear = '".$TwelvePassingYear."' , 12ThPercentage = '".$TwelvePercentage."' , GraduationUniversity = '".$GraduationUniversity."' , GraduationCollegeName = '".$GraduationCollegeName."' , GraduationPercentage = '".$GraduationPercentage."' , GraduationPassingYear = '".$GraduationPassingYear."' , Qualification = '".$Qualification."' , GraduationPassing01Name = '".$GraduationPassing01Name."' , GraduationPassing01Year = '".$GraduationPassing01Year."' , GraduationPassing01Per = '".$GraduationPassing01Per."' , GraduationPassing02Name = '".$GraduationPassing02Name."' ,  GraduationPassing02Year = '".$GraduationPassing02Year."' , GraduationPassing02Per = '".$GraduationPassing02Per."' , GraduationPassing03Name = '".$GraduationPassing03Name."' , GraduationPassing03Year = '".$GraduationPassing03Year."' , GraduationPassing03Per = '".$GraduationPassing03Per."' , GraduationPassing04Name = '".$GraduationPassing04Name."' ,  GraduationPassing04Year = '".$GraduationPassing04Year."' ,  GraduationPassing04Per = '".$GraduationPassing04Per."' ,  ExternalCertificationName = '".$ExternalCertificationName."' ,  ExternalCertificationPassingYear = '".$ExternalCertificationPassingYear."' ,  ExternalCertificationPassingPer = '".$ExternalCertificationPassingPer."' ,   AddUserTime = '".$created_date."' , InstituteID = '".$InstituteID."' , AllCertificate = '".$AllCertificate."' where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
		
		} else {
		
			$sql = mysql_query("insert into `academic` set ProfileID = '".$_SESSION['stud_id']."' , 10ThBoard = '".$TenSchoolName."' ,  10ThPassingYear = '".$TenPassingYear."' , 10ThPercentage = '".$TenPercentage."' , 12ThBoard = '".$TwelveCollegeName."' , 12ThPassingYear = '".$TwelvePassingYear."' , 12ThPercentage = '".$TwelvePercentage."' , GraduationUniversity = '".$GraduationUniversity."' , GraduationCollegeName = '".$GraduationCollegeName."' , GraduationPercentage = '".$GraduationPercentage."' , GraduationPassingYear = '".$GraduationPassingYear."' , Qualification = '".$Qualification."' , GraduationPassing01Name = '".$GraduationPassing01Name."' , GraduationPassing01Year = '".$GraduationPassing01Year."' , GraduationPassing01Per = '".$GraduationPassing01Per."' , GraduationPassing02Name = '".$GraduationPassing02Name."' , GraduationPassing02Year = '".$GraduationPassing02Year."' , GraduationPassing02Per = '".$GraduationPassing02Per."' , GraduationPassing03Name = '".$GraduationPassing03Name."' , GraduationPassing03Year = '".$GraduationPassing03Year."' , GraduationPassing03Per = '".$GraduationPassing03Per."' , GraduationPassing04Name = '".$GraduationPassing04Name."' ,  GraduationPassing04Year = '".$GraduationPassing04Year."' ,  GraduationPassing04Per = '".$GraduationPassing04Per."' ,  ExternalCertificationName = '".$ExternalCertificationName."' ,  ExternalCertificationPassingYear = '".$ExternalCertificationPassingYear."' ,  ExternalCertificationPassingPer = '".$ExternalCertificationPassingPer."' , InstituteID = '".$InstituteID."' , AllCertificate = '".$AllCertificate."' , AddUserTime = '".$created_date."'  ") or die(mysql_error()); 
		
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
		$video_no = $_REQUEST['video_no'];
		$video_no = $video_no + 1;
		if($video_no=='2'){
			$field = "URL02";
		} else if($video_no=='3'){
			$field = "URL03";	
		} else if($video_no=='4'){
			$field = "URL04";
		} else {
			echo "0";
			exit();
		}
		
		$sql_topic_video = mysql_query("select * from `topic` where CourseID = '1' AND TopicID = '".$TopicID."' ") or die(mysql_error());
		$row_topic_video = mysql_fetch_array($sql_topic_video);
		if($row_topic_video[$field]==NULL){
			echo "1";
			exit();
		} else {
			echo $row_topic_video[$field];
			exit();
		}
		exit();
	}
	
	if($action=="completed_test"){
		
		$TopicID = $_REQUEST['TopicID'];
		$created_date = date('Y-m-d H:i:s');
		
		$sql_test = mysql_query("select * from `test_detail` where  TopicID = '".$TopicID."' AND  ProfileID = '".$_SESSION['stud_id']."' ");
		$total_test_rows = mysql_num_rows($sql_test);
		
		if($total_test_rows!='0') {
			$sql = mysql_query("update `test_detail` set IsCompleted = '1' , TestDate = '".$created_date."' , Status = '1' where TopicID = '".$TopicID."' AND ProfileID = '".$_SESSION['stud_id']."' ");
			exit();
		} else {
			$sql = mysql_query("insert into `test_detail` set TopicID = '".$TopicID."' , ProfileID = '".$_SESSION['stud_id']."' , IsCompleted = '1' , TestDate = '".$created_date."' , Status = '1' ");
		exit();
		}
		exit();
	}
	
?>