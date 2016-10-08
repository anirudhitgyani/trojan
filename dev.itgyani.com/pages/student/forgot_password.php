<?php include('../../connection.php'); ?>
<?php include('../../header.php'); ?>

<div class="middle-content">
<div class="corporate-login-sect">
<div class="login-form">
<div class="form-area">
<img src="<?php echo $RootPath; ?>images/student-icon.svg" class="icons" />
<h2>Student Forgot Password</h2>

<h3 id="error_pass" style="color:red; display:none;" >Your Email Not Register Please Check </h3>
<h3 id="active_pass" style="color:green; display:none;" >Password Sent On Registered Mail_ID</h3>

<h3 id="error_email" style="color:red; display:none;" >Please Enter Valid Email</h3>


<form action="<?php echo $RootPath; ?>action/student.php" method="post" id="forgot_form" enctype="multipart/form-data"  >
<input type="hidden" name="action" id="action" value="forgot_password"  />
<input type="text" name="f_email" id="f_email" placeholder="Please Enter Your Email" />
<input type="button" onclick="StudentForgot();" id="reg_submit_button" value="Submit" class="submit-button" />

<a href="<?php echo $RootPath; ?>pages/student/" class="account-link">Login</a>

</form>
<div class="create-account-butt"><a href="<?php echo $RootPath; ?>pages/student/registration.php">Create Account Now</a></div>
</div>
<!--<a class="blue-buttons" href="<?php echo $RootPath; ?>pages/pricing">Pricing</a>-->
</div>
</div>

</div>

<script type="text/javascript">

function StudentForgot(){
	var flag = true;
	
	var emailstr = /^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	var email = $('#f_email').val();
	if(!email.match(emailstr) || email==''){
		$('#f_email').css('border','1px solid red');
		$('#error_email').show();
		flag = false;
	}else{
		$('#error_email').hide();
		$('#f_email').css('border','1px solid #dddddd');
	}
	
	if(flag==false){
		return false;
	} else {
		var datastring = $('#forgot_form').serialize();
		$('#reg_submit_button').val('Please Wait');
		$.ajax({
			method:'post',
			url:"<?php echo $RootPath; ?>action/student.php",
			data:datastring,
			success: function(resp){
				$('#reg_submit_button').val('SUBMIT');
				//alert(resp);
				if(resp=="0"){
					$('#error_pass').hide();
					$('#active_pass').show();
					$('#f_email').val('');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				} else if(resp=="1"){
					$('#active_pass').hide();
					$('#error_pass').show();
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}
			}
		});
	}
}
</script>

<?php include('../../footer.php'); ?>