<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	
	$CourseID = $_REQUEST['CourseID'];
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_course = mysql_query("SELECT * FROM `topic` where CourseID = '".$CourseID."' ") or die(mysql_error()); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> Topic List </h1>
         
         
            <div class="portlet box grey border-grey">
                
                <table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Topic Name</th>
                <th>Description</th>
                <th>Created Date</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Topic Name</th>
                <th>Description</th>
                <th>Created Date</th>
            </tr>
        </tfoot>
        <tbody>
            <?php while($row_course = mysql_fetch_array($sql_course)) {  ?>
            <tr style="cursor: pointer;"  onclick="GoToQA(<?php echo $row_course['TopicID']; ?>);"  >
                <td><?php echo $row_course['TopicName']; ?></td>
                <td><?php echo $row_course['TopicDesc']; ?></td>
                <td><?php echo $row_course['AddUserTime']; ?></td>
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
function GoToQA(TopicID){
  window.location.href = "<?php echo $AdminPath; ?>pages/question_answers/qa.php?TopicID="+TopicID;  
}

</script>    