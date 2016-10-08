<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_invite = mysql_query("SELECT * FROM `invite` ") or die(mysql_error());
        $sql_invite_1 = mysql_query("SELECT * FROM `invite` ") or die(mysql_error());
?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> Manage Invites </h1>
         
         <h1 class="page-title" style="display:none;" id="status_accept" style="color:green"> Invitation Accepted Successfully !!! </h1>
         <h1 class="page-title" style="display:none;" id="status_reject" style="color:red"> Invitation Rejected Successfully !!! </h1>
         
         <!-- END PAGE TITLE-->

         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
                
                <table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>HR Name</th>
                <th>Student Name</th>
                <th>Created Date</th>
                <th>Action</th>
                <th>Status</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>HR Name</th>
                <th>Student Name</th>
                <th>Created Date</th>
                <th>Action</th>
                <th>Status</th>
            </tr>
        </tfoot>
        <tbody>
            <?php while($row_invite = mysql_fetch_array($sql_invite)) { 
                $sql_hr = mysql_query("select * from `profile` where ProfileID = '".$row_invite['CorporateID']."' ") or die(mysql_error()); ;
                $row_hr = mysql_fetch_array($sql_hr);
                $sql_stud = mysql_query("select * from `profile` where ProfileID = '".$row_invite['StudentID']."' ") or die(mysql_error());
                $row_stud = mysql_fetch_array($sql_stud);
            ?>
            <tr>
                <td><?php echo $row_hr['ProfileName']; ?></td>
                <td style="cursor: pointer;" data-toggle="modal" data-target="#Student_Details_<?php echo $row_invite['InviteID']; ?>" ><?php echo $row_stud['ProfileName']; ?></td>
                <td><?php echo $row_invite['CreatedDate']; ?></td>
                <td>
                		<?php if($row_invite['Status']=='1' || $row_invite['Status']=='message') { ?>
                		<a href="javascript:void(0);" onclick="InviteAccept(<?php echo $row_invite['InviteID']; ?>);" >Accept</a> | 
                        <a onclick="InviteRejected(<?php echo $row_invite['InviteID']; ?>);" href="javascript:void(0);"  >Reject</a> | 
                        <?php } else { ?>
                        <?php } ?>
                        <a href="javascript:void(0);" onclick="SendMessage(<?php echo $row_invite['InviteID']; ?>);" >Message</a></td>
                <?php if($row_invite['Status']=='1') { ?>
                	<td>New Invitaion</td>
                <?php } else if($row_invite['Status']=='accept') { ?>
                	<td>Accepted</td>
				<?php } else if($row_invite['Status']=='reject') { ?>
                	<td>Rejected</td>
                <?php } else if($row_invite['Status']=='message_hr') { ?>
                	<td>Message To HR</td>
                <?php } else if($row_invite['Status']=='message_admin') { ?>
                	<td>Message To Admin</td>    
                <?php } else { ?>
                	<td>Not Define</td>
                <?php } ?>		            
            </tr>
            <?php } ?>
        </tbody>    
    </table>
                     
            </div>
         
     </div>
     <!-- END CONTENT BODY -->
 </div>
 <!-- END CONTENT -->
 <?php 
    while($row_invite_1 = mysql_fetch_array($sql_invite_1)) { 
        $sql_stud_1 = mysql_query("select * from `profile` where ProfileID = '".$row_invite_1['StudentID']."' ") or die(mysql_error());
        $row_stud_1 = mysql_fetch_array($sql_stud_1);
        $sql_academic = mysql_query("select * from `academic` where ProfileID = '".$row_invite_1['StudentID']."' ") or die(mysql_error());
        $row_academic = mysql_fetch_array($sql_academic);
        $ten_borad = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['10ThBoard']."' ") or die(mysql_error());
        $row_ten = mysql_fetch_array($ten_borad);
        $twelve_borad = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['12ThBoard']."' ") or die(mysql_error());
        $row_twelve = mysql_fetch_array($twelve_borad);
		$university = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['GraduationUniversity']."' ") or die(mysql_error());
        $row_university = mysql_fetch_array($university);
		$institute = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['InstituteID']."' ") or die(mysql_error());
        $row_institute = mysql_fetch_array($institute);
		
		
    ?>
 
 <div class="modal fade" id="Student_Details_<?php echo $row_invite_1['InviteID']; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Student Details</h4>
      </div>
      
        <div class="modal-body">
              <h4> Username : <?php echo $row_stud_1['ProfileName']; ?> </h4>
              <h4> First Name : <?php echo $row_stud_1['ProfileFirstName']; ?> </h4>
              <h4> Last Name : <?php echo $row_stud_1['ProfileLastName']; ?> </h4>
              <h4> Email : <?php echo $row_stud_1['ProfileEmail']; ?> </h4>
              <h4> Gender : <?php echo $row_stud_1['ProfileGender']; ?> </h4>
              <table border="1px solid black">
                    <tr>
                        <th></th>
                        <th>Board / University / Institue</th>
                        <th>School Name</th>
                        <th>Course Name</th>
                        <th>Year</th>
                        <th>Percentage</th>
                    </tr>
                    <tr>
                        <td>SSC Board</td>
                        <td><?php echo $row_ten['StandardPropListName']; ?></td>
                        <td><?php echo $row_academic['10ThSchoolName']; ?></td>
                        <td></td>
                        <td><?php echo $row_academic['10ThPassingYear']; ?></td>
                        <td><?php echo $row_academic['10ThPercentage']; ?></td>
                    </tr>
                    <tr>
                        <td>HSC Board</td>
                        <td><?php echo $row_twelve['StandardPropListName']; ?></td>
                        <td><?php echo $row_academic['12ThCollegeName']; ?></td>
                        <td></td>
                        <td><?php echo $row_academic['12ThPassingYear']; ?></td>
                        <td><?php echo $row_academic['12ThPercentage']; ?></td>
                    </tr>
                    <tr>
                        <td>University</td>
                        <td><?php echo $row_university['StandardPropListName']; ?></td>
                        <td><?php echo $row_academic['GraduationCollegeName']; ?></td>
                        <td></td>
                        <td><?php echo $row_academic['GraduationPassingYear']; ?></td>
                        <td><?php echo $row_academic['GraduationPercentage']; ?></td>
                    </tr>
                    <?php if($row_academic['InstituteID']) { ?>
                    <tr>
                        <td>Institute</td>
                        <td><?php echo $row_institute['StandardPropListName']; ?></td>
                        <td></td>
                        <td><?php echo $row_academic['ExternalCertificationName']; ?></td>
                        <td><?php echo $row_academic['ExternalCertificationPassingYear']; ?></td>
                        <td><?php echo $row_academic['ExternalCertificationPassingPer']; ?></td>
                    </tr>
                    <?php } ?>
              </table>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
 
 <?php } ?>
 
