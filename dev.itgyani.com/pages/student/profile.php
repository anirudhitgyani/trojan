<?php include('../../connection.php');
if(!isset($_SESSION['stud_id'])) {
		header("location:".$RootPath);
		exit();
	}
include('../../header_stud.php'); 

$sql_biodata = mysql_query("select * from `biodata` where ProfileID = '".$_SESSION['stud_id']."' ");
$row_biodata = mysql_fetch_array($sql_biodata);

$sql_academic = mysql_query("select * from `academic` where ProfileID = '".$_SESSION['stud_id']."' ");
$row_academic = mysql_fetch_array($sql_academic);

$sql_state = mysql_query("select StateID,StateName from `state` where IsActive = '1' ") or die(mysql_error());

$sql_city = mysql_query("select CityID,CityName from `city` where IsActive = '1' AND StateID = '".$row_biodata['StateID']."' ") or die(mysql_error());

$sql_ten = mysql_query("select * from standardpropertylist where StandardPropID = '1' ");
$sql_twelve = mysql_query("select * from standardpropertylist where StandardPropID = '2' ");
$sql_uni = mysql_query("select * from standardpropertylist where StandardPropID = '3' ");

$sql_year = mysql_query("select * from standardpropertylist where StandardPropID = '5' ");
$sql_inst = mysql_query("select * from standardpropertylist where StandardPropID = '6' ");
$sql_qua = mysql_query("select * from standardpropertylist where StandardPropID = '8' ");
?>


<div class="middle-content hr-dashbord-content" style="margin:0;">
<div class="container">
<div class="row-fluid dashbord-row"><!--
<div class="col-sm-3 col-xs-12 col-md-2 left-col">
<div class="collapse navbar-collapse left-menu" id="bs-example-navbar-collapse-1">
                                      <ul class="nav navbar-nav">
<li><a href="<?php echo $RootPath; ?>pages/student/">Dashbord <img src="<?php echo $RootPath; ?>images/dashbord/dashbord-icon.png" /></a></li>
      <li><a href="<?php echo $RootPath; ?>pages/student/profile.php">Profile <img src="<?php echo $RootPath; ?>images/dashbord/profile-icon.png" /></a></li>
      <li><a href="#">Message<img src="<?php echo $RootPath; ?>images/dashbord/message-icon.png" /></a></li>
      <li><a href="#">Activities <img src="<?php echo $RootPath; ?>images/dashbord/exam-icon.png" /></a></li>
      <li><a href="#">Projects<img src="<?php echo $RootPath; ?>images/dashbord/project-icon.png" /></a></li>
      <li><a href="#">Exams <img src="<?php echo $RootPath; ?>images/dashbord/exam-icon.png" /></a></li>
            <li><a href="#">Settings<img src="<?php echo $RootPath; ?>images/dashbord/account-icon.png" /></a></li>
                  
                        <li><a href="<?php echo $RootPath; ?>pages/student/logout.php">Logout<img src="<?php echo $RootPath; ?>images/dashbord/logout-icon.png" /></a></li>                                      </ul>
                                    </div>
</div>-->
<div class="col-sm-12 col-xs-12 col-md-12 no-padding-right right-col">
<div class="student-profile-section grey-box">
<div class="student-titles pull-left text-right"><small>Student Profile</small></div>


<?php if(isset($_SESSION['Success'])) { ?>
<br/><br/>
<div style="color:green;" class="student-titles">
    <h5><?php echo $_SESSION['Success']; ?></h5>
</div>
<?php } unset($_SESSION['Success']); ?> 

<?php if(isset($_SESSION['Error'])) { ?>
<br/><br/>
<div style="color:red;" class="student-titles">
    <h5><?php echo $_SESSION['Error']; ?></h5>
</div>
<?php } unset($_SESSION['Error']); ?> 

<div class="row-fluid student-profile-row">
<form action="<?php echo $RootPath; ?>action/student.php" method="post" id="Biodata_Form" enctype="multipart/form-data" >
	<div class="col-sm-2 col-md-2 col-xs-12 text-center">
	<div class="avtar-box">
	<div class="avtar-image">
		<?php if($row_biodata['Photo']!='') { ?>
            <img id="img1" src="<?php echo $RootPath; ?>upload_images/resume_images/<?php echo $row_biodata['Photo']; ?>" />
        <?php } else { ?>
            <img id="img1" src="<?php echo $RootPath; ?>images/avtar-image.png" />
        <?php } ?>
    </div><br/>
		<a onclick="OpenBrowser();" href="javascript:void(0);">Edit</a> 
       	<input id="uploadFile" name="StudImage" type="file" style="display:none"> 
	</div>
	</div>
    
    
