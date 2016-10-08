<?php include('../../connection.php');
	if(!isset($_SESSION['ProfileID'])) {
		header("location:".$RootPath);
		exit();
	}

include('../../header_1.php');


$sql_profile = mysql_query("select * from `profile` where GroupID = '2' ") or die(mysql_error());

$sql_profile_1 = mysql_query("select * from `profile` where GroupID = '2' ") or die(mysql_error());

$sql_detail = mysql_query("select * from `profile` where GroupID = '2' ") or die(mysql_error());

$sql_invite = mysql_query("select * from `invite` where CorporateID = '".$_SESSION['ProfileID']."' AND Status = 'accept' ") or die(mysql_error());


?>
<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<?php // include('sidebar.php'); ?>
<div class="col-sm-12 col-xs-12 col-md-12 no-padding-right no-padding-left right-col">
<div class="row">

<div class="col-sm-12 col-xs-12 col-md-12">
<div class="dashbord-page-heading">
<h1>Dashboard</h1>
<p>Welcome back <?php echo $row_user['ProfileName']; ?></p>
</div>
</div></div>
<div class="row-fluid grey-box hr-overviews">
<div class="col-sm-12 col-xs-12 col-md-6">
<div class="white-shade-box treding-now-box">
<h2>Trending Now </h2>
<ul>
<li>UI Developer</li>
<li>Java Developer</li>
<li>Mobile Developer</li>
<li>Digital Marketing</li>
<li>Sales Manager</li>
<li>Accounting</li>
<li>Web Developer</li>
<li>Business Analyst</li>
<li>Selenium</li>
<li>Product Manager</li>
<li>Data Scientist</li>
<li>UX/UI Designer</li>
</ul>
</div>
</div>
<div class="col-sm-6 col-xs-6 col-md-3">
<div class="white-shade-box daily-visiters text-center">
<h3 class="text-uppercase">Daily Visitors</h3>
<img src="<?php echo $RootPath; ?>images/dashbord/daily-visiter-icon.png" /><br/>
<a href="javascript:void(0);" class="grey-button">View more</a>
</div>
</div>
<div class="col-sm-6 col-xs-6 col-md-3">
<div class="white-shade-box my-profiles-box text-center">
<h3 class="text-uppercase">My Profile</h3>
<?php if($row_user['ProfilePicture']!='') { ?>
<img height="90px;" width="90px;" style="border-radius: 45px;"  src="<?php echo $RootPath; ?>upload_images/hr_images/<?php echo $row_user['ProfilePicture']; ?>" />
<?php } else { ?>
    <img src="<?php echo $RootPath; ?>images/avtar-image.png" />
<?php } ?>
<!--<div class="profile-progress">
<span class="bar"></span><strong class="count-text">80%</strong>
</div>-->
<a href="<?php echo $RootPath; ?>pages/corporate/edit_profile.php">Edit your profile</a>
<a href="<?php echo $RootPath; ?>pages/corporate/edit_profile.php" class="grey-button">View more</a>
</div>
</div>

</div>

<div class="row-fluid hidden" >
<div class="col-sm-12 col-xs-12 col-md-12 search-bar-back">
<div class="search-bars">
<form>
<div class="form-group group-1"><i class="fa fa-search"></i><input type="text" placeholder="Search by Skills or Titles" /></div>
<div class="form-group group-2"><i class="fa fa-map-marker"></i><input type="text" placeholder="Anywhere" /></div>
<input type="submit" class="green-button" value="Find Jobseekers" />
</form>
</div>

</div>
</div>
<div class="row" id="table_heading" >
<div class="col-sm-12 col-xs-12 col-md-12">
<div class="hr-box-title">
<span class="text-uppercase"><img src="<?php echo $RootPath; ?>images/corporate-icon.svg" width="45" height="45" /> graduates with qualification and estimated time to completion</span>
<div class="list-icons">
<abbr class="list-views-butt active"><i class="fa fa-list"></i></abbr>
<abbr class="grid-views-butt"><i class="fa fa-square"></i></abbr>


