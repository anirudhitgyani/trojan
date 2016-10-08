<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
	$FAQID = $_REQUEST['FAQID'];
?>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
<?php $sql_faq = mysql_query("SELECT * FROM `faq` where FAQID = '".$FAQID."' ") or die(mysql_error()); $row_faq = mysql_fetch_array($sql_faq); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title" id="table_heading" > Edit FAQs </h1>
         
         
         <!-- END PAGE TITLE-->
       
         <!-- END PAGE HEADER-->
            <div class="portlet box grey border-grey">
			<form action="<?php echo $AdminPath; ?>action/faq.php" method="post" id="faq_form" >
        	
            <input type="hidden" name="action" id="action" value="update" />
            <input type="hidden" name="FAQID" id="FAQID" value="<?php echo $FAQID; ?>" />
            <label class="control-label visible-ie8 visible-ie9">FAQ</label>
          	<input class="form-control" type="text" name="FAQ" id="FAQ" value="<?php echo $row_faq['FAQ']; ?>" /> <br/>
            <label class="control-label visible-ie8 visible-ie9">FAQAnswer</label> 
            <input type="text" class="form-control" name="FAQAnswer" id="FAQAnswer" value="<?php echo $row_faq['FAQAnswer']; ?>" /> <br/>
            <input class="control-label" value="Submit"  type="button" onclick="savefaq();"  />
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
    $(document).ready(function() {
        $('#example').DataTable( {
            "pagingType": "full_numbers"
        });
    });
</script>  
<script type="text/javascript">
function savefaq(){
	var flag = true;
	if($('#FAQ').val()==''){
		$('#FAQ').css('border','1px solid red');
		flag = false;
	} else {
		$('#FAQ').css('border','1px solid #ccc');
	}
	if($('#FAQAnswer').val()==''){
		$('#FAQAnswer').css('border','1px solid red');
		flag = false;
	} else {
		$('#FAQAnswer').css('border','1px solid #ccc');
	}
	
	if(flag==false) {
		return false;
	} else {
		$('#faq_form').submit();
	}
		
}
</script>
    