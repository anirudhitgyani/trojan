<?php include('../../connection.php');
include('../../header_stud.php'); 
	
    $TopicID = $_REQUEST['TopicID'];
    $CourseID = $_REQUEST['CourseID'];
        
   $sql_test = mysql_query("select * from `QuestionSet` where TopicID = '".$TopicID."' " );
   

?>


<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<div class="col-sm-3 col-xs-12 col-md-2 left-col">
<div class="collapse navbar-collapse left-menu" id="bs-example-navbar-collapse-1">
                                      <ul class="nav navbar-nav">
<li><a href="<?php echo $RootPath; ?>pages/student/">Dashbord <img src="<?php echo $RootPath; ?>images/dashbord/dashbord-icon.png" /></a></li>
      <li><a href="<?php echo $RootPath; ?>pages/student/profile.php">Profile <img src="<?php echo $RootPath; ?>images/dashbord/profile-icon.png" /></a></li>
      <li><a href="#">Message<img src="<?php echo $RootPath; ?>images/dashbord/message-icon.png" /></a></li>
      <li><a href="#">Activities <img src="<?php echo $RootPath; ?>images/dashbord/exam-icon.png" /></a></li>
      <li><a href="#">Projects<img src="<?php echo $RootPath; ?>images/dashbord/project-icon.png" /></a></li>
      <li><a href="#">Exams <img src="<?php echo $RootPath; ?>images/dashbord/exam-icon.png" /></a></li>
            <li><a href="#">Settings<img src="<?php echo $RootPath; ?>images/dashbord/account-icon.png" /></a></li>
                  
                        <li><a href="<?php echo $RootPath; ?>pages/student/logout.php">Logout<img src="<?php echo $RootPath; ?>images/dashbord/logout-icon.png" /></a></li>                                      </ul>
                                    </div>
</div>
<div class="col-sm-9 col-xs-12 col-md-10 no-padding-right right-col">
<div class="student-profile-section grey-box">
<div class="student-titles pull-left text-right"><small>Student Test</small></div>


<?php if(isset($_SESSION['Success'])) { ?>
<br/><br/>
<div style="color:green;" class="student-titles">
    <h5><?php echo $_SESSION['Success']; ?></h5>
</div>
<?php } unset($_SESSION['Success']); ?> 

<?php if(isset($_SESSION['Error'])) { ?>
<br/><br/>
<div style="color:red;" class="student-titles">
    <h5><?php echo $_SESSION['Error']; ?></h5>
</div>
<?php } unset($_SESSION['Error']); ?> 
<br/><br/><br/>

<?php $a=1; while($row_test = mysql_fetch_array($sql_test)) { ?>
<div style="margin-top: 20px;">
    Question : <label> <?php echo $row_test['Question']; ?> </label> <br/><br/>
            Answers : <input type="radio" name="answer_<?php echo $a; ?>" id="answer_<?php echo $a; ?>" value="<?php echo $row_test['Answer01'] ?>" />  <?php echo $row_test['Answer01'] ?>   
                      <input type="radio" name="answer_<?php echo $a; ?>" id="answer_<?php echo $a; ?>" value="<?php echo $row_test['Answer02'] ?>" /> <?php echo $row_test['Answer02'] ?>    
                      <input type="radio" name="answer_<?php echo $a; ?>" id="answer_<?php echo $a; ?>" value="<?php echo $row_test['Answer03'] ?>" /> <?php echo $row_test['Answer03'] ?>    
                      <input type="radio" name="answer_<?php echo $a; ?>" id="answer_<?php echo $a; ?>" value="<?php echo $row_test['Answer04'] ?>" /> <?php echo $row_test['Answer04'] ?>  
                      </div>
    <?php $a++; } ?>

<div  style="margin-top: 30px;"  class="buttons-box text-center">
    
 
    <input type="button" onclick="CompletedTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" value="Submit" class="green-butt green-back" />
    <input type="button" onclick="CancelTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" class="green-butt" value="Cancel" /></div>
 
    
    </div>
    
    

</div>





</div>
</div>
</div>

</div>



<?php include('../../footer.php'); ?>

<script type="text/javascript">
function CancelTest(TopicID,CourseID){
	window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+CourseID+"&TopicID="+TopicID;	
}
</script>
<script type="text/javascript">
function CompletedTest(TopicID,CourseID){
	var action = "completed_test";
	$.ajax({
		method:'post',
		url:'<?php echo $RootPath; ?>action/student.php',
		data:{TopicID:TopicID,action:action},
		success: function(resp){
			alert('Test Completed');
			window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+CourseID+"&TopicID="+TopicID;	
		}
	});
}
</script>


