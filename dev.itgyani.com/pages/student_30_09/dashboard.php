<?php include('../../connection.php');
include('../../header_stud.php'); 
error_reporting('0');
/*$sql_biodata = mysql_query("select * from `biodata` where ProfileID = '".$_SESSION['stud_id']."' ");
$total_biodata = mysql_num_rows($sql_biodata);

$sql_academic = mysql_query("select * from `academic` where ProfileID = '".$_SESSION['stud_id']."' ");
$total_academic = mysql_num_rows($sql_academic);

if($total_biodata=='0' || $total_academic=='0') {
	
	$_SESSION['Error'] = "Please Complete Profile & Acadamic Form First...";
	header("location:".$RootPath."pages/student/profile.php");
	exit();
}
*/



	//$sql_topic = mysql_query("select * from `topic` where CourseID = '1' ") or die(mysql_error());
	//if($row_user['IsPaid']=='1') {
		$sql_course = mysql_query("select * from `course` ") or die(mysql_error());
	//} else {
		//$sql_course = mysql_query("select * from `course` where CourseCategoryID != '1' ") or die(mysql_error());
	//}

	

	$CourseID = $_REQUEST['CourseID'];
	$TopicID = $_REQUEST['TopicID'];
	
	if($CourseID){
		
		
		$sql_course_1 = mysql_query("select * from `course` where CourseID = '".$CourseID."' ") or die(mysql_error());
		$row_course_1 = mysql_fetch_array($sql_course_1);
		
		$sql_topic_video = mysql_query("select * from `topic` where CourseID = '".$CourseID."' AND TopicID = '".$TopicID."' ") or die(mysql_error());
		$row_topic_video = mysql_fetch_array($sql_topic_video);
	
		
	
	$sql_test = mysql_query("select * from test_detail where TopicID = '".$TopicID."' AND ProfileID = '".$_SESSION['stud_id']."' AND IsCompleted = '1' order by TopicID ASC ");
	$total_test_rows = mysql_num_rows($sql_test);
	
	
	$prevquery= "SELECT * FROM `topic` WHERE TopicID > '".$TopicID."' AND CourseID = '".$CourseID."' ORDER BY TopicID ASC  LIMIT 1"; 
$prevresult = mysql_query($prevquery) or die(mysql_error());
$row_next_id = mysql_fetch_array($prevresult);
	$NextID = $row_next_id['TopicID'];
	
	$sql_course_nextid= mysql_query("SELECT * FROM `course` WHERE CourseID > '".$CourseID."' ORDER BY CourseID ASC  LIMIT 1"); 
	$row_course_nextid = mysql_fetch_array($sql_course_nextid);
	$NextCourseID = $row_course_nextid['CourseID'];
	
	
	$sql_faqs = mysql_query("select * from `faq` where CourseID = '".$CourseID."' ") or die(mysql_error());	
	}
	
	
	
	
?>
<input type="hidden" name="video_no" id="video_no" value="1" />
<input type="hidden" name="test_completed" id="test_completed" value="<?php echo $total_test_rows; ?>" />
<input type="hidden" name="NextCourseID" id="NextCourseID" value="<?php echo $NextCourseID; ?>" />
<div class="middle-content student-dashbord-content">
<div class="container-fluid">
<div class="row">

<div class="col-sm-3 col-xs-12 col-md-2">
<div class="dashbord-box my-course">
<h2>My Course</h2>
<div class="box-content">
	<ul>
    	<?php while($row_course = mysql_fetch_array($sql_course)) {
			
	$sql_first_topic = mysql_query("select * from `topic` where CourseID = '".$row_course['CourseID']."' order by TopicID asc limit 0 , 1 ")  or die(mysql_error());	
	$row_first_topic = mysql_fetch_array($sql_first_topic);
			
			 ?>
<!--            <li><a <?php if($row_course['CourseID']==$CourseID) { ?> style="color:#ffffff" <?php } ?>  href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID=<?php echo $row_course['CourseID']; ?>&TopicID=<?php echo $row_first_topic['TopicID']; ?>"><?php echo $row_course['CourseName']; ?></a></li>-->
                <li><i class="fa fa-arrow-right" aria-hidden="true"></i>
				<a <?php if($row_course['CourseID']==$CourseID) { ?> style="color:#ffffff" <?php } ?>  href="<?php echo $RootPath; ?>pages/student/course.php"><?php echo $row_course['CourseName']; ?></a></li>
        <?php } ?>
    </ul>
