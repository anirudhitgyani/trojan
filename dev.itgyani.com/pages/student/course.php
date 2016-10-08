<?php include('../../connection.php');

	if(!isset($_SESSION['stud_id'])) {
		header("location:".$RootPath);
		exit();
	}
include('../../header_stud.php');
$CourseID = $_REQUEST['CourseID'];
$sql_course = mysql_query("select * from `course` where CourseID = '".$CourseID."' ") or die(mysql_error());
$row_course = mysql_fetch_array($sql_course);
$sql_course_redirect = mysql_query("select * from `course` order by CourseID limit 0,1 ") or die(mysql_error());
$row_course_redirect = mysql_fetch_array($sql_course_redirect);

$sql_course_1 = mysql_query("select * from `course` ") or die(mysql_error());
$sql_topic = mysql_query("select * from `topic` where CourseID = '".$CourseID."' ") or die(mysql_error());


$sql_topic_redirect = mysql_query("select * from `topic` where CourseID = '".$CourseID."' order by CourseID asc limit 0,1 ") or die(mysql_error());
$row_topic_redirect = mysql_fetch_array($sql_topic_redirect);
        
?>





<div class="middle-content student-dashbord-content">
  <div class="container-fluid">
    <div class="row">
      <div class="col-sm-12 col-xs-12 col-md-2 left-side no-padding-left">
        <div class="dashbord-box my-course side">
          <h2><i class="fa fa-info-circle"></i>My Course</h2>
          <div class="box-content">
          <nav>
            <ul class="nav">
                <?php while($row_course_1 = mysql_fetch_array($sql_course_1)) {  ?>  
                <li>
                    <a href="<?php echo $RootPath; ?>pages/student/course.php?CourseID=<?php echo $row_course_1['CourseID']; ?>">
                        <?php if($row_course_1['CourseID']==$CourseID) { ?> 
                            <i class="fa fa-check-circle c-blue"></i> 
                        <?php } else { ?> 
                            <i class="fa fa-check-circle"></i> 
                        <?php } ?> 
                            <?php echo $row_course_1['CourseName']; ?>
                    </a>
                </li>
                <?php } ?>
              </ul>
          </nav>
          </div>
        </div>
        <a href="javascript:void(0);" onclick="gotoleft();" class="toogle-buttons left-to"> <i class="fa fa-chevron-left"></i></a>
      </div>
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
        <a href="javascript:void(0);" onclick="gotoright();" class="toogle-buttons right-to"> <i class="fa fa-chevron-right"></i></a>
      </div>
      <div class="col-sm-12 col-xs-12 col-md-8 main-content">
       
            
            
            
            <div class="dashbord-box-content">
            <h4 class="dash-title">WELCOME AT MY COURSE</h4> 
            <div class="dashbord-box-dis dashbord-content">
           
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h4 class="panel-title"> 
                  <span><i class="fa fa-play-circle-o" aria-hidden="true"></i> <?php echo $row_course['CourseName']; ?> </span>
                  <div class="pull-right"><div class="pull-left course-info">
                  <span><i class="fa fa-info-circle"></i> Cource Information </span><div class="tootltips"><p>Status: 20% overall</p>
                  <p>Status: 20% overall</p>
                  <p>Status: 20% overall</p>
                  <p>Status: 20% overall</p></div></div>
                  <a class="accordion-toggle pull-right" data-toggle="collapse" data-parent="#accordion" href="#collapse1"><i class="fa fa-plus"></i></a>
                  </div>
                   
                  </h4>
                </div>
                <div id="collapse1" class="panel-collapse collapse in">
                  <div class="panel-body grey-back">
                    <div class="panel-group" id="accordion1">
                      <?php $i=0; while($row_topic = mysql_fetch_array($sql_topic)) { ?> 
                        <?php if($row_topic['TopicName']!='') { 
                            $sql_video = mysql_query("select * from `topic` where TopicID = '".$row_topic['TopicID']."' ") or die(mysql_error());
                            $row_video = mysql_fetch_array($sql_video);  

                            $sql_test_result = mysql_query("select * from `test_detail` where ProfileID = '".$_SESSION['stud_id']."' AND CourseID = '".$row_course['CourseID']."' AND TopicID = '".$row_topic['TopicID']."' ") or die(mysql_error());
                            $row_test_result = mysql_fetch_array($sql_test_result);
                            $total_test_result = mysql_num_rows($sql_test_result);

                            $NextTopicID = $row_test_result['NextTopicID'];

                            $sql_test_1 = mysql_query("select * from `QuestionSet` where TopicID = '".$TopicID."' ");
                            $TotalQuestion = mysql_num_rows($sql_test_1); 
                            
                        ?>
                        <div class="panel panel-default">
                        <div class="panel-heading color">
                          <h4 class="panel-title"> <span><?php echo $row_topic['TopicName']; ?> </span><a class="accordion-toggle pull-right" data-toggle="collapse" data-parent="#accordion1" href="#collapse<?php echo $row_topic['TopicID']; ?>"><i class="fa fa-plus"></i></a> </h4>
                        </div>
                        <div id="collapse<?php echo $row_topic['TopicID']; ?>" <?php if($i==0) { ?> class="panel-collapse collapse in" <?php } else { ?> class="panel-collapse collapse" <?php } ?> >
                          <div class="panel-body">
                          <div class="progress progress-striped">
    							<div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:70%">
      								</div>
 						 </div>
                            <div class="row">
                              <?php 
                              
                              
                for($a=0;$a<4;$a++){
                    if($a==0){
                        $videoURL = $row_video['URL01'];
                        $videoLocked = $row_video['URL01Locked'];
                    } else if($a==1){
                        $videoURL = $row_video['URL02'];
                        $videoLocked = $row_video['URL02Locked'];
                    } else if($a==2){
                        $videoURL = $row_video['URL03'];
                        $videoLocked = $row_video['URL03Locked'];
                    } else if($a==3){
                        $videoURL = $row_video['URL04'];
                        $videoLocked = $row_video['URL04Locked'];
                    } 
                    
                    $urlArr = explode("/",$videoURL);
                    $urlArrNum = count($urlArr);

                    // YouTube video ID
                    $youtubeVideoId = $urlArr[$urlArrNum - 1]; 

                    // Generate youtube thumbnail url
                    $thumbURL = 'http://img.youtube.com/vi/'.$youtubeVideoId.'/0.jpg'; ?>
                            
                    <?php if($row_user['IsPaid']=='1') { ?>
                        <?php if($videoURL!='') { ?>
                            <div class="col-md-3 col-sm-3 col-xs-6">
                                <div class="course-video-box">
                                    <span> </span>
                                        <img src="<?php echo $thumbURL; ?>" style="max-width: 100%;">
                                    <div class="video-status"><a href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID=<?php echo $row_course['CourseID']; ?>&TopicID=<?php echo $row_topic_redirect['TopicID']; ?>"><i class="fa fa-play-circle"></i> Now Running</a></div>
                                </div>
                            </div>
                        <?php } ?>
                    <?php } else { ?>
                        <?php if($videoURL!='') { ?>
                            <?php if($videoLocked=='1') { ?>
                                    <div class="col-md-3 col-sm-3 col-xs-6">
                                        <div class="course-video-box">
                                            <span> Free </span>
                                                <img src="<?php echo $thumbURL; ?>" style="max-width: 100%;">
                                            <div class="video-status"><a href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID=<?php echo $row_course['CourseID']; ?>&TopicID=<?php echo $row_topic_redirect['TopicID']; ?>"><i class="fa fa-play-circle"></i> Now Running</a></div>
                                        </div>
                                    </div>
                            <?php } else { ?>
                                <div class="col-md-3 col-sm-3 col-xs-6">
                                    <div class="course-video-box">
                                        <span> Upgrade </span>
                                            <img src="<?php echo $thumbURL; ?>" style="max-width: 100%;">
                                        <div class="video-status"><a href="<?php echo $RootPath; ?>pages/pricing/"><i class="fa fa-play-circle"></i> Now Running</a></div>
                                    </div>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>  
                                
                                
                                
                                
                                
                <?php } ?>          
                            </div>
<!--                              <div class="text"> <h4>RECOMMEND FOR ADVANCE VERSION</h4></div>
                              <div class="row">
                               <div class="col-md-3 col-sm-3 col-xs-6">
                              <div class="course-video-box">
                              <span> Heading Video</span>
                              <img src="<?php echo $RootPath; ?>images/thumb_gallery.jpg" style="max-width: 100%;">
                              <div class="video-status"><a href="#"><i class="fa fa-play-circle"></i> Now Running</a></div>
                              </div>
                              </div>
                              <div class="col-md-3 col-sm-3 col-xs-6">
                              <div class="course-video-box">
                              <span> Heading Video</span>
                              <img src="<?php echo $RootPath; ?>images/thumb_gallery.jpg" style="max-width: 100%;">
                              <div class="video-status"><a href="#"><i class="fa fa-play-circle"></i> Next Video</a></div>
                              <div class="video-overlay"><a href="#"><i class="fa fa-play-circle-o" aria-hidden="true"></i></a></div>
                              </div>
                              </div>
                              <div class="col-md-3 col-sm-3 col-xs-6">
                              <div class="course-video-box">
                              <span> Heading Video</span>
                              <img src="<?php echo $RootPath; ?>images/thumb_gallery.jpg" style="max-width: 100%;">
                              <div class="video-status"><a href="#"><i class="fa fa-play-circle"></i> Watched</a></div>
                              <div class="video-overlay"><a href="#"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></a></div>
                              </div>
                              </div>
                              <div class="col-md-3 col-sm-3 col-xs-6">
                              <div class="course-video-box">
                              <span> Heading Video</span>
                              <img src="<?php echo $RootPath; ?>images/thumb_gallery.jpg" style="max-width: 100%;">
                              <div class="video-status"><a href="#"><i class="fa fa-play-circle"></i> Watched</a></div>
                              <div class="video-overlay"><a href="#"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></a></div>
                              </div>
                              </div>
                            </div>-->
                          </div>
                        </div>
                      </div>
                        <?php } ?>
                      <?php $i++; } ?>   
                    </div>
                  </div>
                </div>
              </div>
              </div>
              </div>
              
      
      </div>
      
    </div>
  </div>
</div>

<script>
var acc = document.getElementsByClassName("accordion-heading");
var i;

for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        this.classList.toggle("active");
        this.nextElementSibling.classList.toggle("show");
  }
}
</script>



<script type="text/javascript">

function toggle_visibility(id) 
{
    var e = document.getElementById(id);
    if (e.style.display == 'block' || e.style.display=='')
    {
        e.style.display = 'none';
    }
    else 
    {
        e.style.display = 'block';
    }
}

</script>

<script>

$('.collapse').on('shown.bs.collapse', function(){
$(this).parent().find(".glyphicon-plus").removeClass("glyphicon-plus").addClass("glyphicon-minus");
}).on('hidden.bs.collapse', function(){
$(this).parent().find(".glyphicon-minus").removeClass("glyphicon-minus").addClass("glyphicon-plus");
});

</script>

<script type="text/javascript">
function gotoleft(){
    
                $('.left-side').toggleClass( "slide-left" );
		$('.left-to i').toggleClass( "fa-chevron-right" );
		$('.main-content').toggleClass( "expand-left" );
                gotoright();
    
    }
        //$(".my-course").toggleClass("main");
		
function gotoright(){
                $('.right-side').toggleClass( "slide-right" );
		$('.main-content').toggleClass( "expand-right" );
		$('.right-to i').toggleClass( "fa-chevron-lefts" );
                gotoleft();
    
    }

</script>

<?php include('../../footer.php'); ?>
