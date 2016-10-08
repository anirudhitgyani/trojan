<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	
	$CourseID = $_REQUEST['CourseID'];
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_faq = mysql_query("SELECT * FROM `faq` where CourseID = '".$CourseID."' ") or die(mysql_error()); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> All FAQs List</h1>
         
         <?php if(isset($_SESSION['success'])) { ?>
         	<h1 class="page-title" style="color:green" ><?php echo $_SESSION['success']; ?></h1>
         <?php } ?>
         <!-- END PAGE TITLE-->
         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
           <h3 style="display:none; color:green;" id="delete_success" > FAQ Deleted Successfully </h3>     
        <table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Course Name</th>
                <th>FAQ</th>
                <th>FAQAnswer</th>
                <th>Action</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Course Name</th>
                <th>FAQ</th>
                <th>FAQAnswer</th>
                <th>Action</th>
            </tr>
        </tfoot>
        <tbody>
            <?php while($row_faq = mysql_fetch_array($sql_faq)) { 
			
			$sql_course = mysql_query("select * from `course` where CourseID = '".$row_faq['CourseID']."' ");
			$row_course = mysql_fetch_array($sql_course);
			
			 ?>
            <tr id="faq_row_<?php echo $row_faq['FAQID']; ?>" >
                <td><?php echo $row_course['CourseName']; ?></td>
                <td><?php echo $row_faq['FAQ']; ?></td>
                <td><?php echo $row_faq['FAQAnswer']; ?></td>
                <td> <a href="javascript:void(0);" onclick="EditFAQ(<?php echo $row_faq['FAQID']; ?>);" >  Edit </a>  | <a href="javascript:void(0);" onclick="DeleteFAQ(<?php echo $row_faq['FAQID']; ?>);" > Delete </a> </td>
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
function DeleteFAQ(FAQID){
	var FAQID = FAQID;
	var action = 'delete';
	if (confirm('Are You Sure You Want To Delete FAQ?')) {
    	// Save it!
		$.ajax({
			method:'post',
			url:"<?php echo $AdminPath; ?>action/topic.php",
			data:{FAQID:FAQID,action:action},
			success: function(resp){
				$('#delete_success').show();
                $('#faq_row_'+FAQID).remove();
				$('html, body').animate({
        			'scrollTop' : $("#table_heading").position().top
    			},2000);
			}
		});
	} else {
    	// Do nothing!
	}
}
</script>    
<script type="text/javascript">
function EditFAQ(FAQID){
	window.location.href = "<?php echo $AdminPath; ?>pages/faqs/add_faq.php?FAQID="+FAQID;
}
</script>