</div>
</div>
<h3 style="display:none; color:green;" id="invite_success_" > Invitation Sent Successfully </h3>
<h3 style="display:none; color:red;" id="invite_error_"> Invitation Not Send </h3> 
<div class="list-views-grid student-lists">
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
        
            <tr>
                <th>Name</th>
                <th>Profile</th>
                <th>City</th>
                <th>Year of passing</th>
                <th>Skills</th>
				<th>Invite</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Name</th>
                <th>Profile</th>
                <th>City</th>
                <th>Year of passing</th>
                <th>Skills</th>
				<th>Invite</th>
            </tr>
        </tfoot>
        <tbody>
        <?php while($row_profile = mysql_fetch_array($sql_profile)) {
			
			
                $sql_academic = mysql_query("select * from `academic` where `ProfileID` = '".$row_profile['ProfileID']."' ");
                $row_academic = mysql_fetch_array($sql_academic);

                $sql_biodata = mysql_query("select * from `biodata` where `ProfileID` = '".$row_profile['ProfileID']."' ");
                $row_biodata = mysql_fetch_array($sql_biodata);

                $sql_city = mysql_query("select * from `city` where `CityID` = '".$row_biodata['CityID']."' ");
                $row_city = mysql_fetch_array($sql_city);
				
				$sql_invite_1 = mysql_query("select * from `invite` where CorporateID = '".$_SESSION['ProfileID']."' AND StudentID = '".$row_profile['ProfileID']."' ") or die(mysql_error()); 
				$row_invite_1 = mysql_fetch_array($sql_invite_1);
            
	?>
            <tr>
                <td style="cursor: pointer;" data-toggle="modal" data-target="#myDetail_<?php echo $row_profile['ProfileID']; ?>" ><?php echo $row_profile['ProfileFirstName']." ".$row_profile['ProfileLastName']; ?></td>
                <td>System Architect</td>
                <?php if($row_city['CityName']) { ?>
                	<td><?php echo $row_city['CityName']; ?></td>
                <?php } else { ?>
                	<td>not declare</td>
                <?php } ?>
                <?php if($row_academic['GraduationPassing04Year']) { ?>
                	<td><?php echo $row_academic['GraduationPassing04Year']; ?></td>
				<?php } else { ?>
                	<td>not declare</td>
                <?php } ?>
                
                <td>Php Developer</td>
                <td><button <?php if($row_invite_1['Status']=='1' || $row_invite_1['Status']=='accept') { ?> disabled="disabled" <?php } ?>  id="table_invite_form_<?php echo $row_profile['ProfileID']; ?>" type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal_<?php echo $row_profile['ProfileID']; ?>">
  					Invite
					</button>
				</td>
            </tr>
        <?php } ?>    
        </tbody>
    </table>
</div>
<div class="student-lists grid-views-grid grid-views">
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable ?When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
</div>

</div>
</div>
<div class="schedule-interview">
<h2 class="titles">schedule interview</h2>


<div class="row">

<?php while($row_invite = mysql_fetch_array($sql_invite)) { 

	$sql_student = mysql_query("select * from `profile` where ProfileID = '".$row_invite['StudentID']."' ") or die(mysql_error());
	$row_student = mysql_fetch_array($sql_student);
?>
    <div class="col-sm-3 col-xs-4 col-md-2">
    	<div class="student-boxs"><a href="javascript:void(0);">
                <?php if($row_student['ProfilePicture']) { ?>
                    <img height="120px;" width="120px;" src="<?php echo $RootPath; ?>upload_images/stud_images/<?php echo $row_student['ProfilePicture']; ?>" />
                <?php } else { ?>
                    <img height="120px;" width="120px;" src="<?php echo $RootPath; ?>images/avtar-image.jpg" />
                <?php } ?>
        	<span class="name"><?php echo $row_student['ProfileName']; ?></span></a>
        </div>
    </div>
<?php  } ?>
</div>
</div>
</div>
</div>
</div>

</div>

