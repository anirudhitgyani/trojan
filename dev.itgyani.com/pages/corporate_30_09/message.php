<?php include('../../connection.php');
	if(!isset($_SESSION['ProfileID'])) {
		header("location:".$RootPath);
		exit();
	}

include('../../header_1.php');

$sql_invite = mysql_query("select * from `invite` where CorporateID = '".$_SESSION['ProfileID']."'  ") or die(mysql_error());

$sql_invite1 = mysql_query("select * from `invite` where CorporateID = '".$_SESSION['ProfileID']."' ") or die(mysql_error());

?>
<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<?php // include('sidebar.php'); ?>
<div class="col-sm-12 col-xs-12 col-md-12 no-padding-right no-padding-left right-col">
<div class="row">

<div class="col-sm-12 col-xs-12 col-md-12">
<div class="dashbord-page-heading">
<h1>Messages</h1>
</div>
</div></div>


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
<div class="row">
<div class="col-sm-12 col-xs-12 col-md-12">
<div class="hr-box-title">
<span class="text-uppercase"><img src="<?php echo $RootPath; ?>images/corporate-icon.svg" width="45" height="45" /> HR Inbox Message Send By Admin </span>
</div>
<div class="list-views-grid student-lists">
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
        	<tr>
                <th>HR Name</th>
                <th>Student Name</th>
                <th>Created Date</th>
                <th>Message Date</th>
                <th>Action</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>HR Name</th>
                <th>Student Name</th>
                <th>Created Date</th>
                <th>Message Date</th>
                <th>Action</th>
            </tr>
        </tfoot>
        <tbody>
        <?php while($row_invite = mysql_fetch_array($sql_invite)) { 
        	
			$sql_hr = mysql_query("select * from `profile` where ProfileID = '".$row_invite['CorporateID']."' ") or die(mysql_error()); ;
                $row_hr = mysql_fetch_array($sql_hr);
                $sql_stud = mysql_query("select * from `profile` where ProfileID = '".$row_invite['StudentID']."' ") or die(mysql_error());
                $row_stud = mysql_fetch_array($sql_stud);
				
			$sql_conv = mysql_query("select * from `conversation` where InviteID = '".$row_invite['InviteID']."' AND ReceivedID = '".$_SESSION['ProfileID']."' order by SendDate Desc ") or die(mysql_error());	
		  	$row_conv = mysql_fetch_array($sql_conv);  
        ?>
        
        <?php if($row_conv['Message']!='') { ?>
        
           <?php if($row_conv['ReadMessage']=='1') { ?>
            <tr>
                <td><strong><?php echo $row_hr['ProfileName']; ?></strong></td>
                <td><strong><?php echo $row_stud['ProfileName']; ?></strong></td>
                <td><strong><?php echo $row_invite['CreatedDate']; ?></strong></td>
                <td><strong><?php echo $row_conv['SendDate']; ?></strong></td>
                <td><a href="<?php echo $RootPath; ?>pages/corporate/conversation.php?InviteID=<?php echo $row_invite['InviteID']; ?>"><button type="button" class="btn btn-primary btn-lg">
  					Read Message
					</button></a>
				</td>
                <!--<td><button type="button" onclick="ChangeStatus();" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal_<?php echo $row_invite['InviteID']; ?>">
  					Read Message
					</button>
				</td>-->
			</tr>
            <?php } else { ?>
            	<tr>
                <td><?php echo $row_hr['ProfileName']; ?></td>
                <td><?php echo $row_stud['ProfileName']; ?></td>
                <td><?php echo $row_invite['CreatedDate']; ?></td>
                <td><?php echo $row_conv['SendDate']; ?></td>
                <td><a href="<?php echo $RootPath; ?>pages/corporate/conversation.php?InviteID=<?php echo $row_invite['InviteID']; ?>"><button type="button" class="btn btn-primary btn-lg">
  					Read Message
					</button></a>
				</td>
                <!--<td><button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal_<?php echo $row_invite['InviteID']; ?>">
  					Read Message
					</button>
				</td>-->
			</tr>
            <?php } ?>
            
            <?php } ?>
        
        <?php } ?>    
        </tbody>
    </table>
</div>

</div>
</div>

</div>
</div>
</div>

</div>

<?php while($row_invite_1 = mysql_fetch_array($sql_invite1)) { ?>
<div class="modal fade" id="myModal_<?php echo $row_invite_1['InviteID']; ?>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Interview Form</h4>
      </div>
      
      <div class="modal-body">
            <p><?php echo nl2br($row_invite_1['Message']); ?></p>
      </div>
      
      <div class="modal-footer">
      <?php if($row_invite_1['ReadByHR']=='1') { ?>
        <button type="button" onclick="ClosePopup();" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <?php } else { ?>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <?php } ?>
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
function ChangeStatus(InviteID){
	var InviteID = InviteID;
	var action = "change_status";
	$.ajax({
		method:'post',
		url:'<?php echo $RootPath; ?>action/corporate.php',
		data:{InviteID:InviteID,action:action},
		success: function(resp){
		
		}
	});
}
function ClosePopup(){
	window.location.reload();
}
</script> 