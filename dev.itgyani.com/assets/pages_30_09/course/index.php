<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
?>

<!--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />-->

<?php $sql_course = mysql_query("SELECT * FROM `course` ") or die(mysql_error()); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> Manage Course </h1>
         
         <?php if(isset($_SESSION['success'])) { ?>
         <h1 class="page-title"><?php echo $_SESSION['success']; ?></h1>
         <?php } unset($_SESSION['success']); ?>
         
         <h1 class="page-title" style="display:none;" id="delete_success" style="color:green"> Your Course Successfully Deleted... </h1>
         
         <!-- END PAGE TITLE-->
         <input type="button" onclick="AddCourse();" name="add_button" id="add_button" value="Add New Course" /> <br/><br/>
         <!-- END PAGE HEADER-->
         
            <div class="portlet box border-grey">
                <div class="portlet-body"><div class="dataTables_wrapper">
                <table id="sample_3" class="display table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Course Name</th>
                <th>Description</th>
                <th>Image</th>
                <th>Created Date</th>
                <th width="200">Action</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Course Name</th>
                <th>Description</th>
                <th>Image</th>
                <th>Created Date</th>
                <th width="200">Action</th>
            </tr>
        </tfoot>
        <tbody>
            <?php while($row_course = mysql_fetch_array($sql_course)) {  ?>
            <tr id="course_row_<?php echo $row_course['CourseID']; ?>" >
                <td style="cursor: pointer;" onclick="AddNewTopics(<?php echo $row_course['CourseID']; ?>);" ><?php echo $row_course['CourseName']; ?></td>
                <td><?php echo $row_course['CourseDesc']; ?></td>
                <td><img src="<?php echo $AdminPath; ?>/upload_images/course_images/<?php echo $row_course['ImageName']; ?>" height="100px;" width="100px;" /> </td>
                <td><?php echo $row_course['AddUserTime']; ?></td>
                <td> <a onclick="EditCourse(<?php echo $row_course['CourseID']; ?>);" href="javascript:void(0);" class="btn btn-primary">Edit</a>
                    <a onclick="DeleteCourse(<?php echo $row_course['CourseID']; ?>);" href="javascript:void(0);"  class="btn btn-danger">Delete</a>
                </td>        
                	            
            </tr>
            <?php } ?>
        </tbody>    
    </table></div></div>
                     
            </div>
         
     </div>
     <!-- END CONTENT BODY -->
 </div>
 <!-- END CONTENT -->
<?php include('../../footer.php'); ?>           
<!--<script type="text/javascript" src="//code.jquery.com/jquery-1.12.3.js" ></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js" ></script>

<script type="text/javascript">
    $(document).ready(function() {
        $('#example').DataTable( {
            "pagingType": "full_numbers"
        });
    });
</script>  
-->
<script type="text/javascript">
function DeleteCourse(CourseID){
	var CourseID = CourseID;
	var action = 'delete';
	if (confirm('Are You Sure You Want To Delete Course?')) {
    	// Save it!
		$.ajax({
			method:'post',
			url:"<?php echo $AdminPath; ?>action/course.php",
			data:{CourseID:CourseID,action:action},
			success: function(resp){
				$('#delete_success').show();
                $('#course_row_'+CourseID).remove();
			}
		});
	} else {
    	// Do nothing!
	}
}
function AddCourse(){
    window.location.href = "<?php echo $AdminPath; ?>pages/course/add_course.php";
}

function EditCourse(CourseID){
    window.location.href = "<?php echo $AdminPath; ?>pages/course/add_course.php?CourseID="+CourseID;
}

function AddNewTopics(CourseID){
  window.location.href = "<?php echo $AdminPath; ?>pages/course/add_data.php?CourseID="+CourseID;  
}

</script>