<div class="col-sm-10 col-md-10 col-xs-12">
<div class="student-forms">


<input type="hidden" name="ProfileID" id="ProfileID" value="<?php echo $_SESSION['stud_id']; ?>" />
 <input type="hidden" name="action" id="action" value="biodata" />
 

<!--    <div style="" class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Student name</label>
        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" class="form-control" name="LastName" id="LastName" placeholder="Last Name" value="<?php echo $row_biodata['LastName']; ?>" >
        </div>
        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" class="form-control" id="MiddleName" name="MiddleName" placeholder="Middle Name" value="<?php echo $row_biodata['MiddleName']; ?>" >
        </div>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" id="FirstName" name="FirstName" placeholder="First Name" value="<?php echo $row_biodata['FirstName']; ?>" >
        </div>
    </div>
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Date of Birth </label>
        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" class="form-control" id="DateOfBirth" name="DateOfBirth" placeholder="Date Of Birth" value="<?php echo $row_biodata['DateOfBirth']; ?>" >
        </div>
        
        <div class="col-xs-12 col-md-6 col-sm-6"><label for="inputEmail" class="control-label">Gender </label>
            <select name="Gender" id="Gender" class="selectpicker show-tick form-control gender">
 
  <option <?php if($row_biodata['Gender']=='Male') { ?> selected="selected" <?php } ?>  value="Male" >Male</option>
  <option <?php if($row_biodata['Gender']=='Female') { ?> selected="selected" <?php } ?> value="Female" >Female</option>
</select>

        </div>
        
    </div>
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Email id </label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="email" class="form-control" id="Email" name="Email" placeholder="Enter Email Address" value="<?php echo $row_biodata['Email']; ?>" >
            <h5 id="error_email" style="color:red; display:none;" >Please Enter Valid Email</h5>
        </div>
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Phone</label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" id="Mobile" name="Mobile" placeholder="Enter Phone Number" value="<?php echo $row_biodata['Mobile']; ?>" >
            <h5 id="error_mobile" style="color:red; display:none;" >Please Enter Valid Mobile Number Only Numeric Digits</h5>
        </div>
        
        
    </div>-->
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-3">Residence Address</label>
        <div class="col-xs-12 col-md-9 col-sm-9 address-field">
            <input type="text" class="form-control" id="Address" name="Address" placeholder="Enter Address " value="<?php echo $row_biodata['Address']; ?>" >
            <input type="text" class="form-control" id="Address1" name="Address1" placeholder="Enter Address " value="<?php echo $row_biodata['Address1']; ?>" >
        </div>
       
        
        
    </div>
    
   <div class="form-group row">
   		<label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">Country</label>
   		<div class="col-xs-12 col-md-3 col-sm-2">
            <input type="text" class="form-control" name="ProfileCountry" id="ProfileCountry" placeholder="Enter Country" value="INDIA" readonly="readonly" >
        </div>
        <label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">State</label>
        <div class="col-xs-12 col-md-3 col-sm-2">
          	<select class="selectpicker show-tick form-control state" onchange="ChangeState(this.value);"  id="StateID" name="StateID" >
 				<option value="0" >Select State</option>
                <?php while($row_state = mysql_fetch_array($sql_state)) { ?>
                	<option <?php if($row_biodata['StateID']==$row_state['StateID']) { ?> selected="selected" <?php } ?> value="<?php echo $row_state['StateID']; ?>" ><?php echo $row_state['StateName']; ?></option>
                <?php } ?>
			</select>
        </div>
        <?php if($row_biodata['CityID']!='') { ?>
        	<label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">City </label>
            <div id="city_div" class="col-xs-12 col-md-3 col-sm-2">
                <select class="selectpicker show-tick form-control city" id="CityID" name="CityID" >
                <?php while($row_city = mysql_fetch_array($sql_city)) { ?>
                    <option <?php if($row_city['CityID']==$row_biodata['CityID']) { ?> selected="selected" <?php } ?> value="<?php echo $row_city['CityID']; ?>" ><?php echo $row_city['CityName']; ?></option>
                <?php } ?>    
                
                </select>
            </div>
        <?php } else { ?>
        	<label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">City </label>
            <div id="city_div" class="col-xs-12 col-md-3 col-sm-2">
                <select class="selectpicker show-tick form-control city" id="CityID" name="CityID" >
                    <option value="0" >Select City</option>
                </select>
            </div>
        <?php } ?>
        
        
        
    </div>
   
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Pancard No:</label>
        <div class="col-xs-12 col-md-6 col-sm-6">
            <input type="text" class="form-control" id="PanCard" name="PanCard" placeholder="Enter Pancard Number" value="<?php echo $row_biodata['PanCard']; ?>" >
        </div>
        
        
        
        
    </div>
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Passport no: </label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" id="PassportNo" name="PassportNo" placeholder="Enter Passport Number" value="<?php echo $row_biodata['PassportNo']; ?>" >
        </div>
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Validity Date:</label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" id="PassportExpiryDate" name="PassportExpiryDate" placeholder="Enter Validity Date" value="<?php echo $row_biodata['PassportExpiryDate']; ?>" >
        </div>
        
        
    </div>
    <div class="buttons-box text-center">
    <input type="button" onclick="SaveBiodata();" value="Submit" class="green-butt green-back" />
    <input type="button" class="green-butt" value="Cancel" /></div>
    </form>
    </div>