</div>
</div>
</div>

<div class="col-sm-9 col-xs-12 col-md-8">
    <div class="dashbord-box video-box" >
		<h2>Video <?php echo $row_topic_video['TopicName']; ?></h2>
		<div class="box-content" style="max-width:100%;min-width:100%;  ">
		<!--<video poster="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.jpg" controls crossorigin style="max-width:100%;min-width:100%;  ">
							
							<source src="https://youtu.be/dPG8tb73kNo" type="video/mp4">
							<source src="https://youtu.be/dPG8tb73kNo" type="video/webm">

							
							<track kind="captions" label="English" srclang="en" src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.en.vtt" default>

						   
						</video>-->
			<?php if($CourseID!='') { ?>
				<?php if($row_topic_video['URL01Locked']=='1') { ?>
					<iframe id="topic_iframe" width="795" height="446" src="<?php echo $row_topic_video['URL01']; ?>"></iframe>  
				<?php } ?>
				<?php } else { ?>               
					<iframe width="100%" height="446" src="https://www.youtube.com/embed/dlJshzOv2cw"></iframe> 
				<?php } ?>         
		</div>
	</div>
	
	
<div class="student-buttons">
<a id="Video_Description" href="javascript:void(0);" onclick="VideoDescription();" >Video Description</a>
<a id="Next_Video" href="javascript:void(0);" onclick="NextVideo('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" >Reference Video</a>
<a  href="javascript:void(0);" onclick="StartTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" >Next</a>
<!--<a href="javascript:void(0);" onclick="NextTopic('<?php echo $NextID; ?>','<?php echo $CourseID; ?>');" >Next Topic</a>-->
<a href="javascript:void(0);" id="FAQs" onclick="ShowFAQs();" >FAQ</a>             
<a id="Show_Document"  href="javascript:void(0);" onclick="ShowDocument();" >Documents</a>
</div> 

<div id="tab1" style="display:none;" class="video-discription">
<h4><p><?php echo $row_topic_video['TopicDesc']; ?></p>
</h4>
</div>

<div id="tab2" style="display:none;" class="video-discription">
<h4><p>
	<?php $a = 1; while($row_faqs = mysql_fetch_array($sql_faqs)) { ?>
	<strong><?php echo $a; ?> : <?php echo $row_faqs['FAQ']; ?></strong> 
    <p>Answer : <?php echo $row_faqs['FAQAnswer']; ?></p>
    <?php $a++; } ?>
</p>
</h4>
</div>

<div id="tab3" style="display:none;" class="video-discription">
<h4><p>
	<?php if($row_topic_video['Doc01']) { ?>
	<a target="_blank" href="<?php echo $row_topic_video['Doc01']; ?>"><?php echo $row_topic_video['Doc01']; ?> </a> <br/><br/>
    <?php } if($row_topic_video['Doc02']) { ?>
    <a target="_blank" href="<?php echo $row_topic_video['Doc02']; ?>"><?php echo $row_topic_video['Doc02']; ?> </a> <br/><br/>
    <?php  }if($row_topic_video['Doc03'])  { ?>
    <a target="_blank" href="<?php echo $row_topic_video['Doc03']; ?>"><?php echo $row_topic_video['Doc03']; ?> </a> <br/><br/>
    <?php } if($row_topic_video['Doc04']) { ?>
    <a target="_blank" href="<?php echo $row_topic_video['Doc04']; ?>"><?php echo $row_topic_video['Doc04']; ?> </a> <br/><br/>
    <?php } ?>
</p>
</h4>
</div>	


</div>


<div class="col-sm-3 col-xs-12 col-md-2"><div class="dashbord-box my-course-progress">
<h2>Course Progress</h2>
<div class="box-content"></div>
</div></div>












</div>
</div>
</div>

</div>

<div class="modal fade" id="novideo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Alert Message</h4>
      </div>
      
        <div class="modal-body">
              <h3 style="color:red;" > No More Video In These Topic </h3>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="novideo_1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Alert Message</h4>
      </div>
      
        <div class="modal-body">
              <h3 style="color:red;" > Other Videos Are Locked In These Topic Please Pay First </h3>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="notopic" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Alert Message</h4>
      </div>
      
        <div class="modal-body">
              <h3 style="color:red;" > No More Topic In <?php echo $row_course_1['CourseName']; ?> Course </h3>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="no_test_completed" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="myModalLabel">Alert Message</h4>
      </div>
      
        <div class="modal-body">
              <h3 style="color:red;" > Please Complete Test First </h3>
        </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<?php include('../../footer.php'); ?>
