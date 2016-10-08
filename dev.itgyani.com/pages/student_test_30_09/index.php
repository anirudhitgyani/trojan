<?php include('../../connection.php');
include('../../header_stud.php'); 
	
    $TopicID = $_REQUEST['TopicID'];
    $CourseID = $_REQUEST['CourseID'];
        
    $sql_test = mysql_query("select * from `QuestionSet` where TopicID = '".$TopicID."' order by QuestionSetID ASC limit 0,1 " );
    $row_test = mysql_fetch_array($sql_test);
   
    $sql_test_1 = mysql_query("select * from `QuestionSet` where TopicID = '".$TopicID."' ");
    $TotalQuestion = mysql_num_rows($sql_test_1);
    if($TotalQuestion) {
        $PercentagePerQuestion = 100 / $TotalQuestion;
    }
     
    $sql_question_nextid= mysql_query("SELECT * FROM `QuestionSet` WHERE TopicID = '".$TopicID."' AND QuestionSetID > '".$row_test['QuestionSetID']."' ORDER BY QuestionSetID ASC  LIMIT 1") or die(mysql_error()); 
    $row_question_nextid = mysql_fetch_array($sql_question_nextid);
    $NextQuestionID = $row_question_nextid['QuestionSetID'];
    
   
   
    $prevquery= "SELECT * FROM `topic` WHERE TopicID > '".$TopicID."' AND CourseID = '".$CourseID."' ORDER BY TopicID ASC  LIMIT 1"; 
    $prevresult = mysql_query($prevquery) or die(mysql_error());
    $row_next_id = mysql_fetch_array($prevresult);
    $NextTopicID = $row_next_id['TopicID'];
    
    $prevquery_1= "SELECT * FROM `course` WHERE CourseID > '".$CourseID."' ORDER BY CourseID ASC  LIMIT 1"; 
    $prevresult_1 = mysql_query($prevquery_1) or die(mysql_error());
    $row_next_id_1 = mysql_fetch_array($prevresult_1);
    $NextCourseID = $row_next_id_1['CourseID'];
    
    $sql_first_topic = mysql_query("select * from `topic` where CourseID = '".$NextCourseID."' order by TopicID asc limit 0 , 1 ")  or die(mysql_error());	
    $row_first_topic = mysql_fetch_array($sql_first_topic);
    
        
        

?>
<input type="hidden" name="NextTopicID" id="NextTopicID" value="<?php echo $NextTopicID; ?>" />
<input type="hidden" name="NextCourseID" id="NextCourseID" value="<?php echo $NextCourseID; ?>" />
<input type="hidden" name="NextCourseTopicID" id="NextCourseTopicID" value="<?php echo $row_first_topic['TopicID'];; ?>" />
<input type="hidden" name="CoverPercentage" id="CoverPercentage" value="0" />
<input type="hidden" name="PercentagePerQuestion" id="PercentagePerQuestion" value="<?php echo number_format($PercentagePerQuestion,2); ?>" />
<input type="hidden" name="answer_is_checked" id="answer_is_checked" value="0" />

<?php if($TotalQuestion!='0') { ?>

<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<div class="col-sm-12 col-xs-12 col-md-12 no-padding-right right-col">
<div class="student-profile-section grey-box">
<div class="student-titles pull-left text-right"><small>Student Test </small></div><br/><br/>
<div class="student-titles pull-left text-right">
    <small>Your Score :- <span id="total_score">00.00</span>%</small>
</div><br/><br/>
<h4 style="color:red;">Student should score up to 80% to move on next topic</h4>


<div style="margin-top: 20px;" id="Question_Div" >
    
    <input type="hidden" name="NextQuestionID" id="NextQuestionID" value="<?php echo $NextQuestionID; ?>" />
    
     <label> <?php echo $row_test['Question']; ?> </label> <br/><br/>
              
			
			<!--option 1-->
            <?php if($row_test['Answer01']) { ?>
		<input type="radio" name="answer_1" id="answer_1" onclick="SaveAnswer('1','<?php echo $row_test['QuestionSetID']; ?>');" value="<?php echo $row_test['Answer01'] ?>" /> <?php echo $row_test['Answer01'] ?> <br/><br/>
            <?php } ?>
                     
				<!--option 2-->
            <?php if($row_test['Answer02']) { ?>	 
                <input type="radio" name="answer_2" id="answer_2" onclick="SaveAnswer('2','<?php echo $row_test['QuestionSetID']; ?>');" value="<?php echo $row_test['Answer02'] ?>" /> <?php echo $row_test['Answer02'] ?> <br/><br/>   
            <?php } ?>
                      
				<!--option 3-->
            <?php if($row_test['Answer03']) { ?>	  
                <input type="radio" name="answer_3" id="answer_3" onclick="SaveAnswer('3','<?php echo $row_test['QuestionSetID']; ?>');" value="<?php echo $row_test['Answer03'] ?>" /> <?php echo $row_test['Answer03'] ?> <br/><br/>  
            <?php } ?>
				<!--option 4-->
            <?php if($row_test['Answer04']) { ?>  
                    <input type="radio" name="answer_4" id="answer_4" onclick="SaveAnswer('4','<?php echo $row_test['QuestionSetID']; ?>');" value="<?php echo $row_test['Answer04'] ?>" /> <?php echo $row_test['Answer04'] ?> <br/><br/>
            <?php } ?>    
                      
<img style="display:none;" id="right_img" src="<?php echo $RootPath; ?>images/right.png" height="100px;" width="100px;" />
<img style="display:none;" id="wrong_img" src="<?php echo $RootPath; ?>images/wrong.png" height="100px;" width="100px;" />                        


<div  style="margin-top: 30px;"  class="buttons-box text-center">
    
    <?php if($NextQuestionID) { ?>
        <input type="button" id="Question_Button" onclick="NextQuestion('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" value="Next" class="green-butt green-back" />
    <?php } ?>
    <input type="button" onclick="CompletedTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" value="Submit" class="green-butt green-back" />
    <input type="button" onclick="CancelTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" class="green-butt" value="Cancel" />
    <input type="button" onclick="RestartTest();" class="green-butt green-back" value="Restart Test" /></div>
 
</div>    



    
    </div>
    
    

</div>





</div>
</div>
</div>

<?php } else { ?>

<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<div class="col-sm-12 col-xs-12 col-md-12 no-padding-right right-col">
<div class="student-profile-section grey-box">
<div class="student-titles pull-left text-right"><small>Student Test </small></div><br/><br/>
<h4 style="color:green;">No Test For These Topic</h4>


<div style="margin-top: 20px;" id="Question_Div" >
    
<div  style="margin-top: 30px;"  class="buttons-box text-center">
    
    <input type="button" onclick="NoTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" value="Next Topic" class="green-butt green-back" />
 
</div>    



    
    </div>
    
    

</div>





</div>
</div>
</div>

<?php } ?>

