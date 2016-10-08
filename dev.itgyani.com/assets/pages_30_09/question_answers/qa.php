<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	$TopicID = $_REQUEST['TopicID'];
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_qa = mysql_query("SELECT * FROM `QuestionSet` where TopicID = '".$TopicID."' ") or die(mysql_error()); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> All Question Answer Of Topic</h1>
         
         <h1 id="delete_success"  style="display:none; color:red;" class="page-title"> Question Successfully Deleted...</h1>
         
         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
                
       <table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>Topic Name</th>
                <th>Question</th>
                <th>Answer</th>
                <th>Action</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Topic Name</th>
                <th>Question</th>
                <th>Answer</th>
                <th>Action</th>
            </tr>
        </tfoot>
        <tbody>
            <?php while($row_qa = mysql_fetch_array($sql_qa)) { 
			
			$sql_topic = mysql_query("select * from `topic` where TopicID = '".$row_qa['TopicID']."' ");
			$row_topic = mysql_fetch_array($sql_topic);
			
			 ?>
            <tr id="course_row_<?php echo $row_qa['QuestionSetID']; ?>" >
                <td><?php echo $row_topic['TopicName']; ?></td>
                <td><?php echo $row_qa['Question']; ?></td>
                <?php if($row_qa['IsAnswer01Ok']=='1') { ?>
                	<td><?php echo $row_qa['Answer01']; ?></td>
                <?php } else if($row_qa['IsAnswer02Ok']=='1') { ?>
                	<td><?php echo $row_qa['Answer02']; ?></td>
                <?php } else if($row_qa['IsAnswer03Ok']=='1') { ?>
                	<td><?php echo $row_qa['Answer03']; ?></td>
                <?php } else if($row_qa['IsAnswer04Ok']=='1') { ?>
                	<td><?php echo $row_qa['Answer04']; ?></td>
                <?php } ?>
                  <td> <a href="javascript:void(0);" onclick="EditQA(<?php echo $row_qa['QuestionSetID']; ?>);" >  Edit </a>  | <a href="javascript:void(0);" onclick="DeleteQA(<?php echo $row_qa['QuestionSetID']; ?>);" > Delete </a> </td>
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
function DeleteQA(QuestionSetID){
	var QuestionSetID = QuestionSetID;
	var action = 'delete';
	if (confirm('Are You Sure You Want To Delete Question?')) {
    	// Save it!
		$.ajax({
			method:'post',
			url:"<?php echo $AdminPath; ?>action/qa.php",
			data:{QuestionSetID:QuestionSetID,action:action},
			success: function(resp){
				$('#delete_success').show();
                $('#course_row_'+QuestionSetID).remove();
			}
		});
	} else {
    	// Do nothing!
	}
}

function EditQA(QuestionSetID){
    window.location.href = "<?php echo $AdminPath; ?>pages/question_answers/add_qa.php?QuestionSetID="+QuestionSetID;
}


</script>    