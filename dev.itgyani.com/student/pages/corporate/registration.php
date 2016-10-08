<?php include('../../connection.php'); ?>
<?php include('../../header.php'); ?>


<div class="middle-content">
<div class="registration-section">
<div class="container">
<div class="white-box-pop text-center">

<h3 id="error_reg" style="color:red; display:none;" >Username Or Email Already Register</h3>
<h3 id="active_reg" style="color:green; display:none;" >Register Successfully Check Your Email</h3>

  

<h2>Get Floor Ready Candidates Here </h2>
<div class="register-form">
<form action="javascript:void(0);" method="post" id="cor_regi_form" enctype="multipart/form-data" >

<input type="hidden" name="action" id="action" value="insert"  />
<div class="form-group"><label>Username: </label><input name="user_name" id="user_name"  type="text" class="form-input" onblur="if($('#user_name').val()=='') { $('#user_name').css('border','1px solid red'); } else { $('#user_name').css('border','1px solid #c4dee7'); }" /></div>
<div class="form-group"><label>First Name: </label><input name="first_name" id="first_name" type="text" class="form-input" onblur="if($('#first_name').val()=='') { $('#first_name').css('border','1px solid red'); } else { $('#first_name').css('border','1px solid #c4dee7'); }" /></div>
<div class="form-group"><label>Last Name: </label><input name="last_name" id="last_name" type="text" class="form-input" onblur="if($('#last_name').val()=='') { $('#last_name').css('border','1px solid red'); } else { $('#last_name').css('border','1px solid #c4dee7'); }"  /></div>
<div class="form-group"><label>Company Name: </label><input name="company_name" id="company_name" type="text" class="form-input" onblur="if($('#company_name').val()=='') { $('#company_name').css('border','1px solid red'); } else { $('#company_name').css('border','1px solid #c4dee7'); }" /></div>
<div class="form-group"><label>Mobile: </label><input name="mobile" id="mobile" type="text" class="form-input" onblur="if($('#mobile').val()=='') { $('#mobile').css('border','1px solid red'); } else { $('#mobile').css('border','1px solid #c4dee7'); }" /></div>
<div class="form-group"><label>DOB: </label><input name="dateofbirth" id="dateofbirth" type="text" class="form-input" onblur="if($('#dateofbirth').val()=='') { $('#dateofbirth').css('border','1px solid red'); } else { $('#dateofbirth').css('border','1px solid #c4dee7'); }" /></div>


<div class="form-group"><label>Gender: </label><input name="gender" checked="checked" id="gender1" type="radio" value="Male" /> Male <input name="gender" id="gender1" type="radio"  value="Female" /> Female </div>




<div class="form-group"><label>Corporate Email-id: </label><input name="email" id="email" type="text" class="form-input" onblur="if($('#email').val()=='') { $('#email').css('border','1px solid red'); } else { $('#email').css('border','1px solid #c4dee7'); }" /></div>
<h5 id="error_email" style="color:red; display:none;" >Please Enter Valid Email</h5>
<div class="form-group"><label>Password: </label><input name="password" id="password" type="password" class="form-input" onblur="if($('#password').val()=='') { $('#password').css('border','1px solid red'); } else { $('#password').css('border','1px solid #c4dee7'); }" /></div>
<h5 id="error_pass" style="color:red; display:none;" >Please Enter Minimum 6 Character</h5>
<h5 id="error_pass_reg" style="color:red; display:none;" >Please Enter Any Special Character like '%' '$' '*' </h5>

</form>
</div>
<input type="button" onclick="RegisterForm();" class="blue-buttons submit-button" value="Submit" />
<a href="#" class="blue-buttons close-butt">Close</a>

</div>
</div>

</div>
</div>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
  <script>
  $( function() {
    //$( "#dateofbirth" ).datepicker();
	    $( "#dateofbirth" ).datepicker({
			changeMonth: true,
      		changeYear: true,
	  		yearRange: "1950:<?php echo date('Y'); ?>"
    	});
  } );
  </script>

<script type="text/javascript">
function RegisterForm(){
	var flag = true;
	
	if($('#user_name').val()==''){
		$('#user_name').css('border','1px solid red');
		flag = false;
	} else {
		$('#user_name').css('border','1px solid #c4dee7');
	}
	
	if($('#first_name').val()==''){
		$('#first_name').css('border','1px solid red');
		flag = false;
	} else {
		$('#first_name').css('border','1px solid #c4dee7');
	}
	
	if($('#last_name').val()==''){
		$('#last_name').css('border','1px solid red');
		flag = false;
	} else {
		$('#last_name').css('border','1px solid #c4dee7');
	}
	
	if($('#company_name').val()==''){
		$('#company_name').css('border','1px solid red');
		flag = false;
	} else {
		$('#company_name').css('border','1px solid #c4dee7');
	}
	
	if($('#mobile').val()==''){
		$('#mobile').css('border','1px solid red');
		flag = false;
	} else {
		$('#mobile').css('border','1px solid #c4dee7');
	}
	
	if($('#dateofbirth').val()==''){
		$('#dateofbirth').css('border','1px solid red');
		flag = false;
	} else {
		$('#dateofbirth').css('border','1px solid #c4dee7');
	}
	
	var emailstr = /^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	var email = $('#email').val();
	if(!email.match(emailstr) || email==''){
		$('#email').css('border','1px solid red');
		$('#error_email').show();
		flag = false;
	}else{
		$('#email').css('border','1px solid #dddddd');
		$('#error_email').hide();
	}
	
	var password = $('#password').val();
	if($('#password').val()==''){
		$('#password').css('border','1px solid red');
		flag = false;
	} else {
                var passlen = $("#password").val().length;
                if(passlen < 6){
                    $('#password').css('border','1px solid red');
                    $('#error_pass').show();
                    $('#error_pass_reg').hide();
                    flag = false;
                } else {
                    var spchar = /[,(){}\[\]\-+*%\/="'~!&|<>?:;.$@# ]/;;
                    if(!password.match(spchar)) {
                        $('#password').css('border','1px solid red');
                        $('#error_pass_reg').show();
                        $('#error_pass').hide();
                        flag = false;
                    } else {
                        $('#error_pass').hide();
                        $('#error_pass_reg').hide();
                        $('#password').css('border','1px solid #c4dee7');
                    }
                }
	}
	
	
	if(flag==false){
		return false;
	} else {
		
		var datastring = $('#cor_regi_form').serialize();
		$('#reg_submit_button').val('Please Wait');
		$.ajax({
			method:'post',
			url:"<?php echo $RootPath; ?>action/corporate.php",
			data:datastring,
			success: function(resp){
				$('#reg_submit_button').val('SUBMIT');
				//alert(resp);
				if(resp=="0"){
					$('#error_reg').hide();
					$('#active_reg').show();
					$('#user_name').val('');
					$('#first_name').val('');
					$('#last_name').val('');
					$('#mobile').val('');
					$('#dateofbirth').val('');
					$('#email').val('');
					$('#password').val('');
					$('#company_name').val('');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				} else if(resp=="1"){
					$('#active_reg').hide();
					$('#error_reg').show();
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}
			}
		});
	}
}
</script>

<?php include('../../footer.php'); ?>