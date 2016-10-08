<?php include('../../connection.php');

    if(isset($_SESSION['stud_id'])) {
        header("location:".$RootPath."pages/student/dashboard.php");
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
<div class="social-login text-center"><label>Or sign in with</label><a href="<?php echo $RootPath; ?>pages/student/facebook_login/fbconfig.php" class="facebook"><i class="fa fa-facebook"></i></a><a href="<?php echo $RootPath; ?>pages/student/process_new.php" class="google-plus"><i class="fa fa-linkedin"></i></a></div>

<h5 id="error_log" style="color:red; display:none;" >Please Check Your Username And Password</h5>
<h5 id="active_log" style="color:red; display:none;" >Please Activate Your Account</h5>

<form action="javascript:void(0);" method="post" id="stu_login_form" enctype="multipart/form-data"  >
<input type="hidden" name="action" id="action" value="login"  />
<input type="text" name="user_name" id="user_name"  placeholder="Email" />
<input type="password" name="password" id="password" placeholder="Password" />
<input type="button" onclick="LoginForm1();" value="Sign in" class="submit-button" />
<span><img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100" align="center" /></span>
<a class="forgot-button" href="<?php echo $RootPath; ?>pages/student/forgot_password.php">Forgot Password</a>


</form>
<div class="create-account-butt"><a href="<?php echo $RootPath; ?>pages/student/registration.php">Create Account Now</a></div>
</div>
<a class="blue-buttons" data-toggle="modal" data-target="#Pricing" href="javascript:void(0);">Pricing</a>
</div>
</div>


<div class="modal fade" id="Pricing" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      
      
      <div class="modal-body">
            <div class="pricing-section">
<div class="container">
<div class="black-box-pop" style="width:520px;" >
<div class="price-table">
<h2>The ITGYANI program - Get your first IT job.</h2>
<div class="table-responsive">
<table class="table">
<thead>
<tr>
<td></td><td class="text-center">Free</td><td class="text-center">10,000/-</td>
</tr>
</thead>
<tbody>
<tr ><td align="left">Aptitude Test</td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr>
<tr><td>Foundation Course</td><td>Partial</td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr>
<tr><td>Guarantee</td><td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr>
<tr><td>Counselling</td><td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr>
<tr><td>Trainer Access</td><td>Partial</td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr> 
<tr><td>Psychometric Evaluation</td><td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr>
<tr><td>Specialized Training Tests</td><td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr> 
<tr><td>Corporate Access</td><td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr> 
<tr><td>Interview Preparation</td><td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr> 
<tr><td>Live Environment Training</td><td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td><td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td></tr> 
</tbody>
<tfoot>
<tr>
    <td></td><td class="text-center"><a href="#">Join-free</a></td><td class="text-center"><a onclick="BuyNow();" href="javascript:void(0);">Buy Now</a></td>
</tr>
</tfoot>
</table>
</div>
<h2>Know What you love, Love What You Do!</h2>
</div>
<a href="javascript:void(0);" data-dismiss="modal" class="blue-buttons close-butt">Close</a>
</div>
</div>
</div>
      </div>
      
    </div>
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
			<img src="../../images/benefit.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Benefits</h4> -->
			</div>
			<div class="back face center">
			<p>The entire program designed to get you your first job or assignment.</p>
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
			<p>Aptitude and Psychometric evaluation, Foundation courses, specialization based on  Personal Counselling, live environment training, etc.</p>
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
			<p> Soft skills training - Customized behavioural and language courses, all the way to interview prep.</p>
			</div>
			</div>
		 </div>
       </div>
		
		</div>
		</div>
	</section>


</div>

<script type="text/javascript">
$(document).keypress(function(e) {
    if(e.which == 13) {
        LoginForm1();
    }
});
</script>

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
		$('#loader-img').show();
		var datastring = $('#stu_login_form').serialize();
		$.ajax({
			method:'post',
			url:"<?php echo $RootPath; ?>action/student.php",
			data:datastring,
			success: function(resp){
				$('#loader-img').hide();
				//alert(resp);
				if(resp=="0"){
					$('#error_log').show();
					$('#active_log').hide();
					window.location.href = "<?php echo $RootPath; ?>pages/student/registration.php";
				} else if(resp=="1"){
					$('#active_log').show();
					$('#error_log').hide();
				} else if(resp=="2"){
					window.location.href = "<?php echo $RootPath; ?>pages/student/dashboard.php";
				} else if(resp=="3"){
					window.location.href = "<?php echo $RootPath; ?>pages/student/dashboard.php?CourseID=<?php echo $_SESSION['LastCourseID']; ?>&TopicID=<?php echo $_SESSION['LastTopicID']; ?>";
				}
                                
			}
		});
	}
}
</script>

<?php include('../../footer.php'); ?>
<script type="text/javascript">
function BuyNow(){
    window.location.href = '<?php echo $RootPath; ?>pages/student/registration.php?buynow=1';
}    
</script>