</div> 
</div>
</div>
<div class="profile-section">
<div class="box-titles">
<h3>Academic</h3>
</div>
<div class="grey-box">
<div class="row-fluid">
<div class="student-forms">
<form action="<?php echo $RootPath; ?>action/student.php" id="academic_form" method="post" >
<input type="hidden" name="action" id="action" value="academic" />
    <div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4">SSC Board : </label>
        <div class="col-xs-12 col-md-9 col-sm-8">
        <div class="row-fluid">
        <div class="col-sm-12 col-md-8 col-xs-12">
           <!--<input type="text" class="form-control" id="10ThBoard" name="10ThBoard" placeholder="School Name" value="<?php echo $row_academic['10ThBoard']; ?>" >-->
           <select class="form-control" id="10ThBoard" name="10ThBoard" >
               <option value="0" >Select Board</option>
               <?php while($row_ten = mysql_fetch_array($sql_ten)) { ?>
               		<option <?php if($row_academic['10ThBoard']==$row_ten['StandardPropListID']) { ?> selected="selected" <?php } ?>  value="<?php echo $row_ten['StandardPropListID']; ?>" ><?php echo $row_ten['StandardPropListName']; ?></option>
               <?php } ?>
           </select>
           
           </div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="10ThPassingYear" name="10ThPassingYear" placeholder="Year" maxlength="4" value="<?php echo $row_academic['10ThPassingYear']; ?>"  ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="10ThPercentage" name="10ThPercentage" placeholder="%" value="<?php echo $row_academic['10ThPercentage']; ?>"  ></div>
        </div>
         
        </div>
        
        
    </div>

    <div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4">SSC School Name : </label>
        <div class="col-xs-12 col-md-9 col-sm-8">
        <div class="row-fluid">
        <div class="col-sm-12 col-md-8 col-xs-12">
           <input type="text" class="form-control" id="10ThSchoolName" name="10ThSchoolName" placeholder="SSC School Name" value="<?php echo $row_academic['10ThSchoolName']; ?>" >
        </div>
           
        </div>
         
        </div>
        
        
    </div>

    <div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4">HSC Board : </label>
        <div class="col-xs-12 col-md-9 col-sm-8">
        <div class="row-fluid">
        <div class="col-sm-12 col-md-8 col-xs-12">
           <!--<input type="text" class="form-control" id="12ThBoard" name="12ThBoard" placeholder="School Name" value="<?php echo $row_academic['12ThBoard']; ?>" >-->
           <select class="form-control" id="12ThBoard" name="12ThBoard" >
               <option value="0" >Select Higher Board</option>
               <?php while($row_twelve = mysql_fetch_array($sql_twelve)) { ?>
               		<option <?php if($row_academic['12ThBoard']==$row_twelve['StandardPropListID']) { ?> selected="selected" <?php } ?> value="<?php echo $row_twelve['StandardPropListID']; ?>" ><?php echo $row_twelve['StandardPropListName']; ?></option>
               <?php } ?>
           </select>
           </div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="12ThPassingYear" name="12ThPassingYear" placeholder="Year" maxlength="4" value="<?php echo $row_academic['12ThPassingYear']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="12ThPercentage" name="12ThPercentage" placeholder="%" value="<?php echo $row_academic['12ThPercentage']; ?>" ></div>
        </div>
         
        </div>
        
        
    </div>

    <div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4">HSC College Name : </label>
        <div class="col-xs-12 col-md-9 col-sm-8">
        <div class="row-fluid">
        <div class="col-sm-12 col-md-8 col-xs-12">
           <input type="text" class="form-control" id="12ThCollegeName" name="12ThCollegeName" placeholder="HSC College Name" value="<?php echo $row_academic['12ThCollegeName']; ?>" >
        </div>
           
        </div>
         
        </div>
        
        
    </div>
    
   <div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4"> University: </label>
        <div class="col-xs-12 col-md-9 col-sm-8">
        <div class="row-fluid">
         
        <div class="col-sm-12 col-md-8 col-xs-12">
           <!--<input type="text" class="form-control" id="GraduationUniversity" name="GraduationUniversity" placeholder="Institue / College Name" value="<?php echo $row_academic['GraduationUniversity']; ?>" >-->
           <select class="form-control" id="GraduationUniversity" name="GraduationUniversity" >
               <option value="0" >Select University</option>
               <?php while($row_uni = mysql_fetch_array($sql_uni)) { ?>
               		<option <?php if($row_academic['GraduationUniversity']==$row_uni['StandardPropListID']) { ?> selected="selected" <?php } ?> value="<?php echo $row_uni['StandardPropListID']; ?>" ><?php echo $row_uni['StandardPropListName']; ?></option>
               <?php } ?>
           </select>
           </div>
