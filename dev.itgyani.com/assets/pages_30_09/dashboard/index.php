<?php include('../../connection.php');
include('../../header.php');

    if(!isset($_SESSION['AdminID'])) {
        echo "<script>window.location='$AdminPath'</script>";
        exit;
    }
?>
                <!-- BEGIN CONTENT -->
                <div class="page-content-wrapper">
                    <!-- BEGIN CONTENT BODY -->
                    <div class="page-content">
                        <!-- BEGIN PAGE HEADER-->
                
                        <!-- BEGIN PAGE TITLE-->
                        <h1 class="page-title"> Home </h1>
                        <!-- END PAGE TITLE-->
                       
                        <!-- END PAGE HEADER-->
                        
                    </div>
                    <!-- END CONTENT BODY -->
                </div>
                <!-- END CONTENT -->
                
<?php include('../../footer.php'); ?>           