<?php include('../../footer.php'); ?>           
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.3.js" ></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js" ></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#example').DataTable( {
            "pagingType": "full_numbers"
        });
    });
</script>  
<script type="text/javascript">
function SendMessage(InviteID){
    window.location.href = "<?php echo $AdminPath; ?>pages/invites/message.php?InviteID="+InviteID;
}    
</script>
<script type="text/javascript">
function InviteAccept(InviteID){
	var InviteID = InviteID;
	var action = 'accept';
	if (confirm('Are You Sure You Want To Accept Invitation?')) {
    	// Save it!
		$.ajax({
			method:'post',
			url:"<?php echo $AdminPath; ?>action/invites.php",
			data:{InviteID:InviteID,action:action},
			success: function(resp){
				$('#status_accept').show();
			}
		});
	} else {
    	// Do nothing!
	}
}
</script>
<script type="text/javascript">
function InviteRejected(InviteID){
	var InviteID = InviteID;
	var action = 'reject';
	if (confirm('Are You Sure You Want To Reject Invitation?')) {
    	// Save it!
		$.ajax({
			method:'post',
			url:"<?php echo $AdminPath; ?>action/invites.php",
			data:{InviteID:InviteID,action:action},
			success: function(resp){
				$('#status_reject').show();
				$('#status_accept').hide();
			}
		});
	} else {
    	// Do nothing!
	}
}
</script>    