<!--           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassingYear" name="GraduationPassingYear" maxlength="4" placeholder="Year" value="<?php echo $row_academic['GraduationPassingYear']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPercentage" name="GraduationPercentage" placeholder="%" value="<?php echo $row_academic['GraduationPercentage']; ?>" ></div>-->
        </div>
        <div class="row-fluid">
         <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-4">College Name: </label>
        <div class="col-sm-12 col-md-6 col-xs-12">
           <input type="text" class="form-control" id="GraduationCollegeName" name="GraduationCollegeName" placeholder="Institute/Collage Name" value="<?php echo $row_academic['GraduationCollegeName']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassingYear" name="GraduationPassingYear" placeholder="Year" maxlength="4" value="<?php echo $row_academic['GraduationPassingYear']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPercentage" name="GraduationPercentage" placeholder="%" value="<?php echo $row_academic['GraduationPercentage']; ?>"></div>
        </div>
        
        <div class="row-fluid">
            <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-4">Qualification : </label>
        <div class="col-sm-12 col-md-6 col-xs-12">
           
           <select class="form-control" id="Qualification" name="Qualification" >
               <option value="0" >Select Qualification</option>
               <?php while($row_qua = mysql_fetch_array($sql_qua)) { ?>
               		<option <?php if($row_academic['Qualification']==$row_qua['StandardPropListID']) { ?> selected="selected" <?php } ?> value="<?php echo $row_qua['StandardPropListID']; ?>" ><?php echo $row_qua['StandardPropListName']; ?></option>
               <?php } ?>
           </select>
           </div>
        </div>
            
        <div class="row-fluid">
         <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-4">Year 1 : </label>
        <div class="col-sm-12 col-md-6 col-xs-12">
           <input type="text" class="form-control" id="GraduationPassing01Name" name="GraduationPassing01Name" placeholder="Course Name" value="<?php echo $row_academic['GraduationPassing01Name']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassing01Year" name="GraduationPassing01Year" placeholder="Year" maxlength="4" value="<?php echo $row_academic['GraduationPassing01Year']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassing01Per" name="GraduationPassing01Per" placeholder="%" value="<?php echo $row_academic['GraduationPassing01Per']; ?>"></div>
        </div>
