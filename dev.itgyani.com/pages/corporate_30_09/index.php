<?php include('../../connection.php');

     if(isset($_SESSION['ProfileID'])) {
        header("location:".$RootPath."pages/corporate/dashboard.php");
        exit();
    }
?>
<?php include('../../headerc.php'); ?>

<div class="middle-content">
<div class="corporate-login-sect">
<div class="login-form">
<div class="form-area">
<img src="<?php echo $RootPath; ?>images/corporate-icon.svg" class="icons" />
<h2>Corporate login</h2>
<div class="social-login text-center"><label>Or sign in with</label><a href="fbconfig.php" class="facebook"><i class="fa fa-facebook"></i></a><a href="#" class="google-plus"><i class="fa fa-linkedin"></i></a></div>

<h5 id="error_log" style="color:red; display:none;" >Please Check Your Username And Password</h5>
<h5 id="active_log" style="color:red; display:none;" >Please Activate Your Account</h5>

<form action="javascript:void(0);" method="post" id="cor_login_form" enctype="multipart/form-data"  >
<input type="hidden" name="action" id="action" value="login"  />
<input type="text" name="user_name" id="user_name"  placeholder="Email" />
<h5 id="error_email" style="color:red; display:none;" >Please Enter Valid Email</h5>
<input type="password" name="password" id="password" placeholder="Password" />
<input type="button" onclick="LoginForm();" value="Sign in" class="submit-button" />
<span><img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100" align="center" /></span>
<a class="forgot-button" href="<?php echo $RootPath; ?>pages/corporate/forgot_password.php">Forgot Password</a>


</form>
<div class="create-account-butt"><a href="<?php echo $RootPath; ?>pages/corporate/registration.php">Create Account Now</a></div>
</div>
<p class="blue-buttons">Get Floor Ready Candidates Here </p>
</div>
</div>
<section class="browse-topics slider_one" style="position:relative;padding-top:44px;padding-bottom:66px">
    	<div class="container">
		<div class="row">
		<div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Reduce TAT.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Reduce TAT</h4> -->
			</div>
			<div class="back face center">
			<p>Get "floor ready" candidates,  so they become billable in the shortest time</p>
			</div>
			</div>
		 </div>
        </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Dashboard.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Dashboard access</h4> -->
			</div>
			<div class="back face center">
			<p>Filter by course, %completed,  location,  marks,  etc.</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Customisation.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Customisation</h4> -->
			</div>
			<div class="back face center">
			<p>We could customise courses for your selected candidates, and block out other corporates from access to those profiles</p>
			</div>
			</div>
		</div>
       </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Cost savings.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Cost savings</h4> -->
			</div>
			<div class="back face center">
			<p>The Pre trained candidates ensure the costs to company before they get billable gets reduced by at least 70%.</p>
			</div>
			</div>
		</div>
       </div>
	   
		</div>
		
		<div class="row" style="margin-top:20px">
		 <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/24 X 7 support.jpg" class="img-responsive">
		<!-- 	<h4 class="title_text">27X7 support</h4> -->
			</div>
			<div class="back face center">
			<p>Reach out to us anytime and get a promo response</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Know your hire.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Know your hire</h4> -->
			</div>
			<div class="back face center">
			<p>Before you hire get complete profile with marks, test scores, psychometric evaluation,  skill sets, etc.</p>
			</div>
			</div>
		 </div>
       </div>
	   
	   <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/Niche skills.jpg" class="img-responsive">
			<!-- <h4 class="title_text">Cost savings</h4> -->
			</div>
			<div class="back face center">
			<p>The candidates are trained in niche technology stacks to meet your requirements.</p>
			</div>
			</div>
		</div>
       </div>
	   
	    <div class="col-sm-3 padding_zero col-xs-8 col-xs-offset-2 col-sm-offset-0">
		 <div id="f1_container">
			<div id="f1_card" class="shadow">
			<div class="front face">
			<img src="../../images/360-trained-grads.jpg" class="img-responsive">
		<!-- 	<h4 class="title_text">27X7 support</h4> -->
			</div>
			<div class="back face center">
			<p>Complete with technical, soft skills and behavioural training</p>
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
        LoginForm();
    }
});
</script>

<script type="text/javascript">
function LoginForm(){
	var flag = true;
	
	/*if($('#user_name').val()==''){
		$('#user_name').css('border','1px solid red');
		flag = false;
	} else {
		$('#user_name').css('border','1px solid #c4dee7');
	}*/
	
	var emailstr = /^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	var email = $('#user_name').val();
	if(!email.match(emailstr) || email==''){
		$('#user_name').css('border','1px solid red');
		$('#error_email').show();
		flag = false;
	}else{
		$('#user_name').css('border','1px solid #dddddd');
		$('#error_email').hide();
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
		var datastring = $('#cor_login_form').serialize();
		$('#loader-img').show();
		$.ajax({
			method:'post',
			url:"<?php echo $RootPath; ?>action/corporate.php",
			data:datastring,
			success: function(resp){
				//alert(resp);
				$('#loader-img').hide();
				if(resp=="0"){
					$('#error_log').show();
					$('#active_log').hide();
					window.location.href = "<?php echo $RootPath; ?>pages/corporate/registration.php";
				} else if(resp=="1"){
					$('#active_log').show();
					$('#error_log').hide();
				} else if(resp=="2"){
					window.location.href = "<?php echo $RootPath; ?>pages/corporate/dashboard.php";
				}
			}
		});
	}
}
</script>

<?php include('../../footer.php'); ?>