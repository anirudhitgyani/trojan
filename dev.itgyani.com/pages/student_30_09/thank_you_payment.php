<?php include('../../connection.php'); ?>
<?php include('../../header.php'); 
$current_time = date('Y-m-d H:i:s');
$payment_id = $_REQUEST['payment_id'];
$status = $_REQUEST['status'];
if($status=="success") {
    $sql = mysql_query("update `profile` set IsPaid = '1' , UpdateUserTime = '".$current_time."' , PaymentID = '".$payment_id."' , PaymentStatus = '".$status."' where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
}

?>




<div class="middle-content">
    <div class="corporate-login-sect_1">
        <div class="login-form">
            <div class="form-area" style="margin-top: 200px; margin-bottom: 200px;" >
                <h2 class="page-title">Thank You</h2>
                    <div class="row">
                    <div class="col-sm-9 col-xs-12 col-md-12">
                            <h4>Your Payment Successfully Paid. Thank You.</h4>
                        <p><strong>
                            <a href="<?php echo $RootPath; ?>pages/student/" > click here </a>
                            </strong></p></div>
                    </div>
            </div>
        </div>
    </div>
</div>




<?php include('../../footer.php'); ?>