<div class="row-fluid">
         <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-4">Year 2 : </label>
        <div class="col-sm-12 col-md-6 col-xs-12">
           <input type="text" class="form-control" id="GraduationPassing02Name" name="GraduationPassing02Name" placeholder="Course Name" value="<?php echo $row_academic['GraduationPassing02Name']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassing02Year" name="GraduationPassing02Year" placeholder="Year" maxlength="4" value="<?php echo $row_academic['GraduationPassing02Year']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassing02Per" name="GraduationPassing02Per" placeholder="%" value="<?php echo $row_academic['GraduationPassing02Per']; ?>" ></div>
        </div>
        <div class="row-fluid">
         <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-4">Year 3 : </label>
        <div class="col-sm-12 col-md-6 col-xs-12">
           <input type="text" class="form-control" id="GraduationPassing03Name" name="GraduationPassing03Name" placeholder="Course Name" value="<?php echo $row_academic['GraduationPassing03Name']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassing03Year" name="GraduationPassing03Year" placeholder="Year" maxlength="4" value="<?php echo $row_academic['GraduationPassing03Year']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassing03Per" name="GraduationPassing03Per" placeholder="%" value="<?php echo $row_academic['GraduationPassing03Per']; ?>" ></div>
        </div>  
        <div class="row-fluid">
         <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-4">Year 4 : </label>
        <div class="col-sm-12 col-md-6 col-xs-12">
           <input type="text" class="form-control" id="GraduationPassing04Name" name="GraduationPassing04Name" placeholder="Course Name" value="<?php echo $row_academic['GraduationPassing04Name']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassing04Year" name="GraduationPassing04Year" placeholder="Year" maxlength="4" value="<?php echo $row_academic['GraduationPassing04Year']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="GraduationPassing04Per" name="GraduationPassing04Per" placeholder="%" value="<?php echo $row_academic['GraduationPassing04Per']; ?>" ></div>
        </div>       
        </div>
        
        
    </div>
    
    

    <div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4">External Certification: </label>
        <div class="col-xs-12 col-md-9 col-sm-8">
        <div class="row-fluid">
        <div class="col-sm-12 col-md-8 col-xs-12">
           <input type="text" class="form-control" id="ExternalCertificationName" name="ExternalCertificationName" placeholder="Course Name" value="<?php echo $row_academic['ExternalCertificationName']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="ExternalCertificationPassingYear" name="ExternalCertificationPassingYear" placeholder="Year" maxlength="4" value="<?php echo $row_academic['ExternalCertificationPassingYear']; ?>" ></div>
           <div class="col-sm-6 col-md-2 col-xs-6">
           <input type="text" class="form-control" id="ExternalCertificationPassingPer" name="ExternalCertificationPassingPer" placeholder="%" value="<?php echo $row_academic['ExternalCertificationPassingPer']; ?>" ></div>
        </div>
         
        </div>
        
        
    </div>
    
    
    
    
    
    
    
    
   <div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4">Institute Name : </label>
        <div class="col-xs-12 col-md-9 col-sm-8">
         <!--<input type="text" class="form-control" id="InstituteID" name="InstituteID" placeholder="Institute Name" value="<?php echo $row_academic['InstituteID']; ?>" >-->
         <select class="form-control" id="InstituteID" name="InstituteID" >
               <option value="0" >Select Institute</option>
               <?php while($row_inst = mysql_fetch_array($sql_inst)) { ?>
               		<option <?php if($row_academic['InstituteID']==$row_inst['StandardPropListID']) { ?> selected="selected" <?php } ?> value="<?php echo $row_inst['StandardPropListID']; ?>" ><?php echo $row_inst['StandardPropListName']; ?></option>
               <?php } ?>
           </select>
        
         
        </div>
        
        
    </div>
    
    <div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4">List of all Certificate : </label>
        <div class="col-xs-12 col-md-9 col-sm-8">

        <textarea class="form-control" placeholder="List Of All Cerificate" id="AllCertificate" name="AllCertificate" rows="5"><?php echo $row_academic['AllCertificate']; ?></textarea>
         
        </div>
        
        
    </div>
    
    <h5 id="error_number" style="color:red; display:none;" >Please Enter Only Numeric Digits In Year And Percentage </h5>
    
		<div class="buttons-box text-center">
			<input type="button" onclick="SaveAcademic();" value="Submit" class="green-butt green-back" />
			<input type="reset" class="green-butt" />
        </div>
</form>
</div>
</div>
</div>
</div>
<div class="profile-section">
<div class="box-titles">
<h3>Career Goal</h3>
</div>
<div class="grey-box">
<div class="row-fluid">
<div class="student-forms">
<form action="<?php echo $RootPath; ?>action/student.php" id="career_form" method="post" >
<input type="hidden" name="action" id="action" value="career_goal" />
<div class="form-group row-fluid">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-4">I aspire to become : </label>
        <div class="col-xs-12 col-md-9 col-sm-8">
        <textarea class="form-control" name="CareerGoal" id="CareerGoal" rows="3"><?php echo $row_academic['CareerGoal']; ?></textarea>
         
        </div>
        
        
    </div>
    <h5 id="career_error" style="color:red; display:none;" >Please Enter Manimum 20 Character... </h5>
    <div class="buttons-box text-center">
    	<input type="button" onclick="SaveCareerGoal();" value="Submit" class="green-butt green-back" />
    </div>
    
    
    
    
    </form></div></div>
