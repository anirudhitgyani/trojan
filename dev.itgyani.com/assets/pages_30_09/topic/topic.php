<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	$CourseID = $_REQUEST['CourseID'];
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_topic = mysql_query("SELECT * FROM `topic` where CourseID = '".$CourseID."' ") or die(mysql_error()); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title" id="table_heading" > All Topics List </h1>
         
         
         <!-- END PAGE TITLE-->
       
         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
<h3 style="display:none; color:green;" id="delete_success" > Topic Deleted Successfully </h3>
                <table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Course Name</th>
                <th>Topic Name</th>
                <th>Topic Description</th>
                <th>Course Type</th>
                <th>Action</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Course Name</th>
                <th>Topic Name</th>
                <th>Topic Description</th>
                <th>Course Type</th>
                <th>Action</th>
            </tr>
        </tfoot>
        <tbody>
            <?php while($row_topic = mysql_fetch_array($sql_topic)) {
				
				$sql_course = mysql_query("select * from `course` where CourseID = '".$row_topic['CourseID']."' ");
				$row_course = mysql_fetch_array($sql_course);
				
				$sql_category = mysql_query("select * from `coursecategory` where CourseCategoryID = '".$row_course['CourseCategoryID']."' ");
				$row_category = mysql_fetch_array($sql_category); 
				
			?>
            <tr id="topic_row_<?php echo $row_topic['TopicID']; ?>" >
                <td><?php echo $row_course['CourseName']; ?></td>
                <td><?php echo $row_topic['TopicName']; ?></td>
                <td><?php echo $row_topic['TopicDesc']; ?></td>
                <td><?php echo $row_category['CategoryName']; ?></td>
                <td> <a href="javascript:void(0);" onclick="EditTopic(<?php echo $row_topic['TopicID']; ?>);" >  Edit </a>  | <a href="javascript:void(0);" onclick="DeleteTopic(<?php echo $row_topic['TopicID']; ?>);" > Delete </a> </td>
            </tr>
            <?php } ?>
        </tbody>    
    </table>
                     
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
function DeleteTopic(TopicID){
	var TopicID = TopicID;
	var action = 'delete';
	if (confirm('Are You Sure You Want To Delete Topic?')) {
    	// Save it!
		$.ajax({
			method:'post',
			url:"<?php echo $AdminPath; ?>action/topic.php",
			data:{TopicID:TopicID,action:action},
			success: function(resp){
				$('#delete_success').show();
                $('#topic_row_'+TopicID).remove();
				$('html, body').animate({
        			'scrollTop' : $("#table_heading").position().top
    			},2000);
			}
		});
	} else {
    	// Do nothing!
	}
}
function EditTopic(TopicID){
	window.location.href = '<?php echo $AdminPath; ?>pages/topic/add_topic.php?TopicID='+TopicID;
}
</script>    