<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
    
    $CourseID = $_REQUEST['CourseID'];
    $sql = mysql_query("select * from `course` where CourseID = '".$CourseID."' ") or die(mysql_error());
    $row = mysql_fetch_array($sql);
?>
 
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> Add New Course </h1>
         
        
         
         <!-- END PAGE TITLE-->

         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
                
                <form class="login-form" action="<?php echo $AdminPath; ?>action/course.php" method="post" enctype="multipart/form-data" id="course_form" >
                    <?php if($CourseID!='') { ?>
                    <input type="hidden" name="action" id="action" value="update" />
                    <input type="hidden" name="CourseID" id="CourseID" value="<?php echo $CourseID; ?>" />
                    <?php } else { ?>
                    <input type="hidden" name="action" id="action" value="insert" />
                    <?php } ?>
                    	
                 <div class="form-group">
                    <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                    <label class="control-label visible-ie8 visible-ie9">Select Cource Category</label>
                    <select name="CourseCategoryID" id="CourseCategoryID">
                    	<!--<option value="0"> Select Category </option>-->
                        <option <?php if($row['CourseCategoryID']=='1') { ?> selected="selected" <?php } ?> value="1" >Foudation</option>
                        <option <?php if($row['CourseCategoryID']=='2') { ?> selected="selected" <?php } ?> value="2" >Pre-Foudation</option>
                    </select>
                </div>
                    
                    
                <div class="form-group">
                    <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                    <label class="control-label visible-ie8 visible-ie9">Course Name</label>
                    <input class="form-control form-control-solid placeholder-no-fix" type="text" placeholder="Course Name" name="CourseName" id="CourseName" value="<?php echo $row['CourseName']; ?>" /> 
                </div>
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Course Description</label>
                    <textarea class="form-control form-control-solid placeholder-no-fix" placeholder="Course Description" name="CourseDesc" id="CourseDesc"><?php echo $row['CourseDesc']; ?></textarea> 
                </div>
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Course Image</label>
                    <input class="form-control form-control-solid placeholder-no-fix" type="file" name="ImageName" id="ImageName" /> 
                </div>
                <div class="form-group">
                    <input class="form-control" type="submit" name="submit" id="submit" value="Submit" /> 
                </div>    
                    
                
            </form>
                
                     
            </div>
         
     </div>
     <!-- END CONTENT BODY -->
 </div>
 <!-- END CONTENT -->
<?php include('../../footer.php'); ?> 
<script type="text/javascript">
function SaveCourse(){
	var flag = true;
	
	if($('#CourseCategoryID').val()=='0') { 
		$('#CourseCategoryID').css('border','1px solid red');
		flag = false;
	} else {
		$('#CourseCategoryID').css('border','1px solid #c2cad8');
	}
	
	if($('#CourseName').val()=='') { 
		$('#CourseName').css('border','1px solid red');
		flag = false;
	} else {
		$('#CourseName').css('border','1px solid #c2cad8');
	}
	
	if($('#CourseDesc').val()=='') { 
		$('#CourseDesc').css('border','1px solid red');
		flag = false;
	} else {
		$('#CourseDesc').css('border','1px solid #c2cad8');
	}
	
	if(flag==false){
		return false;
	} else {
		$('#course_form').submit();
	}
	
}
</script>