</div></div>
<div class="profile-section">
<div class="box-titles">
<h3>Phychometric Report</h3>
</div>
<div class="grey-box report-box text-center">
<h4>This page will display report from Phychometric Text (BPCM)</h4>
</div></div>
<div class="profile-section">
<div class="box-titles">
<h3>Progress Report</h3>
</div>
<div class="grey-box report-box text-center">
<h4>This page will display progress report of student from analytics</h4>
</div></div>

</div>
</div>
</div>

</div>

<?php include('../../footer.php'); ?>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<script>
$( function() {
	$("#DateOfBirth").datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: "1950:<?php echo date('Y'); ?>",
		dateFormat:"yy-mm-dd",
		maxDate: '0',
        showOn: "button",
        buttonImage: "<?php echo $RootPath; ?>images/calendar-icon.gif",
        buttonImageOnly: true,
        buttonText: "Select date",
    });
} );
$( function() {
$("#PassportExpiryDate").datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: "<?php echo date('Y'); ?>:<?php echo date('Y', strtotime('+25 years')); ?>",
        dateFormat:"yy-mm-dd"
    });
} );
</script>
<script type="text/javascript">
function OpenBrowser(){
	$('#uploadFile').click();
}
</script>
<script type="text/javascript">
$(function() {
    $("#uploadFile").on("change", function()
    {
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support

        if (/^image/.test( files[0].type)){ // only image file
            var reader = new FileReader(); // instance of the FileReader
            reader.readAsDataURL(files[0]); // read the local file

            reader.onloadend = function(){ // set image data as background of div
                $('#img1').attr('src',this.result);
			}   
        }
    });
});
</script>
<script type="text/javascript">
function ChangeImage(){
	$('#image_form').submit();
}
</script>
<script type="text/javascript">
function ChangeState(stateval){
	var action = "change_state";
	$.ajax({
		method:'post',
		url:'<?php echo $RootPath; ?>action/student.php',
		data:{stateval:stateval,action:action},
		success: function(resp){
			$('#city_div').html(resp);
		}
	});
}
</script>
<script type="text/javascript">
function SaveBiodata(){
	var flag = true;
	
	/*if($('#MiddleName').val()==''){
		$('#MiddleName').css('border','1px solid red');
		flag = false;
	} else {
		$('#MiddleName').css('border','1px solid #c4dee7');
	}
	
	if($('#FirstName').val()==''){
		$('#FirstName').css('border','1px solid red');
		flag = false;
	} else {
		$('#FirstName').css('border','1px solid #c4dee7');
	}
	
	if($('#LastName').val()==''){
		$('#LastName').css('border','1px solid red');
		flag = false;
	} else {
		$('#LastName').css('border','1px solid #c4dee7');
	}
	
	if($('#ProfileCompanyName').val()==''){
		$('#ProfileCompanyName').css('border','1px solid red');
		flag = false;
	} else {
		$('#ProfileCompanyName').css('border','1px solid #c4dee7');
	}
	
	var num_exp = /^[1-9][0-9]*$/;
    var mobile = $('#Mobile').val()
    if (!mobile.match(num_exp)) {
        $('#Mobile').css('border', '1px solid red');
		$('#error_mobile').show();
        flag = false;
    } else {
		$('#error_mobile').hide();
        $('#Mobile').css('border', '1px solid #c4dee7');
    }
	
	
	if($('#DateOfBirth').val()==''){
		$('#DateOfBirth').css('border','1px solid red');
		flag = false;
	} else {
		$('#DateOfBirth').css('border','1px solid #c4dee7');
	}
	
	var emailstr = /^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	var email = $('#Email').val();
	if(!email.match(emailstr) || email==''){
		$('#Email').css('border','1px solid red');
		$('#error_email').show();
		flag = false;
	}else{
		$('#Email').css('border','1px solid #dddddd');
		$('#error_email').hide();
	}*/
	
	if($('#Address').val()==''){
		$('#Address').css('border','1px solid red');
		flag = false;
	} else {
		$('#Address').css('border','1px solid #c4dee7');
	}
	
	if($('#StateID').val()=='0'){
		$('#StateID').css('border','1px solid red');
		flag = false;
	} else {
		$('#StateID').css('border','1px solid #c4dee7');
	}
	
	if($('#CityID').val()=='0'){
		$('#CityID').css('border','1px solid red');
		flag = false;
	} else {
		$('#CityID').css('border','1px solid #c4dee7');
	}
	
	if($('#PanCard').val()==''){
		$('#PanCard').css('border','1px solid red');
		flag = false;
	} else {
		$('#PanCard').css('border','1px solid #c4dee7');
	}
	
	/*if($('#PassportNo').val()==''){
		$('#PassportNo').css('border','1px solid red');
		flag = false;
	} else {
		$('#PassportNo').css('border','1px solid #c4dee7');
	}
	
	if($('#PassportExpiryDate').val()==''){
		$('#PassportExpiryDate').css('border','1px solid red');
		flag = false;
	} else {
		$('#PassportExpiryDate').css('border','1px solid #c4dee7');
	}*/
	
	
	if(flag==false){
		return false;
	} else {
		$('#Biodata_Form').submit();
	}
}



