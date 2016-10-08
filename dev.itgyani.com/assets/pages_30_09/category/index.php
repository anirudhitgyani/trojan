<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	$CourseID = $_REQUEST['CourseID'];
?>
<?php $sql_course = mysql_query("SELECT * FROM `course` ") or die(mysql_error()); 
	
$sql_category = mysql_query("select * from `coursecategory` ") or die(mysql_error());


 ?>
<style>
.box-content li:hover {
        background: white;
}    
</style>
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title" id="table_heading" > Add New Grouping </h1>
         
         
         <!-- END PAGE TITLE-->
       
         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
			
            
            
            
            
            
          
           
            
            
            
         
         
         <div class="middle-content student-dashbord-content">
<div class="container">
<div class="row">
<div class="col-sm-4 col-xs-12 col-md-4">
<div class="dashbord-box my-course">
<h2>Select Category</h2>
<span> <a href="javascript:void(0);" data-toggle="modal" data-target="#AddCategory"  >Add Category</a> </span><br/><br/>
<div class="box-content">
    
    <label class="control-label visible-ie8 visible-ie9">Select Course Category</label>
            <select name="CourseCategoryID" id="CourseCategoryID" onchange="SelectCategory(this.value);" >
                    	<option value="0"> Select Category </option>
                        <?php while($row_category = mysql_fetch_array($sql_category)) { ?>
                        <option value="<?php echo $row_category['CourseCategoryID']; ?>" ><?php echo $row_category['CategoryName']; ?></option>
                        <?php } ?>
                    </select>
	
</div>
</div>
</div>
    
<div class="col-sm-4 col-xs-12 col-md-4">
<div class="dashbord-box my-course">
<h2>Select Course</h2>
<div class="box-content">
    <ul>
        <?php while($row_course = mysql_fetch_array($sql_course)) { ?>
        <li style="cursor: pointer;" ondblclick="SetGrouping(<?php echo $row_course['CourseID']; ?>);"><?php echo $row_course['CourseName']; ?></li>
        <?php } ?>
    </ul>        
</div>
</div>
</div>
    
    <div class="col-sm-4 col-xs-12 col-md-4">
<div class="dashbord-box my-course">
<h2>Category Course</h2>
<div class="box-content">
	<div id="course_list">
            	
        </div>
</div>
</div>
</div>

</div>
</div>

</div>
            
            </div>
         
     </div>
     <!-- END CONTENT BODY -->
 </div>
 
 <div class="modal fade" id="AddCategory" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Alert Message</h4>
      </div>
      
        <div class="modal-body">
              Category Name : <input type="text" name="CategoryName" id="CategoryName" value="" />
              <span id="error_already" style="display:none; color:red;">Category Name Already Existing..</span>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" onclick="SaveCategory();" >Save</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
 
 <!-- END CONTENT -->
<?php include('../../footer.php'); ?>           
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.3.js" ></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js" ></script> 
<script type="text/javascript">
function SaveCategory(){

	if($('#CategoryName').val()==''){
		$('#CategoryName').css('border','1px solid red');
		flag = false;
	} else {
		$('#CategoryName').css('border','1px solid black');
		var CategoryName = $('#CategoryName').val();
		var action = "insert_category";
		$.ajax({
			method:'post',
			url:'<?php echo $AdminPath; ?>action/grouping.php',
			data:{CategoryName:CategoryName,action:action},
			success: function(resp){
				if(resp=='0'){
					$('#error_already').show();
				} else {
					$('#error_already').hide();
					window.location.reload();
				}
			}
		});
	}
	
		
}

function SetGrouping(CourseID){
	var CourseCategoryID = $('#CourseCategoryID').val();
	if(CourseID!='0' && CourseCategoryID!='0') {
		var action = "set_grouping";
		$.ajax({
			method:'post',
			url:'<?php echo $AdminPath; ?>action/grouping.php',
			data:{CourseCategoryID:CourseCategoryID,CourseID:CourseID,action:action},
			success: function(resp){
                                if(resp=='0'){
                                    alert('Course Already Selected');
                                } else {
                                    $('#course_list').html(resp);
                                }
			}
		});
	} else {
		alert('Please Select Category AND Course');
	}
}
function SelectCategory(CourseCategoryID){
	if(CourseCategoryID!='0') {
	var action = "select_category";
		$.ajax({
			method:'post',
			url:'<?php echo $AdminPath; ?>action/grouping.php',
			data:{CourseCategoryID:CourseCategoryID,action:action},
			success: function(resp){
				$('#course_list').html(resp);
			}
		});
	} else {
		alert('Select Category First');
	}
}
function RemoveCategory(CourseID,CourseCategoryID){ 
	var action = "remove_category";
	$.ajax({
		method:'post',
		url:'<?php echo $AdminPath; ?>action/grouping.php',
		data:{CourseID:CourseID,CourseCategoryID:CourseCategoryID,action:action},
		success: function(resp){
			$('#course_list').html(resp);
		}
	});
}
</script>
    