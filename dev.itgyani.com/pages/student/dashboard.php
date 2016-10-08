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
		
            
            
                $sql_update_user = mysql_query("update `profile` set LastCourseID = '".$_REQUEST['CourseID']."' , LastTopicID = '".$_REQUEST['TopicID']."' where ProfileID = '".$_SESSION['stud_id']."' ");
	
            
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
        
        $prevquery_1= "SELECT * FROM `topic` WHERE TopicID > '".$TopicID."' AND CourseID = '".$CourseID."' ORDER BY TopicID ASC  LIMIT 1"; 
        $prevresult_1 = mysql_query($prevquery_1) or die(mysql_error());
        $row_next_id_1 = mysql_fetch_array($prevresult_1);
        $NextTopicID = $row_next_id_1['TopicID'];
	
	
	$sql_faqs = mysql_query("select * from `faq` where CourseID = '".$CourseID."' ") or die(mysql_error());	
        
        $sql_test_1 = mysql_query("select * from `QuestionSet` where TopicID = '".$TopicID."' ");
        $TotalQuestion = mysql_num_rows($sql_test_1);
        
            $sql_first_topic_1 = mysql_query("select * from `topic` where CourseID = '".$NextCourseID."' order by TopicID asc limit 0 , 1 ")  or die(mysql_error());	
            $row_first_topic_1 = mysql_fetch_array($sql_first_topic_1);
    
	}
	
	
	
	
?>
<link rel="stylesheet" href="<?php echo $RootPath; ?>css/plyr.css">

<input type="hidden" name="video_no" id="video_no" value="1" />
<input type="hidden" name="NextTopicID" id="NextTopicID" value="<?php echo $NextTopicID; ?>" />
<input type="hidden" name="test_completed" id="test_completed" value="<?php echo $total_test_rows; ?>" />
<input type="hidden" name="NextCourseID" id="NextCourseID" value="<?php echo $NextCourseID; ?>" />
<input type="hidden" name="NextCourseTopicID" id="NextCourseTopicID" value="<?php echo $row_first_topic_1['TopicID'];; ?>" />





<div class="middle-content student-dashbord-content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-sm-12 col-xs-12 col-md-2 left-side no-padding-left">
        <div class="dashbord-box my-course side">
          <h2><i class="fa fa-info-circle"></i>My Course</h2>
          <div class="box-content">
            <nav>
              <ul class="nav">
                <?php while($row_course = mysql_fetch_array($sql_course)) { 
                    $sql_first_topic = mysql_query("select * from `topic` where CourseID = '".$row_course['CourseID']."' order by TopicID asc limit 0 , 1 ")  or die(mysql_error());	
                    $row_first_topic = mysql_fetch_array($sql_first_topic);
		?>  
                <li>
                    <a href="<?php echo $RootPath; ?>pages/student/course.php?CourseID=<?php echo $row_course['CourseID']; ?>">
                        <?php if($row_course['CourseID']==$CourseID) { ?> 
                            <i class="fa fa-check-circle c-blue"></i> 
                        <?php } else { ?> 
                            <i class="fa fa-check-circle"></i> 
                        <?php } ?> 
                            <?php echo $row_course['CourseName']; ?>
                    </a>
                </li>
                <?php } ?>
              </ul>
            </nav>
          </div>
        </div>
          
      <a href="javascript:void(0);" onclick="gotoleft();" class="toogle-buttons left-to"> <i class="fa fa-chevron-left"></i></a> </div>
      <div class="col-sm-12 col-xs-12 col-md-2 no-padding-right right-side pull-right">
        <div class="dashbord-box my-course-progress">
          <h2>Course Progress</h2>
          <div class="box-content">
            <div class="cource-progress">
              <h4>HTML5</h4>
              <div class="progress1 progress-striped">
                <div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width:70%">
                  <label>30% Progress</label>
                </div>
              </div>
            </div>
            <div class="cource-progress">
              <h4>JAVA SCRIPT</h4>
              <div class="progress1 progress-striped">
                <div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width:70%">
                  <label>30% Progress</label>
                </div>
              </div>
            </div>
            <div class="cource-progress">
              <h4>CSS</h4>
              <div class="progress1 progress-striped">
                <div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width:70%">
                  <label>30% Progress</label>
                </div>
              </div>
            </div>
            <div class="cource-progress">
              <h4>PHOTOSHOP</h4>
              <div class="progress1 progress-striped">
                <div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width:70%">
                  <label>30% Progress</label>
                </div>
              </div>
            </div>
            <div class="cource-progress">
              <h4>DREAMWEVER</h4>
              <div class="progress1 progress-striped">
                <div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width:70%">
                  <label>30% Progress</label>
                </div>
              </div>
            </div>
          </div>
        </div>
          <a href="javascript:void(0);" onclick="gotoright();" class="toogle-buttons right-to"> <i class="fa fa-chevron-right"></i></a> </div>
          
      <div class="col-sm-12 col-xs-12 col-md-8 main-content">
        <div class="dashbord-box video-box">
          <div class="video-box-header">
              <div class="now-playing pull-left"><i class="fa fa-play-circle"></i> Now Playing</div>
              <h4><?php echo $row_topic_video['TopicName']; ?></h4>
              <div class="next-playing pull-left"> <a href="#">Next Playing <i class="fa fa-play-circle"></i></a>
                  <div class="video-tooltip"><h4>Video Header</h4><img src="images/thumb_gallery.jpg" /></div>
              </div>
          </div>
          <div class="box-content">
