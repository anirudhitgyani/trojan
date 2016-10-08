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
         <h1 class="page-title"> Add New Topics / FAQ / Question & Answers </h1>
         
        
         <!-- END PAGE TITLE-->

         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
                
                <?php if($CourseID!='') { ?>
                <form method="post" action="<?php echo $AdminPath; ?>action/course.php" id="topic_form"   enctype="multipart/form-data" >
                    <input type="button" onclick="AddTopic();" name="add_topic" id="add_topic" value="Add Topic" />
                    <input style="display: none;" type="file" name="topic_file" id="topic_file" value="" />
                    <input type="hidden" name="action" id="action" value="add_topic" />
                    <input type="hidden" name="CourseID" id="CourseID" value="<?php echo $CourseID; ?>" />
                </form> <br/><br/>
                
                
                <form method="post" action="<?php echo $AdminPath; ?>action/course.php" id="faqs_form"   enctype="multipart/form-data" >
                
                	<input style="display: none;" type="file" name="faqs_file" id="faqs_file" value="" />
                    <input type="button" onclick="AddFAQ();"  name="add_faqs" id="add_faqs" value="Add FAQ" /><br/><br/>
                    <input type="hidden" name="action" id="action" value="add_faqs" />
        			<input type="hidden" name="CourseID" id="CourseID" value="<?php echo $CourseID; ?>" />
                    
                </form>    
                
                
                <form method="post" action="<?php echo $AdminPath; ?>action/course.php" id="qa_form"   enctype="multipart/form-data" >
                    
                    <input type="button" onclick="AddQA();" name="add_qa" id="add_qa" value="Add QA" />
                    
                	<input style="display: none;" type="file" name="qa_file" id="qa_file" value="" />
                    
                    <input type="hidden" name="action" id="action" value="add_qa" />
                    
                    <input type="hidden" name="CourseID" id="CourseID" value="<?php echo $CourseID; ?>" />
                    
               	</form>     
                
                <?php } ?>
                
                     
            </div>
         
     </div>
     <!-- END CONTENT BODY -->
 </div>
 <!-- END CONTENT -->
<?php include('../../footer.php'); ?> 
<script type="text/javascript">
function AddTopic(){
    $('#topic_file').click();
}  

</script>  
<script type="text/javascript">
$(document).ready(function(){
   $( "#topic_file" ).change(function() {
        $('#topic_form').submit();
    });
});
</script>


<script type="text/javascript">
function AddFAQ(){
    $('#faqs_file').click();
}  

</script>  
<script type="text/javascript">
$(document).ready(function(){
   $( "#faqs_file" ).change(function() {
        $('#faqs_form').submit();
    });
});
</script>

<script type="text/javascript">
function AddQA(){
    $('#qa_file').click();
}  

</script>  
<script type="text/javascript">
$(document).ready(function(){
   $( "#qa_file" ).change(function() {
        $('#qa_form').submit();
    });
});
</script>

