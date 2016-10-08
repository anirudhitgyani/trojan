<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
?>

<!--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />-->

<?php $sql_user = mysql_query("SELECT * FROM `profile` where GroupID = '3'") or die(mysql_error()); ?>  
<!-- BEGIN CONTENT -->
 <div class="page-content-wrapper">
     <!-- BEGIN CONTENT BODY -->
     <div class="page-content accordian-tabs">
         <!-- BEGIN PAGE HEADER-->

         <!-- BEGIN PAGE TITLE-->
         <h1 class="page-title"> Manage User </h1>
         
         
         
            <div class="portlet box border-grey">
                <div class="portlet-body"><div class="dataTables_wrapper">
                <table id="example" class="display table table-striped table-bordered table-hover dt-responsive" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Contact No</th>
                <th>Email</th>
                <th>Company Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Contact No</th>
                <th>Email</th>
                <th>Company Name</th>
                <th>Action</th>
            </tr> 
        </tfoot>
        <tbody>
            <?php while($row_user = mysql_fetch_array($sql_user)) {  ?>
            <tr>
                <td><?php echo $row_user['ProfileFirstName']; ?></td>
                <td><?php echo $row_user['ProfileLastName']; ?></td>
                <td><?php echo $row_user['ProfileMobile']; ?></td>
                <td><?php echo $row_user['ProfileEmail']; ?></td>
                <td><?php echo $row_user['ProfileCompanyName']; ?></td>
                <td><a href="<?php echo $AdminPath; ?>action/user.php?ProfileID=<?php echo $row_user['ProfileID']; ?>&action=delete1"><button type="button" class="btn btn-secondary" data-dismiss="modal">Delete</button></a></td>
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
<script type="text/javascript" src="//code.jquery.com/jquery-1.12.3.js" ></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js" ></script>

<script type="text/javascript">
    $(document).ready(function() {
        $('#example').DataTable( {
            "pagingType": "full_numbers"
        });
    });
</script>  

