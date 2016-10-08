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

<div class="span12">
      <div class="accordion-menu">
        <div class="accordion"> 
          <!-- Áreas -->
          <div class="accordion-group"> 
            <!-- Área -->
            <div class="accordion-heading area">
             <a class="accordion-toggle" data-toggle="collapse" href="#mainarea">Best Career Path - World of Information Technology</a> </div>
            <!-- /Área -->
            
            <div class="accordion-body collapse" id="mainarea">
              <div class="accordion-inner">
                <div class="accordion" id="mainmenu"> 
                  <!-- Equipamentos -->
                  
                  <div class="accordion-group">
                    <div class="accordion-heading equipamento"> 
                    <a class="accordion-toggle" data-parent="#mainmenu" data-toggle="collapse" 
                    	href="#submenu">Youth of Today - Career Guidance of Tomorrow</a>
                      <div class="accordion-body collapse" id="submenu">
                        <div class="accordion-inner">
                          <ul class="video-accordian">
                            <li>
								<a href="http://www.itgyani.com/pages/student/dashboard.php?CourseID=41&amp;TopicID=235"><img class="img-responsive" src="http://img.youtube.com/vi/KJyTwPR_hbU/0.jpg">
									<i class="fa fa-play-circle" aria-hidden="true"></i>
								</a>
								<div class="free1"><a href="">Free</a></div>
							</li>
                            <li>
								<a href="http://www.itgyani.com/pages/student/dashboard.php?CourseID=41&amp;TopicID=235"><img class="img-responsive" src="http://img.youtube.com/vi/KJyTwPR_hbU/0.jpg">
									<i class="fa fa-money" aria-hidden="true"></i>
								</a>
								<div class="paid1"><a href="">paid</a></div>
							</li>
                            <li><a href="http://www.itgyani.com/pages/student/dashboard.php?CourseID=41&amp;TopicID=235"><img class="img-responsive" src="http://img.youtube.com/vi/KJyTwPR_hbU/0.jpg"></a></li>
                          </ul>
                        </div>
                      </div>
                    </div>
                    <!-- submenus --> 
                    
                  <div class="accordion-group">
                    <div class="accordion-heading equipamento"> 
                    <a class="accordion-toggle" data-parent="#mainmenu" data-toggle="collapse" 
                    	href="#submenu2">Career as a Computer Animator</a>
                      <div class="accordion-body collapse" id="submenu2">
                        <div class="accordion-inner">
                         <ul class="video-accordian">
                            <li><a href="http://www.itgyani.com/pages/student/dashboard.php?CourseID=41&amp;TopicID=235"><img class="img-responsive"  src="http://img.youtube.com/vi/KJyTwPR_hbU/0.jpg"></a></li>
                            <li><a href="http://www.itgyani.com/pages/student/dashboard.php?CourseID=41&amp;TopicID=235"><img class="img-responsive" src="http://img.youtube.com/vi/KJyTwPR_hbU/0.jpg"></a></li>
                            <li><a href="http://www.itgyani.com/pages/student/dashboard.php?CourseID=41&amp;TopicID=235"><img class="img-responsive" src="http://img.youtube.com/vi/KJyTwPR_hbU/0.jpg"></a></li>
                          </ul>
                        </div>
                      </div>
                    </div>                    
                    
                    
                  <div class="accordion-group">
                    <div class="accordion-heading equipamento"> 
                    <a class="accordion-toggle" data-parent="#mainmenu" data-toggle="collapse" 
                    	href="#submenu3">Career as a Computer Programmer</a>
                      <div class="accordion-body collapse" id="submenu3">
                        <div class="accordion-inner">
                         <ul class="video-accordian">
                            <li><a href="http://www.itgyani.com/pages/student/dashboard.php?CourseID=41&amp;TopicID=235"><img class="img-responsive" src="http://img.youtube.com/vi/KJyTwPR_hbU/0.jpg"></a></li>
                            <li><a href="http://www.itgyani.com/pages/student/dashboard.php?CourseID=41&amp;TopicID=235"><img class="img-responsive" src="http://img.youtube.com/vi/KJyTwPR_hbU/0.jpg"></a></li>                          
                          </ul>
                        </div>
                      </div>
                    </div>                      
                  </div>
                  <!-- /Pontos --> 
                </div>
                <!-- /Equipamentos --> 
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- /accordion --> 
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


<?php include('../../footer.php'); ?>
