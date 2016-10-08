<?php include('../../connection.php');
include('../../header_stud.php'); 
?>


<div class="middle-content student-dashbord-content">
<div class="container">
<div class="row">
<div class="col-sm-3 col-xs-12 col-md-2">
<div class="dashbord-box my-course">
<h2>My Course</h2>
<div class="box-content"></div>
</div>
</div>
<div class="col-sm-9 col-xs-12 col-md-10 no-padding-left">
<div class="row">
<div class="col-sm-9 col-xs-12 col-md-10">
    <div class="dashbord-box video-box" >
<h2>Video</h2>
<div class="box-content" style="max-width:100%;min-width:100%;  ">
<video poster="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.jpg" controls crossorigin style="max-width:100%;min-width:100%;  ">
                    <!-- Video files -->
                    <source src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.mp4" type="video/mp4">
                    <source src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.webm" type="video/webm">

                    <!-- Text track file -->
                    <track kind="captions" label="English" srclang="en" src="https://cdn.selz.com/plyr/1.5/View_From_A_Blue_Moon_Trailer-HD.en.vtt" default>

                   
                </video>
</div>
</div>


</div>
<div class="col-sm-3 col-xs-12 col-md-2 no-padding"><div class="dashbord-box my-course-progress">
<h2>Course Progress</h2>
<div class="box-content"></div>
</div></div>
</div>
<div class="student-buttons">
<a href="#">Video Discription</a>
<a href="#">Next Video</a>
<a href="#">Next Document</a>
<a href="#">Start Test</a>
<a href="#">Next Topic</a>
</div> 
<div class="video-discription">
<h4>Video Discription</h4>
</div>
</div>
</div>
</div>

</div>

<?php include('../../footer.php'); ?>