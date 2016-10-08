<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
    
    $TopicID = $_REQUEST['TopicID'];
    $sql = mysql_query("select * from `topic` where TopicID = '".$TopicID."' ") or die(mysql_error());
    $row = mysql_fetch_array($sql);
?> 
 
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> Add New Topic </h1>
         
         <!-- END PAGE TITLE-->

         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
                
                <form action="javascript:void(0);" method="post" id="topic_form" >
                    
                    <input type="hidden" name="action" id="action" value="update_topic" />
                    <input type="hidden" name="TopicID" id="TopicID" value="<?php echo $TopicID; ?>" />
                    	
                <div class="form-group">
                    <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                    <label class="control-label visible-ie8 visible-ie9">Topic Name (Only Readable)</label>
                    <input class="form-control" type="text" readonly="readonly" value="<?php echo $row['TopicName']; ?>" /> 
                </div>
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Topic Description</label>
                    <textarea class="form-control form-control-solid placeholder-no-fix" placeholder="Course Description" name="TopicDesc" id="TopicDesc"><?php echo $row['TopicDesc']; ?></textarea> 
                </div>
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">URL 01</label>
                    <input class="form-control" type="text" name="URL01" id="URL01" value="<?php echo $row['URL01']; ?>" /> 
                </div>
                
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">URL 02</label>
                    <input class="form-control" type="text" name="URL02" id="URL02" value="<?php echo $row['URL02']; ?>" /> 
                </div>
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">URL 03</label>
                    <input class="form-control" type="text" name="URL03" id="URL03" value="<?php echo $row['URL03']; ?>" /> 
                </div>
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">URL 04</label>
                    <input class="form-control" type="text" name="URL04" id="URL04" value="<?php echo $row['URL04']; ?>" /> 
                </div>
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">DOC 01</label>
                    <input class="form-control" type="text" name="Doc01" id="Doc01" value="<?php echo $row['Doc01']; ?>" /> 
                </div>
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">DOC 02</label>
                    <input class="form-control" type="text" name="Doc02" id="Doc02" value="<?php echo $row['Doc02']; ?>" /> 
                </div>
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">DOC 03</label>
                    <input class="form-control" type="text" name="Doc03" id="Doc03" value="<?php echo $row['Doc03']; ?>" /> 
                </div>
                
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">DOC 04</label>
                    <input class="form-control" type="text" name="Doc04" id="Doc04" value="<?php echo $row['Doc04']; ?>" /> 
                </div>
                
                
                <div class="form-group">
                    <input type="button" onclick="SaveTopic();" value="Submit" /> 
                </div>    
                    
                
            </form>
                
                     
            </div>
         
     </div>
     <!-- END CONTENT BODY -->
 </div>
 <!-- END CONTENT -->
<?php include('../../footer.php'); ?>
<script type="text/javascript">
function SaveTopic(){
	var flag = true;
	
	if($('#URL01').val()=='0') { 
		$('#URL01').css('border','1px solid red');
		flag = false;
	} else {
		$('#URL01').css('border','1px solid #c2cad8');
	}
	
	if($('#Doc01').val()=='') { 
		$('#Doc01').css('border','1px solid red');
		flag = false;
	} else {
		$('#Doc01').css('border','1px solid #c2cad8');
	}
	
	if(flag==false){
		return false;
	} else {
		//$('#topic_form').submit();
		var datastring = $('#topic_form').serialize();
		$.ajax({
			method:'post',
			url:"<?php echo $AdminPath; ?>action/course.php",
			data:datastring,
			success: function(resp){
				alert(resp);
			}
			
		});
	}
	
}
</script>