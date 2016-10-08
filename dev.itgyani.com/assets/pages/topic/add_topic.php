<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	$TopicID = $_REQUEST['TopicID'];
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_topic = mysql_query("SELECT * FROM `topic` where TopicID = '".$TopicID."' ") or die(mysql_error()); 
$row_topic = mysql_fetch_array($sql_topic); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title" id="table_heading" > Edit Topics </h1>
         
         
         <?php if(isset($_SESSION['success'])) { ?>
         	<h1 class="page-title"><?php echo $_SESSION['success']; ?> </h1>	
         <?php } unset($_SESSION['success']); ?>   
         <!-- END PAGE TITLE-->
       
         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
			<form action="<?php echo $AdminPath; ?>action/topic.php" method="post" id="topic_form" >
        	
            <input type="hidden" name="action" id="action" value="update" />
            <input type="hidden" name="TopicID" id="TopicID" value="<?php echo $TopicID; ?>" />
            <label class="control-label visible-ie8 visible-ie9">Topic Name (Only Readable)</label>
          	<input class="form-control" readonly="readonly" type="text" value="<?php echo $row_topic['TopicName']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">Topic Description</label> 
            <input type="text" class="form-control" name="TopicDesc" id="TopicDesc" value="<?php echo $row_topic['TopicDesc']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">URL 01</label> 
            <input type="text" class="form-control" name="URL01" id="URL01" value="<?php echo $row_topic['URL01']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">URL 02</label> 
            <input type="text" class="form-control" name="URL02" id="URL02" value="<?php echo $row_topic['URL02']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">URL 03</label> 
            <input type="text" class="form-control" name="URL03" id="URL03" value="<?php echo $row_topic['URL03']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">URL 04</label> 
            <input type="text" class="form-control" name="URL04" id="URL04" value="<?php echo $row_topic['URL04']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">Doc 01</label> 
            <input type="text" class="form-control" name="Doc01" id="Doc01" value="<?php echo $row_topic['Doc01']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">Doc 02</label> 
            <input type="text" class="form-control" name="Doc02" id="Doc02" value="<?php echo $row_topic['Doc02']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">Doc 03</label> 
            <input type="text" class="form-control" name="Doc03" id="Doc03" value="<?php echo $row_topic['Doc03']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">Doc 04</label> 
            <input type="text" class="form-control" name="Doc04" id="Doc04" value="<?php echo $row_topic['Doc04']; ?>" /> <br/>
            
            
            <input class="control-label" value="Submit"  type="button" onclick="savetopic();"  />
            </form>              
                     
            </div>
         
     </div>
     <!-- END CONTENT BODY -->
 </div>
 <!-- END CONTENT -->
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
function savetopic(){
	var flag = true;
	if($('#TopicDesc').val()==''){
		$('#TopicDesc').css('border','1px solid red');
		flag = false;
	} else {
		$('#TopicDesc').css('border','1px solid #ccc');
	}
	
	if($('#URL01').val()==''){
		$('#URL01').css('border','1px solid red');
		flag = false;
	} else {
		$('#URL01').css('border','1px solid #ccc');
	}
	
	if($('#Doc01').val()==''){
		$('#Doc01').css('border','1px solid red');
		flag = false;
	} else {
		$('#Doc01').css('border','1px solid #ccc');
	}
	
	if(flag==false) {
		return false;
	} else {
		$('#topic_form').submit();
	}
		
}
</script>
    