<script type="text/javascript">
function NextVideo(TopicID,CourseID){
	$('#Next_Video').css('background','#04749c none repeat scroll 0 0');
	$('#Video_Description').css('background','#22252c none repeat scroll 0 0');
	$('#Show_Document').css('background','#22252c none repeat scroll 0 0');
	$('#FAQs').css('background','#22252c none repeat scroll 0 0');
	var TopicID = TopicID;
	var CourseID = CourseID;
	var action = "change_video";
	var video_no = parseInt($('#video_no').val());
	$.ajax({
		method:'post',
		url:"<?php echo $RootPath; ?>action/student.php",
		data:{TopicID:TopicID,action:action,video_no:video_no,CourseID:CourseID},
		success: function(resp){
			//alert(resp);
			if(resp=='0') {
				//alert('no more video');	
				$('#novideo').modal('show');			
			} else if(resp=='1') { 
				//alert('no more video');
				$('#novideo').modal('show');
			} else if(resp=='2') { 
				//alert('no more video');
				$('#novideo_1').modal('show');
			}  else {
				var a = 1;
				var newvideo_no = video_no + a;
				$('#topic_iframe').attr('src',resp);
				$('#video_no').val(newvideo_no);
			}
		}
	});
}
</script>


<script type="text/javascript">
function StartTest(TopicID,CourseID){
	window.location.href="<?php echo $RootPath; ?>pages/student_test?CourseID="+CourseID+"&TopicID="+TopicID;	
}
</script>

<script type="text/javascript">

function NextTopic(NextID,CourseID){
	if(NextID!='') {
		var testval = $('#test_completed').val();
		if(testval=='1') {
			window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+CourseID+"&TopicID="+NextID;	
		} else {
			//alert('Please Completed Test First');
			$('#no_test_completed').modal('show');
		}
	} else {
		//alert('No More Topics...');
		//var NextCourseID = $('#NextCourseID').val();
		//if($('#NextCourseID').val()=='') {
			$('#notopic').modal('show');
		//} else {
			//window.location.href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID="+NextCourseID;
		//}
		
	}
}
</script>
<script type="text/javascript">
function VideoDescription(){
	$('#tab1').show();
	$('#tab2').hide();
	$('#tab3').hide();
	$('#Video_Description').css('background','#04749c none repeat scroll 0 0');
	$('#Show_Document').css('background','#22252c none repeat scroll 0 0');
	$('#FAQs').css('background','#22252c none repeat scroll 0 0');
	$('#Next_Video').css('background','#22252c none repeat scroll 0 0');
}
</script>
<script type="text/javascript">
function ShowDocument(){
    /*var Doc01 = $('#Doc01').val();
    var Doc02 = $('#Doc02').val();
    var Doc03 = $('#Doc03').val();
    var Doc04 = $('#Doc04').val();
    if(Doc01!=''){
        window.open(Doc01, '_blank');
    }
    if(Doc02!=''){
        window.open(Doc02, '_blank');
    }
    if(Doc03!=''){
        window.open(Doc03, '_blank');
    }
    if(Doc04!=''){
        window.open(Doc04, '_blank');
    }
    */
	$('#tab3').show();
	$('#tab1').hide();
	$('#tab2').hide();
	$('#Show_Document').css('background','#04749c none repeat scroll 0 0');
	$('#Video_Description').css('background','#22252c none repeat scroll 0 0');
	$('#FAQs').css('background','#22252c none repeat scroll 0 0');
	$('#Next_Video').css('background','#22252c none repeat scroll 0 0');
}    
</script>

<script type="text/javascript">
function ShowFAQs(){
	//window.location.href = '<?php echo $RootPath; ?>pages/faqs?CourseID='+CourseID;
	$('#tab2').show();
	$('#tab1').hide();
	$('#tab3').hide();
	$('#FAQs').css('background','#04749c none repeat scroll 0 0');
	$('#Video_Description').css('background','#22252c none repeat scroll 0 0');
	$('#Show_Document').css('background','#22252c none repeat scroll 0 0');
	$('#Next_Video').css('background','#22252c none repeat scroll 0 0');
}
</script>