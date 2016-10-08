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

        <ul>
        <?php while($row_course=mysql_fetch_array($sql_course)) {
            
            $sql_topic = mysql_query("select * from `topic` where CourseID = '".$row_course['CourseID']."' ") or die(mysql_error());
        ?>
            <li><?php echo $row_course['CourseName']; ?></li>
            <ul>
            <?php while($row_topic = mysql_fetch_array($sql_topic)) { ?>
                <li><?php echo $row_topic['TopicName']; ?></li>
                <ul>
                <?php
                $sql_video = mysql_query("select * from `topic` where TopicID = '".$row_topic['TopicID']."' ") or die(mysql_error());
                $row_video = mysql_fetch_array($sql_video);
                
                                // Extract video url from embed code
                
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
                            <li><a href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID=<?php echo $row_course['CourseID']; ?>&TopicID=<?php echo $row_topic['TopicID']; ?>"><img height="100px" width="100px;" src="<?php echo $thumbURL; ?>" ></a></li>
                        <?php } ?>
                    <?php } else { ?>
                        <?php if($videoURL!='') { ?>
                            <?php if($videoLocked=='1') { ?>
                                <li><a href="<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID=<?php echo $row_course['CourseID']; ?>&TopicID=<?php echo $row_topic['TopicID']; ?>"><img height="100px" width="100px;" src="<?php echo $thumbURL; ?>" ></a></li>
                            <?php } else { ?>
                                <li><a href="<?php echo $RootPath; ?>pages/pricing/"><img height="100px" width="100px;" src="<?php echo $thumbURL; ?>" ><p>Locked</p></a></li>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>    
                    
                <?php } ?>
                </ul>
            <?php } ?>
            </ul>    
        <?php } ?>
        </ul>
</div> 
    
</div>
</div>

</div>
</div>
</div>

</div>




<?php include('../../footer.php'); ?>
