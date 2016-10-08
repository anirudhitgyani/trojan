<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_course = mysql_query("SELECT * FROM `course` ") or die(mysql_error()); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> Course List </h1>
         
         
            <div class="portlet box border-grey">
                <div class="portlet-body"><div class="dataTables_wrapper">
                <table id="sample_3" class="display table table-striped table-bordered table-hover dt-responsive dataTable dtr-inline" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Course Name</th>
                <th>Description</th>
                <th>Image</th>
                <th>Created Date</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Course Name</th>
                <th>Description</th>
                <th>Image</th>
                <th>Created Date</th>
            </tr>
        </tfoot>
        <tbody>
            <?php while($row_course = mysql_fetch_array($sql_course)) {  ?>
            <tr style="cursor: pointer;"  onclick="GoToTopic(<?php echo $row_course['CourseID']; ?>);"  >
                <td><?php echo $row_course['CourseName']; ?></td>
                <td><?php echo $row_course['CourseDesc']; ?></td>
                <td><img src="<?php echo $AdminPath; ?>/upload_images/course_images/<?php echo $row_course['ImageName']; ?>" height="100px;" width="100px;" /> </td>
                <td><?php echo $row_course['AddUserTime']; ?></td>
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
function GoToTopic(CourseID){
  window.location.href = "<?php echo $AdminPath; ?>pages/topic/topic.php?CourseID="+CourseID;  
}

</script>