<!--            <video poster="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.jpg" controls crossorigin> 
               Video files 
              <source src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.mp4" type="video/mp4">
              <source src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.webm" type="video/webm">
              
               Text track file 
              <track kind="captions" label="English" srclang="en" src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.en.vtt" default>
            </video>-->
            <?php if($CourseID!='') { ?>
                <?php if($row_topic_video['URL01Locked']=='1') { ?>
                    <iframe id="topic_iframe" width="795" height="446" src="<?php echo $row_topic_video['URL01']; ?>"></iframe>  
                <?php } ?>
            <?php } else { ?>               
                    <iframe width="100%" height="450" src="https://www.youtube.com/embed/dlJshzOv2cw"></iframe> 
            <?php } ?>
          </div>
        </div>
        <div class="portlet light bordered video-discriptions">
          <div class="portlet-title tabbable-line">
            
            <ul class="nav nav-tabs blue-tab">
                <li class="active"> <a href="#portlet_tab2_1" data-toggle="tab" aria-expanded="false"> <i class="fa fa-video-camera"></i>Video Discription</a> </li>
                <li class=""> <a href="javascript:void(0);" onclick="NextVideo('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" data-toggle="tab" aria-expanded="false"> <i class="fa fa-video-camera"></i> Refrences Video </a> </li>
                <?php if($TotalQuestion!='0') { ?>
                    <li class=""> <a href="javascript:void(0);" onclick="StartTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" data-toggle="tab" aria-expanded="true"><i class="fa fa-info-circle"></i> Next </a> </li>
                <?php } else { ?> 
                    <li class=""> <a href="javascript:void(0);" onclick="NoTest('<?php echo $TopicID; ?>','<?php echo $CourseID; ?>');" data-toggle="tab" aria-expanded="true"><i class="fa fa-info-circle"></i> Next </a> </li>
                <?php } ?>
                <li class=""> <a href="#portlet_tab2_4" data-toggle="tab" aria-expanded="true"><i class="fa fa-info-circle"></i> Faq </a> </li>
                <li class=""> <a href="#portlet_tab2_5" data-toggle="tab" aria-expanded="false"><i class="fa fa-file"></i> Documents </a> </li>
            </ul>
          </div>
          <div class="tab-content">
            <div id="portlet_tab2_1" class="tab-pane active">
            <div class="portlet-body form">
                <p><?php echo $row_topic_video['TopicDesc']; ?></p>
              </div>
            </div>
            <div id="portlet_tab2_3" class="tab-pane"> 
            <div class="portlet-body form">
                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
              </div>
            </div>
            <div class="tab-pane" id="portlet_tab2_4">
              <div class="portlet-body form">
                <?php if(mysql_num_rows($sql_faqs)!='0') { ?>  
                    <?php $a = 1; while($row_faqs = mysql_fetch_array($sql_faqs)) { ?>
                        <strong><?php echo $a; ?> : <?php echo $row_faqs['FAQ']; ?></strong> 
                        <p>Answer : <?php echo $row_faqs['FAQAnswer']; ?></p>
                    <?php $a++; } ?>
                <?php } else { ?>
                        <p> No FAQ'S </p>
                <?php } ?>
              </div>
            </div>
            <div id="portlet_tab2_5" class="tab-pane">
              <div class="portlet-body form">
                <?php if($row_topic_video['Doc01']=='' &&  $row_topic_video['Doc02']=='' && $row_topic_video['Doc03']=='' && $row_topic_video['Doc04']=='') { ?>
                    <p> No Documentation </p>
                <?php } else { ?>
                    <?php if($row_topic_video['Doc01']) { ?>
                        <a target="_blank" href="<?php echo $row_topic_video['Doc01']; ?>"><?php echo $row_topic_video['Doc01']; ?> </a> <br/><br/>
                    <?php } if($row_topic_video['Doc02']) { ?>
                        <a target="_blank" href="<?php echo $row_topic_video['Doc02']; ?>"><?php echo $row_topic_video['Doc02']; ?> </a> <br/><br/>
                    <?php  }if($row_topic_video['Doc03'])  { ?>
                        <a target="_blank" href="<?php echo $row_topic_video['Doc03']; ?>"><?php echo $row_topic_video['Doc03']; ?> </a> <br/><br/>
                    <?php } if($row_topic_video['Doc04']) { ?>
                        <a target="_blank" href="<?php echo $row_topic_video['Doc04']; ?>"><?php echo $row_topic_video['Doc04']; ?> </a> <br/><br/>
                    <?php } ?>
                <?php } ?>
              </div> 
            </div>
            <!-- END CONTENT BODY --> 
          </div>
          <!-- END CONTENT --> 
          
        </div>
      
      </div>
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

<script type="text/javascript">
function NoTest(TopicID,CourseID){
        var action = "no_test";
        var NextTopicID = $('#NextTopicID').val();
        var NextCourseID = $('#NextCourseID').val();
        var NextCourseTopicID = $('#NextCourseTopicID').val();
         $.ajax({
            method:'post',
            url:'<?php echo $RootPath; ?>action/student.php',
            data:{TopicID:TopicID,CourseID:CourseID,action:action,NextTopicID:NextTopicID,NextCourseID:NextCourseID},
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

<!-- Plyr core script --> 
<script src="<?php echo $RootPath; ?>js/plyr.js"></script> 

<!-- Docs script --> 
<script>plyr.setup();</script> 
<script type="text/javascript">
function gotoleft(){
    
                $('.left-side').toggleClass( "slide-left" );
		$('.left-to i').toggleClass( "fa-chevron-right" );
		$('.main-content').toggleClass( "expand-left" );
    
    }
        //$(".my-course").toggleClass("main");
		
function gotoright(){
                $('.right-side').toggleClass( "slide-right" );
		$('.main-content').toggleClass( "expand-right" );
		$('.right-to i').toggleClass( "fa-chevron-lefts" );
    
    }

</script>