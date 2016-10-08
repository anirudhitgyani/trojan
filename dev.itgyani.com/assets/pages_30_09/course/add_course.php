<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	$CourseID = $_REQUEST['CourseID'];
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_course = mysql_query("SELECT * FROM `course` where CourseID = '".$CourseID."' ") or die(mysql_error()); $row_course = mysql_fetch_array($sql_course); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title" id="table_heading" > Add New Course </h1>
         
         
         <!-- END PAGE TITLE-->
       
         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
			<form action="<?php echo $AdminPath; ?>action/course.php" method="post" id="course_form" enctype="multipart/form-data" >
        	<?php if($CourseID!='') { ?>
            <input type="hidden" name="action" id="action" value="update" />
            <input type="hidden" name="CourseID" id="CourseID" value="<?php echo $CourseID; ?>" />
            <?php } else { ?>
            <input type="hidden" name="action" id="action" value="insert" />
            <?php } ?>
            
            <!--<label class="control-label visible-ie8 visible-ie9">Select Course Category</label>
            <select name="CourseCategoryID" id="CourseCategoryID">
                    	<option value="0"> Select Category </option>
                        <option <?php if($row_course['CourseCategoryID']=='1') { ?> selected="selected" <?php } ?> value="1" >Foundation</option>
                        <option <?php if($row_course['CourseCategoryID']=='2') { ?> selected="selected" <?php } ?> value="2" >Pre-Foundation</option>
                    </select>-->
                    
                    
                    
            <br/><br/>
            <label class="control-label visible-ie8 visible-ie9">Course Name</label>
          	<input class="form-control" type="text" name="CourseName" id="CourseName" value="<?php echo $row_course['CourseName']; ?>" /> <br/>
            <label class="control-label visible-ie8 visible-ie9">Course Description</label> 
            <input type="text" class="form-control" name="CourseDesc" id="CourseDesc" value="<?php echo $row_course['CourseDesc']; ?>" /> <br/>
            
            <label class="control-label visible-ie8 visible-ie9">Course Image</label> 
            <input type="file" class="form-control" name="ImageName" id="ImageName" value="" /> <br/>
            
            <input class="control-label" value="Submit"  type="button" onclick="savecourse();"  />
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
function savecourse(){
	var flag = true;
	
	/*if($('#CourseCategoryID').val()=='0'){
		$('#CourseCategoryID').css('border','1px solid red');
		flag = false;
	} else {
		$('#CourseCategoryID').css('border','1px solid #ccc');
	}*/
	
	if($('#CourseName').val()==''){
		$('#CourseName').css('border','1px solid red');
		flag = false;
	} else {
		$('#CourseName').css('border','1px solid #ccc');
	}
	if($('#CourseDesc').val()==''){
		$('#CourseDesc').css('border','1px solid red');
		flag = false;
	} else {
		$('#CourseDesc').css('border','1px solid #ccc');
	}
	
	if(flag==false) {
		return false;
	} else {
		$('#course_form').submit();
	}
		
}
</script>
    