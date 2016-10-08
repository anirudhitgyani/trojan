<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	$QuestionSetID = $_REQUEST['QuestionSetID'];
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_qa = mysql_query("SELECT * FROM `QuestionSet` where QuestionSetID = '".$QuestionSetID."' ") or die(mysql_error()); $row_qa = mysql_fetch_array($sql_qa); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title" id="table_heading" > Edit Question And Answers </h1>
         
         
         <!-- END PAGE TITLE-->
       
         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
			<form action="<?php echo $AdminPath; ?>action/qa.php" method="post" id="qa_form" >
        	
            <input type="hidden" name="action" id="action" value="update" />
            <input type="hidden" name="QuestionSetID" id="QuestionSetID" value="<?php echo $QuestionSetID; ?>" />
            <label class="control-label visible-ie8 visible-ie9">Question</label>
          	<input class="form-control" type="text" name="Question" id="Question" value="<?php echo $row_qa['Question']; ?>" /> <br/>
            <label class="control-label visible-ie8 visible-ie9">Answer01</label> 
            <input type="text" class="form-control" name="Answer01" id="Answer01" value="<?php echo $row_qa['Answer01']; ?>" /> <br/>
            <label class="control-label visible-ie8 visible-ie9">Answer02</label> 
            <input type="text" class="form-control" name="Answer02" id="Answer02" value="<?php echo $row_qa['Answer02']; ?>" /> <br/>
            <label class="control-label visible-ie8 visible-ie9">Answer03</label> 
            <input type="text" class="form-control" name="Answer03" id="Answer03" value="<?php echo $row_qa['Answer03']; ?>" /> <br/>
            <label class="control-label visible-ie8 visible-ie9">Answer04</label> 
            <input type="text" class="form-control" name="Answer04" id="Answer04" value="<?php echo $row_qa['Answer04']; ?>" /> <br/>
            <label class="control-label visible-ie8 visible-ie9">Select Course Category</label>
            <select name="CorrectAnswer" id="CorrectAnswer">
                <option value="0"> Select Correct Answer </option>
                        <option <?php if($row_qa['IsAnswer01Ok']=='1') { ?> selected="selected" <?php } ?> value="1" >Answer01</option>
                        <option <?php if($row_qa['IsAnswer02Ok']=='1') { ?> selected="selected" <?php } ?> value="2" >Answer02</option>
                        <option <?php if($row_qa['IsAnswer03Ok']=='1') { ?> selected="selected" <?php } ?> value="3" >Answer03</option>
                        <option <?php if($row_qa['IsAnswer04Ok']=='1') { ?> selected="selected" <?php } ?> value="4" >Answer04</option>
                    </select>
            <br/><br/>
            <input class="control-label" value="Submit"  type="button" onclick="saveqa();"  />
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
function saveqa(){
	var flag = true;
	if($('#Question').val()==''){
		$('#Question').css('border','1px solid red');
		flag = false;
	} else {
		$('#Question').css('border','1px solid #ccc');
	}
	if($('#Answer01').val()==''){
		$('#Answer01').css('border','1px solid red');
		flag = false;
	} else {
		$('#Answer01').css('border','1px solid #ccc');
	}
	if($('#Answer02').val()==''){
		$('#Answer02').css('border','1px solid red');
		flag = false;
	} else {
		$('#Answer02').css('border','1px solid #ccc');
	}
	if($('#Answer03').val()==''){
		$('#Answer03').css('border','1px solid red');
		flag = false;
	} else {
		$('#Answer03').css('border','1px solid #ccc');
	}
	if($('#Answer04').val()==''){
		$('#Answer04').css('border','1px solid red');
		flag = false;
	} else {
		$('#Answer04').css('border','1px solid #ccc');
	}
	
	if($('#CorrectAnswer').val()=='0'){
		$('#CorrectAnswer').css('border','1px solid red');
		flag = false;
	} else {
		$('#CorrectAnswer').css('border','1px solid #ccc');
	}
	
	if(flag==false) {
		return false;
	} else {
		$('#qa_form').submit();
	}
		
}
</script>
    