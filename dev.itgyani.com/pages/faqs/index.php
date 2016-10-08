<?php include('../../connection.php');
include('../../header.php');
	$CourseID = $_REQUEST['CourseID'];
	$sql = mysql_query("select * from `faq` where CourseID = '".$CourseID."' ") or die(mysql_error());
?>

<div class="middle-content">
<div class="container static-page text-left">
<h2 class="page-title">FAQs</h2>
<div class="row">

<div class="col-sm-9 col-xs-12 col-md-12">
	<?php $a = 1; while($row = mysql_fetch_array($sql)) { ?>
	<strong><?php echo $a; ?> : <?php echo $row['FAQ']; ?></strong> 
    <p>Answer : <?php echo $row['FAQAnswer']; ?></p>
    <?php $a++; } ?>
    </div>
</div>
<hr />


</div>
</div>

<?php include('../../footer.php'); ?>