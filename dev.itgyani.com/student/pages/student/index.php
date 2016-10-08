<?php include('../../connection.php');

    if(isset($_SESSION['user_id'])) {
        header("location:".$RootPath."pages/student_dashboard");
        exit();
    }
?>

<?php include('../../header.php'); ?>

<div class="middle-content">
<div class="corporate-login-sect">
<div class="login-form">
<div class="form-area">
<img src="<?php echo $RootPath; ?>images/student-icon.svg" class="icons" />
<h2>Student login</h2>
<div class="social-login text-center"><label>Or sign in with</label><a href="fbconfig.php" class="facebook"><i class="fa fa-facebook"></i></a><a href="<?php echo $RootPath; ?>pages/student/process_new.php" class="google-plus"><i class="fa fa-linkedin"></i></a></div>

<h5 id="error_log" style="color:red; display:none;" >Please Check Your Username And Password</h5>
<h5 id="active_log" style="color:red; display:none;" >Please Activate Your Account</h5>

<form action="javascript:void(0);" method="post" id="stu_login_form" enctype="multipart/form-data"  >
<input type="hidden" name="action" id="action" value="login"  />
<input type="text" name="user_name" id="user_name"  placeholder="User Name" />
<input type="password" name="password" id="password" placeholder="Password" />
<input type="button" id="SignInUp"  value="Sign in" class="submit-button" />
<a class="forgot-button" href="<?php echo $RootPath; ?>pages/student/forgot_password.php">Forgot Password</a>


</form>
<div class="create-account-butt"><a href="<?php echo $RootPath; ?>pages/student/registration.php">Create Account Now</a></div>
</div>
<a class="blue-buttons" href="<?php echo $RootPath; ?>pages/pricing">Pricing</a>
</div>
</div>

<section class="browse-topics slider_one" style="position:relative;padding-top:44px;padding-bottom:66px">
    	<div class="container">
		
		<div class="row">
		<div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Plan your career.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Plan your career</h4> -->
			</div>
			<div class="back face center">
			<p>Foundation course to expose you to the world of IT career paths,  make informed decisions.</p>
			</div>
			</div>
		</div>
		</div>
	   
	  <div class="col-md-3 col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Learn on the move.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Learn on the move</h4> -->
			</div>
			<div class="back face center">
			<p>Your course takes off from.  Where you left off across pc, laptop,  and mobile.</p>
			</div>
			</div>
		 </div>
       </div>
	   
	    <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Job guarantee.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Job guarantee</h4> -->
			</div>
			<div class="back face center">
			<p>Entire program designed to get you your first job or assignment. 100% JOB GUARANTEE Launch offer read TnC</p>
			</div>
			</div>
		 </div>
        </div>
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Curated Content.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Curated content</h4> -->
			</div>
			<div class="back face center">
			<p>We go through thousands of videos to make your Playlist.</p>
			</div>
			</div>
		  </div>
        </div>
		</div>
		
		<div class="row" style="margin-top:20px">
		
	   <div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Knowledge transfer.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Knowledge transfer</h4> -->
			</div>
			<div class="back face center">
			<p>We test you to ensure that the content has been understood</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Personalized counselling.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Personalized counselling</h4> -->
			</div>
			<div class="back face center">
			<p>Based on your aptitude, behavioural skills, foundation training scores and market demand.</p>
			</div>
			</div>
		</div>
		</div>
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Unique Process.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Unique process</h4> -->
			</div>
			<div class="back face center">
			<p>Aptitude and Psychometric evaluation, Foundation courses, specialization based on  Personal Counselling, live environment training,etc.</p>
			</div>
			</div>
		 </div>
        </div>
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Psychometric evaluation.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Psychometric evaluation</h4> -->
			</div>
			<div class="back face center">
			<p>Our proprietary measuring tool BPCM, to measure skills and behavioural competencies with respect to the job profile</p>
			</div>
			</div>
		 </div>
		</div>
		
		</div>
		
		<div class="row" style="margin-top:20px">
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Live environment training.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Live environment training</h4> -->
			</div>
			<div class="back face center">
			<p>Apply your skills to projects. </p>
			</div>
			</div>
		 </div>
        </div>
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Campus Selection.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Campus selection</h4> -->
			</div>
			<div class="back face center">
			<p>You could land your job as soon as you graduate, because you would know more and be "floor ready"</p>
			</div>
			</div>
		 </div>
		</div>
		
		
		<div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/24 X 7 support.jpg" class="img-responsive">
			<!-- <h4 class="title_text">24 X 7 support</h4> -->
			</div>
			<div class="back face center">
			<p>Get answers to specific queries..  Even if not in dB your queries will be answered.</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 col-xs-8 col-xs-offset-2 col-sm-offset-0 padding_zero">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Softskill.jpg" class="img-responsive">
			<!-- <h4 class="title_text">24 X 7 support</h4> -->
			</div>
			<div class="back face center">
			<p> Soft skills training - Customized behavioral and language courses, all the way to interview prep.</p>
			</div>
			</div>
		 </div>
       </div>
		
		</div>
		</div>
	</section>


</div>
<script src="../../JsAjax/ITGStudent.js"></script>
<script src="../../js/bootbox.min.js"></script>
<script src="../../js/BrizBStandardJSPageStandardCodeGallery.js"></script>
<script type="text/javascript">

function LoginForm1(){
	var flag = true;
	
	if($('#user_name').val()==''){
		$('#user_name').css('border','1px solid red');
		flag = false;
	} else {
		$('#user_name').css('border','1px solid #c4dee7');
	}
	
	if($('#password').val()==''){
		$('#password').css('border','1px solid red');
		flag = false;
	} else {
		$('#password').css('border','1px solid #c4dee7');
	}
	
	if(flag==false){
		return false;
	} else {
		var datastring = $('#stu_login_form').serialize();
		$.ajax({
			method:'post',
			url:"<?php echo $RootPath; ?>action/student.php",
			data:datastring,
			success: function(resp){
				//alert(resp);
				if(resp=="0"){
					$('#error_log').show();
					$('#active_log').hide();
				} else if(resp=="1"){
					$('#active_log').show();
					$('#error_log').hide();
				} else if(resp=="2"){
					window.location.href = "<?php echo $RootPath; ?>pages/student_dashboard";
				}
			}
		});
	}
}
</script>

<?php include('../../footer.php'); ?>