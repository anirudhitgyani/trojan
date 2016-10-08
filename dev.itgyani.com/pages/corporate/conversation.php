<?php include('../../connection.php');
	if(!isset($_SESSION['ProfileID'])) {
		header("location:".$RootPath);
		exit();
	}
include('../../header_1.php');

$InviteID = $_REQUEST['InviteID'];
$StudentID = $_REQUEST['StudentID'];

$sql_invite = mysql_query("select * from `invite` where InviteID = '".$InviteID."' ") or die(mysql_error());
$row_invite = mysql_fetch_array($sql_invite);

$sql_conv = mysql_query("select * from `conversation` where InviteID = '".$InviteID."' ") or die(mysql_error());

$sql_conv_update = mysql_query("update `conversation` set ReadMessage = '0' where InviteID = '".$InviteID."' AND StudentID = '".$row_invite['StudentID']."' AND ReadMessage = '1' AND ReceivedID = '".$_SESSION['ProfileID']."' ") or die(mysql_error());


?>

<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<?php // include('sidebar.php'); ?>
<div class="col-sm-12 col-xs-12 col-md-12 no-padding-right no-padding-left right-col">
<div class="row">

<div class="col-sm-12 col-xs-12 col-md-12">
<div class="dashbord-page-heading">
<h1>HR TO ADMIN Messages Conversation</h1>
</div>
</div></div>



<div class="row">
<div class="col-sm-12 col-xs-12 col-md-12">
<div class="hr-box-title">
<span class="text-uppercase"><img src="<?php echo $RootPath; ?>images/corporate-icon.svg" width="45" height="45" /> HR Inbox Message Send By Admin </span>
</div>
<div class="list-views-grid student-lists">

<?php while($row_conv = mysql_fetch_array($sql_conv)) { ?>

	<div class="form-group row">
    	<?php if($row_conv['ReceivedID']==$_SESSION['ProfileID']) { ?>
    		<label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Admin To Hr</label>
        <?php } else { ?>
        	<label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Hr To Admin</label>
        <?php } ?>
        <div class="col-xs-12 col-md-9 col-sm-9 address-field">
           <textarea readonly="readonly" class="form-control" ><?php echo $row_conv['Message']; ?></textarea>
        </div>
    </div>

<?php } ?>
    
    <div class="form-group row">
    
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Hr To Admin</label>
        
        <div class="col-xs-12 col-md-9 col-sm-9 address-field">
        	<input type="hidden" name="InviteID" id="InviteID" value="<?php echo $InviteID; ?>" />   
                <textarea placeholder="Reply To Admin" id="Message" name="Message" class="form-control" ></textarea>
        </div>
    </div>
    <div class="form-group row">
    <div id="error_msg" style="color:red; margin-left: 200px; display: none;" class="col-xs-12 col-md-9 col-sm-9 address-field">
            <h4> Please Enter Maximum 20 Character </h4>
        </div>
    </div>    
    
    <div class="buttons-box text-center">
        <input type="button" onclick="MessageToAdmin();" class="green-butt green-back" value="Send" />
        <img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100" align="center" />
    </div>
    
      <h4 id="success" style="display:none; color:green;" > Mail Succesfully Sent To Admin </h4>
      <h4 id="error" style="display:none; color:red;" > Mail Not Sent </h4>
	
</div>

</div>
</div>

</div>
</div>
</div>

</div>


<?php include('../../footer.php'); ?>
<script type="text/javascript">
function MessageToAdmin(){
	
	
	if($('#Message').val().length < 20) {
		$('#Message').css('border','1px solid red');
                $('#error_msg').show();
	} else {
                $('#error_msg').hide();
		$('#loader-img').show();
		var Message = $('#Message').val();
		var InviteID = $('#InviteID').val();
		var action = 'messagetoadmin';
		$('#Message').css('border','1px solid #ccc');
		$.ajax({
			method:'post',
			url:'<?php echo $RootPath; ?>action/corporate.php',
			data:{Message:Message,InviteID:InviteID,action:action},
			success: function(resp){
				$('#loader-img').hide();
				if(resp=="0"){
					$('#success').show();
					$('#error').hide();
					$('#Message').val('');
					setTimeout(function(){
   								window.location.reload(1);
								},1000);
				} else if(resp=="1"){
					$('#error').show();
					$('#success').hide();
				}
			}
		});
	}
	
}
</script>