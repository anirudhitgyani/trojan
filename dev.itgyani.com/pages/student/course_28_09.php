<?php include('../../connection.php');

	if(!isset($_SESSION['stud_id'])) {
		header("location:".$RootPath);
		exit();
	}
include('../../header_stud.php');

$sql_course = mysql_query("select * from `course` ") or die(mysql_error());

?>

<div id="heading" class="middle-content hr-dashbord-content">
	<div class="container">
		<div class="row-fluid dashbord-row">
			<div class="col-sm-12 col-xs-12 col-md-12 no-padding-right right-col">

				<div class="student-profile-section grey-box">
					<div class="student-titles pull-left text-right"><small>All Courses</small></div>


					<div class="row-fluid student-profile-row">
						<div class="col-sm-10 col-md-10 col-xs-12">

<?php while($row_course=mysql_fetch_array($sql_course)) { 
    $sql_topic = mysql_query("select * from `topic` where CourseID = '".$row_course['CourseID']."' ") or die(mysql_error());
    ?>                                                    
<div class="span12">
      <div class="accordion-menu">
        <div class="accordion"> 
          <!-- Ã?reas -->
          <div class="accordion-group"> 
            <!-- Ã?rea -->
            <div class="accordion-heading area">
             <a class="accordion-toggle" data-toggle="collapse" href="#mainarea_<?php echo $row_course['CourseID']; ?>"><?php echo $row_course['CourseName']; ?></a> </div>
            <!-- /Ã?rea -->
            
            <div class="accordion-body collapse" id="mainarea_<?php echo $row_course['CourseID']; ?>">
              <div class="accordion-inner">
                <?php while($row_topic = mysql_fetch_array($sql_topic)) { 
                $sql_video = mysql_query("select * from `topic` where TopicID = '".$row_topic['TopicID']."' ") or die(mysql_error());
                $row_video = mysql_fetch_array($sql_video);
                
                               ?>
                  <div class="accordion" id="mainmenu_<?php echo $row_topic['TopicID']; ?>"> 
                  <!-- Equipamentos -->
                  
                  <div class="accordion-group">
                    <div class="accordion-heading equipamento"> 
                    <a class="accordion-toggle" data-parent="#mainmenu_<?php echo $row_topic['TopicID']; ?>" data-toggle="collapse" 
                    	href="#submenu_<?php echo $row_topic['TopicID']; ?>"><?php echo $row_topic['TopicName']; ?></a>
                      <div class="accordion-body collapse" id="submenu_<?php echo $row_topic['TopicID']; ?>"> 
                        <div class="accordion-inner">
                          <ul class="video-accordian">
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
                    $thumbURL = 'http://img.youtube.com/vi/'.$youtubeVideoId.'/0.jpg';
                              
                              ?>
                              
                    <?php if($row_user['IsPaid']=='1') { ?>
                        <?php if($videoURL!='') { ?>
                            <li><a href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID=<?php echo $row_course['CourseID']; ?>&TopicID=<?php echo $row_topic['TopicID']; ?>"><img class="img-responsive" src="<?php echo $thumbURL; ?>" ></a></li>
                        <?php } ?>
                    <?php } else { ?>
                        <?php if($videoURL!='') { ?>
                            <?php if($videoLocked=='1') { ?>
                                <li><a href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID=<?php echo $row_course['CourseID']; ?>&TopicID=<?php echo $row_topic['TopicID']; ?>"><img class="img-responsive" src="<?php echo $thumbURL; ?>" ></a></li>
                            <?php } else { ?>
                                <li><a href="<?php echo $RootPath; ?>pages/pricing/"><img class="img-responsive" src="<?php echo $thumbURL; ?>" ><p>Locked</p></a></li>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>    
                                
                    <?php } ?>            
                              
                          </ul>
                        </div>
                      </div>
                    </div>
                    <!-- submenus --> 
                    
                 
                <!-- /Equipamentos --> 
              </div>
            </div>
                <?php } ?>  
          </div>
        </div>
      </div>
      <!-- /accordion --> 
    </div>
  </div>
</div>						
		
<?php } ?>                                                    
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


<?php include('../../footer.php'); ?>