<?php while($row_profile_1 = mysql_fetch_array($sql_profile_1)) {

    $sql_academic = mysql_query("select * from `academic` where `ProfileID` = '".$row_profile_1['ProfileID']."' ");
    $row_academic = mysql_fetch_array($sql_academic);

    $sql_biodata = mysql_query("select * from `biodata` where `ProfileID` = '".$row_profile_1['ProfileID']."' ");
    $row_biodata = mysql_fetch_array($sql_biodata);

    $sql_city = mysql_query("select * from `city` where `CityID` = '".$row_biodata['CityID']."' ");
    $row_city = mysql_fetch_array($sql_city);
    
?>
<div class="modal fade" id="myModal_<?php echo $row_profile_1['ProfileID']; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Interview Form</h4>
      </div>
      <center><h5 style="display:none; color:green;" id="invite_success_<?php echo $row_profile_1['ProfileID']; ?>"> Invitation Sent Successfully </h5> </center>
      <center><h5 style="display:none; color:red;" id="invite_error_<?php echo $row_profile_1['ProfileID']; ?>"> Invitation Not Send </h5> </center>
      
      <div class="modal-body">
      <form action="javascript:void(0);" id="invite_form" class="invite-form" method="post" >
      
      		<input type="hidden" name="action" id="action" value="invite" />
            <input type="hidden" name="stud_id" id="stud_id_<?php echo $row_profile_1['ProfileID']; ?>" value="<?php echo $row_profile_1['ProfileID']; ?>" />
            Name : <input type="text" readonly="readonly" name="Name" id="Name_<?php echo $row_profile_1['ProfileID']; ?>" value="<?php echo $row_profile_1['ProfileFirstName']." ".$row_profile_1['ProfileLastName']; ?>"  /> <br/><br/>
            Qualification : <input readonly="readonly"  type="text" name="Qualification" id="Qualification_<?php echo $row_profile_1['ProfileID']; ?>" value=""  /> <br/><br/>
            Email : <input readonly="readonly"  type="text" name="Email" id="Email_<?php echo $row_profile_1['ProfileID']; ?>" value="<?php echo $row_profile_1['ProfileEmail']; ?>"  /> <br/><br/>
            Location : <input readonly="readonly"  type="text" name="Location" id="Location_<?php echo $row_profile_1['ProfileID']; ?>" value="<?php echo $row_city['CityName']; ?>"  /> <br/><br/>
            Area of Interest : <input readonly="readonly"  type="text" name="AreaofInterest" id="AreaofInterest_<?php echo $row_profile_1['ProfileID']; ?>" value=""  /> 
      </form>      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="invite_button_<?php echo $row_profile_1['ProfileID']; ?>" onclick="SendInvite(<?php echo $row_profile_1['ProfileID']; ?>);" class="btn btn-primary">Invite</button>
      </div>
    </div>
  </div>
</div>
<?php } ?>


<?php while($row_detail = mysql_fetch_array($sql_detail)) {

    $sql_academic = mysql_query("select * from `academic` where `ProfileID` = '".$row_detail['ProfileID']."' ");
    $row_academic = mysql_fetch_array($sql_academic);

    $sql_biodata = mysql_query("select * from `biodata` where `ProfileID` = '".$row_detail['ProfileID']."' ");
    $row_biodata = mysql_fetch_array($sql_biodata);

    $sql_city = mysql_query("select * from `city` where `CityID` = '".$row_biodata['CityID']."' ");
    $row_city = mysql_fetch_array($sql_city);
    
?>
<div class="modal fade" id="myDetail_<?php echo $row_detail['ProfileID']; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Student Details</h4>
      </div>
      
        <div class="modal-body">
        <form action="javascript:void(0);" class="invite-form" method="post" >
              Name : <input type="text" readonly="readonly" name="Name" value="<?php echo $row_detail['ProfileFirstName']." ".$row_detail['ProfileLastName']; ?>"  /> <br/><br/>
              Qualification : <input readonly="readonly"  type="text" name="Qualification"  value=""  /> <br/><br/>
              Email : <input readonly="readonly"  type="text" name="Email"  value="<?php echo $row_detail['ProfileEmail']; ?>"  /> <br/><br/>
              Location : <input readonly="readonly"  type="text" name="Location"  value="<?php echo $row_city['CityName']; ?>"  /> <br/><br/>
              Area of Interest : <input readonly="readonly"  type="text" name="AreaofInterest"  value=""  /> 
        </form>      
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<?php } ?>




<?php include('../../footer.php'); ?>
<script type="text/javascript">
function SendInvite(ProfileID){
	var Name = $('#Name_'+ProfileID).val();
	var Qualification = $('#Qualification_'+ProfileID).val();
	var Email = $('#Email_'+ProfileID).val();
	var Location = $('#Location_'+ProfileID).val();
	var AreaofInterest = $('#AreaofInterest_'+ProfileID).val();
	var action = $('#action').val();
	var stud_id = $('#stud_id_'+ProfileID).val();
	$.ajax({
		method:'post',
		url:'<?php echo $RootPath; ?>action/corporate.php',
		data:{Name:Name,Qualification:Qualification,Email:Email,Location:Location,AreaofInterest:AreaofInterest,action:action,stud_id:stud_id},
		success: function(resp){
			$('#myModal_'+ProfileID).modal('hide');
			if(resp=="0") {
				$('#invite_success_').show();
				$('#invite_error_').hide();
				$('#table_invite_form_'+ProfileID).prop('disabled', true);
				$('#invite_button_'+ProfileID).prop('disabled', true);
			} else {
				$('#invite_error_').show();
				$('#invite_success_').hide();
			}
			 $('html, body').animate({
        		'scrollTop' : $("#table_heading").position().top
    		},2000);
		}
	});
}
</script>