<?php include('../../footer.php'); ?>

<script type="text/javascript">
function CancelTest(TopicID,CourseID){
	window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+CourseID+"&TopicID="+TopicID;	
}
</script>
<script type="text/javascript">
function CompletedTest(TopicID,CourseID){
	
	if($('#CoverPercentage').val() < 80) {
	
		alert('Please Score At Least 80%');
               window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+CourseID+"&TopicID="+TopicID;	
	
	} else {
	
		var action = "completed_test";
		var NextTopicID = $('#NextTopicID').val();
		$.ajax({
			method:'post',
			url:'<?php echo $RootPath; ?>action/student.php',
			data:{TopicID:TopicID,CourseID:CourseID,action:action},
			success: function(resp){
				alert('Test Completed');
				window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+CourseID+"&TopicID="+NextTopicID;	
			}
		});
	}
}
</script>
<script type="text/javascript">
function SaveAnswer(RowValue,QuestionSetID){
	if(RowValue=='1') {
		$('#answer_2').attr("disabled",true);
		$('#answer_3').attr("disabled",true);
		$('#answer_4').attr("disabled",true);
		var useranswer = '1';
                $('#answer_is_checked').val('1');
	} else if(RowValue=='2') {
		$('#answer_1').attr("disabled",true);
		$('#answer_3').attr("disabled",true);
		$('#answer_4').attr("disabled",true);
		var useranswer = '2';
                $('#answer_is_checked').val('1');
	} else if(RowValue=='3') {
		$('#answer_1').attr("disabled",true);
		$('#answer_2').attr("disabled",true);
		$('#answer_4').attr("disabled",true);
		var useranswer = '3';
                $('#answer_is_checked').val('1');
	} else if(RowValue=='4') {
		$('#answer_1').attr("disabled",true);
		$('#answer_2').attr("disabled",true);
		$('#answer_3').attr("disabled",true);
		var useranswer = '4';
                $('#answer_is_checked').val('1');
	}
	var action = 'save_user_answer';
        
	$.ajax({
		method:'post',
		url:'<?php echo $RootPath; ?>action/student.php',
		data:{useranswer:useranswer,QuestionSetID:QuestionSetID,action:action},
		success: function(resp){
			//alert(resp);
			if(resp=='0'){
				$('#wrong_img').show();
				$('#right_img').hide();
			} else if(resp=='1') {
				$('#right_img').show();
				$('#wrong_img').hide();
				var PercentagePerQuestion = parseFloat($('#PercentagePerQuestion').val());
				var CoverPercentage = $('#CoverPercentage').val();
				var Percentage1 = parseFloat(CoverPercentage) + parseFloat(PercentagePerQuestion);
				var CoverPercentage = $('#CoverPercentage').val(Percentage1);
				$('#total_score').text(Percentage1.toFixed(2));
                        }
		}
	});
	
}
</script>
<script type="text/javascript">
function RestartTest(){
	if(confirm("Are You Sure Want To Restart App?")){
		window.location.reload();
	} else  {
		
	}
}
</script>
<script type="text/javascript">
function NextQuestion(TopicID,CourseID){
    if($('#answer_is_checked').val()=='0'){
        alert('Please Complete Question First');
    } else {
        var action = "change_question";
        var NextQuestionID = $('#NextQuestionID').val();
        $.ajax({
            method:'post',
            url:'<?php echo $RootPath; ?>action/student.php',
            data:{TopicID:TopicID,NextQuestionID:NextQuestionID,CourseID:CourseID,action:action},
            success: function(resp){
                $('#Question_Div').html(resp);
                $('#answer_is_checked').val('0');
            }
        });
    }
    
}
</script>
<script type="text/javascript">
function NoTest(TopicID,CourseID){
        var action = "no_test";
        var NextTopicID = $('#NextTopicID').val();
        var NextCourseID = $('#NextCourseID').val();
        var NextCourseTopicID = $('#NextCourseTopicID').val();
         $.ajax({
            method:'post',
            url:'<?php echo $RootPath; ?>action/student.php',
            data:{TopicID:TopicID,CourseID:CourseID,action:action,NextTopicID:NextTopicID},
            success: function(resp){
                if(resp=='1'){
                    window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+CourseID+"&TopicID="+NextTopicID;	
                } if(resp=='0'){
                    window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+NextCourseID+"&TopicID="+NextCourseTopicID;
                }
                
            }
        });
	
}
</script>