function SaveAcademic(){
	var flag = true;
	
	if($('#10ThBoard').val()==''){
		$('#10ThBoard').css('border','1px solid red');
		flag = false;
	} else {
		$('#10ThBoard').css('border','1px solid #c4dee7');
	}
	
	var num_exp = /^[1-9][0-9]*$/;
    var TenPassingYear = $('#10ThPassingYear').val()
    if (!TenPassingYear.match(num_exp)) {
        $('#10ThPassingYear').css('border', '1px solid red');
		flag = false;
    } else {
		$('#10ThPassingYear').css('border', '1px solid #c4dee7');
    }
	
	var TenThPercentage = $('#10ThPercentage').val()
    if (!TenThPercentage.match(num_exp)) {
        $('#10ThPercentage').css('border', '1px solid red');
		flag = false;
    } else {
		$('#10ThPercentage').css('border', '1px solid #c4dee7');
    }
	
        
    if($('#10ThSchoolName').val()==''){
        $('#10ThSchoolName').css('border','1px solid red');
        flag = false;
    } else {
        $('#10ThSchoolName').css('border','1px solid #c4dee7');
    }    
	
	if($('#12ThBoard').val()==''){
		$('#12ThBoard').css('border','1px solid red');
		flag = false;
	} else {
		$('#12ThBoard').css('border','1px solid #c4dee7');
	}
	
	var TwelveThPassingYear = $('#12ThPassingYear').val()
    if (!TwelveThPassingYear.match(num_exp)) {
        $('#12ThPassingYear').css('border', '1px solid red');
		flag = false;
    } else {
		$('#12ThPassingYear').css('border', '1px solid #c4dee7');
    }
	
	var TwelveThPercentage = $('#12ThPercentage').val()
    if (!TwelveThPercentage.match(num_exp)) {
        $('#12ThPercentage').css('border', '1px solid red');
		flag = false;
    } else {
		$('#12ThPercentage').css('border', '1px solid #c4dee7');
    }
	
    if($('#12ThCollegeName').val()==''){
        $('#12ThCollegeName').css('border','1px solid red');
        flag = false;
    } else {
        $('#12ThCollegeName').css('border','1px solid #c4dee7');
    }  
        
	if($('#GraduationUniversity').val()==''){
		$('#GraduationUniversity').css('border','1px solid red');
		flag = false;
	} else {
		$('#GraduationUniversity').css('border','1px solid #c4dee7');
	}
	
	var GraduationPassingYear = $('#GraduationPassingYear').val()
    if (!GraduationPassingYear.match(num_exp)) {
        $('#GraduationPassingYear').css('border', '1px solid red');
		flag = false;
    } else {
		$('#GraduationPassingYear').css('border', '1px solid #c4dee7');
    }
	
	var GraduationPercentage = $('#GraduationPercentage').val()
    if (!GraduationPercentage.match(num_exp)) {
        $('#GraduationPercentage').css('border', '1px solid red');
		flag = false;
    } else {
		$('#GraduationPercentage').css('border', '1px solid #c4dee7');
    }
	
	if($('#Qualification').val()=='0') { 
		$('#Qualification').css('border', '1px solid red');
		flag = false;
	} else {
		$('#Qualification').css('border', '1px solid #ccc');
	}
	
	/*if($('#GraduationPassing01Name').val()==''){
		$('#GraduationPassing01Name').css('border','1px solid red');
		flag = false;
	} else {
		$('#GraduationPassing01Name').css('border','1px solid #c4dee7');
	}
	
	
	var GraduationPassing01Year = $('#GraduationPassing01Year').val()
    if (!GraduationPassing01Year.match(num_exp)) {
        $('#GraduationPassing01Year').css('border', '1px solid red');
		flag = false;
    } else {
		$('#GraduationPassing01Year').css('border', '1px solid #c4dee7');
    }
	
	var GraduationPassing01Per = $('#GraduationPassing01Per').val()
    if (!GraduationPassing01Per.match(num_exp)) {
        $('#GraduationPassing01Per').css('border', '1px solid red');
		flag = false;
    } else {
		$('#GraduationPassing01Per').css('border', '1px solid #c4dee7');
    }
	
	if($('#GraduationPassing02Name').val()==''){
		$('#GraduationPassing02Name').css('border','1px solid red');
		flag = false;
	} else {
		$('#GraduationPassing02Name').css('border','1px solid #c4dee7');
	}
	
	var GraduationPassing02Year = $('#GraduationPassing02Year').val()
    if (!GraduationPassing02Year.match(num_exp)) {
        $('#GraduationPassing02Year').css('border', '1px solid red');
		flag = false;
    } else {
		$('#GraduationPassing02Year').css('border', '1px solid #c4dee7');
    }
	
	var GraduationPassing02Per = $('#GraduationPassing02Per').val()
    if (!GraduationPassing02Per.match(num_exp)) {
        $('#GraduationPassing02Per').css('border', '1px solid red');
		flag = false;
    } else {
		$('#GraduationPassing02Per').css('border', '1px solid #c4dee7');
    }
	
	if($('#GraduationPassing03Name').val()!=''){
		
		var GraduationPassing03Year = $('#GraduationPassing03Year').val()
		if (!GraduationPassing03Year.match(num_exp)) {
			$('#GraduationPassing03Year').css('border', '1px solid red');
			flag = false;
		} else {
			$('#GraduationPassing03Year').css('border', '1px solid #c4dee7');
		}
		
		var GraduationPassing03Per = $('#GraduationPassing03Per').val()
		if (!GraduationPassing03Per.match(num_exp)) {
			$('#GraduationPassing03Per').css('border', '1px solid red');
			flag = false;
		} else {
			$('#GraduationPassing03Per').css('border', '1px solid #c4dee7');
		}
	
	}
	
	if($('#GraduationPassing04Name').val()!='') {
	
		var GraduationPassing04Year = $('#GraduationPassing04Year').val()
		if (!GraduationPassing04Year.match(num_exp)) {
			$('#GraduationPassing04Year').css('border', '1px solid red');
			flag = false;
		} else {
			$('#GraduationPassing04Year').css('border', '1px solid #c4dee7');
		}
		
		var GraduationPassing04Per = $('#GraduationPassing04Per').val()
		if (!GraduationPassing04Per.match(num_exp)) {
			$('#GraduationPassing04Per').css('border', '1px solid red');
			flag = false;
		} else {
			$('#GraduationPassing04Per').css('border', '1px solid #c4dee7');
		}
	
	}
	
	
	
	if($('#ExternalCertificationName').val()!=''){
	
		var ExternalCertificationPassingYear = $('#ExternalCertificationPassingYear').val()
		if (!ExternalCertificationPassingYear.match(num_exp)) {
			$('#ExternalCertificationPassingYear').css('border', '1px solid red');
			flag = false;
		} else {
			$('#ExternalCertificationPassingYear').css('border', '1px solid #c4dee7');
		}
		
		var ExternalCertificationPassingPer = $('#ExternalCertificationPassingPer').val()
		if (!ExternalCertificationPassingPer.match(num_exp)) {
			$('#ExternalCertificationPassingPer').css('border', '1px solid red');
			flag = false;
		} else {
			$('#ExternalCertificationPassingPer').css('border', '1px solid #c4dee7');
		}
	
		if ($('#InstituteID').val()=='') {
			$('#InstituteID').css('border', '1px solid red');
			flag = false;
		} else {
			$('#InstituteID').css('border', '1px solid #c4dee7');
		}
	
	} */
	
	
	if(flag==false){
		return false;
	} else {
		$('#academic_form').submit();
	}

}

</script>
<script type="text/javascript">
function SaveCareerGoal(){
	
	if($('#CareerGoal').val().length < 20) {
		$('#CareerGoal').css('border','1px solid red');
		$('#career_error').show();
	} else {
		$('#career_form').submit();
		$('#career_error').hide();		
	}

}
</script>