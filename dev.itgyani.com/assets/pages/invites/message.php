<?php include('../../connection.php');
include('../../header.php');
if(!isset($_SESSION['AdminID'])) {
    echo "<script>window.location='$AdminPath'</script>";
    exit;
}
    $InviteID = $_REQUEST['InviteID'];
    $sql_invite = mysql_query("select * from `invite` where InviteID = '".$InviteID."' ") or die(mysql_error());
    $row_invite = mysql_fetch_array($sql_invite);

    $sql_conv = mysql_query("select * from `conversation` where InviteID = '".$InviteID."' ") or die(mysql_error());
    $sql_conv_update = mysql_query("update `conversation` set ReadMessage = '0' where InviteID = '".$InviteID."' AND StudentID = '".$row_invite['StudentID']."' AND ReadMessage = '1' AND ReceivedID = '".$_SESSION['AdminID']."' ") or die(mysql_error());

?>
                <!-- BEGIN CONTENT -->
                <div class="page-content-wrapper">
                    <!-- BEGIN CONTENT BODY -->
                    <div class="page-content">
                        <!-- BEGIN PAGE HEADER-->
                
                        <!-- BEGIN PAGE TITLE-->
                        <h1 class="page-title"> Sent Message To HR </h1>
                        <!-- END PAGE TITLE-->
                        
                        <!-- END PAGE HEADER-->
                        
                        <div class="portlet box grey border-grey">
                            
                        <?php while($row_conv = mysql_fetch_array($sql_conv)) { ?>        
                            <div class="form-group">
                                <?php if($row_conv['ReceivedID']==$_SESSION['ProfileID']) { ?>
                                    <label class="control-label visible-ie8 visible-ie9">Admin To Hr</label>
                                <?php } else { ?>
                                    <label class="control-label visible-ie8 visible-ie9">Hr To Admin</label>
                                <?php } ?>
                                    <textarea class="form-control" readonly="" ><?php echo $row_conv['Message']; ?></textarea> 
                            </div>
                        <?php } ?>        
                            
                        </div>       
                       
                        
                        <div class="portlet box grey border-grey">
                            <form class="login-form" id="message-form" action="javascript:void(0);" method="post">
                                <input type="hidden" name="InviteID" id="InviteID" value="<?php echo $InviteID; ?>" />
                                <input type="hidden" name="action" id="action" value="message" />
                                <div class="form-group">
                                    <label class="control-label visible-ie8 visible-ie9">Message To HR</label>
                                    <textarea class="form-control" name="Message" rows="10" cols="50" placeholder="Enter Message To HR" id="Message" ></textarea> 
                                </div>
                                <div class="form-actions">
                                    <button type="button" onclick="SendMessage();" class="btn green uppercase">Send</button>
                                    <h4 id="success" style="display:none; color:green;" > Mail Succesfully Sent To HR </h4>
                                    <h4 id="error" style="display:none; color:red;" > Mail Not Sent </h4>
                                    <img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100" align="center" />
                                </div>
                            </form>
                        </div>
                        
                    </div>
                    <!-- END CONTENT BODY -->
                </div>
                <!-- END CONTENT -->
                
<?php include('../../footer.php'); ?>
<script type="text/javascript">
function SendMessage(){
	var flag = true;
	
	if($('#Message').val()=='') {
		$('#Message').css('border','1px solid red');
		return false;
	} else {
		$('#Message').css('border','1px solid #c2cad8');
	}
	
	if(flag==false){
		return false;
	} else {
		var datastring = $('#message-form').serialize();
		$('#loader-img').show();
		$.ajax({
			method:'post',
			url:'<?php echo $AdminPath; ?>action/invites.php',
			data:datastring,
			success: function(resp){
				//alert(resp);
				$('#loader-img').hide();
				if(resp=="0"){
					$('#success').show();
					$('#error').hide();
					$('#Message').val('');
				} else if(resp=="1"){
					$('#error').show();
					$('#success').hide();
				}
			}
		});
	}
}
</script>           