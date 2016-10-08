<?php include('../../connection.php'); ?>
<?php include('../../header.php'); ?>


<div class="middle-content">
<div class="registration-section">
<!--<div class="container">
<div class="white-box-pop text-center">

<h3 id="error_reg" style="color:red; display:none;" >Username Or Email Already Register</h3>
<h3 id="active_reg" style="color:green; display:none;" >"Registered Successfully! Please Check Your Email for Instruction."</h3>

  

<h2>Look's Like You Are Not Registered with ITGYANI  </h2>
<div class="register-form">
<form action="javascript:void(0);" method="post" id="cor_regi_form" enctype="multipart/form-data" >

<input type="hidden" name="action" id="action" value="insert"  />
<input type="hidden" name="buynow" id="buynow" value="<?php echo $_REQUEST['buynow']; ?>"  />

<div class="form-group"><label>Username: </label>
<input name="user_name" id="user_name"  type="text" class="form-input" onblur="if($('#user_name').val()=='') { $('#user_name').css('border','1px solid red'); } else { $('#user_name').css('border','1px solid #c4dee7'); }"  /></div>
<h5 id="error_username" style="color:red; display:none;" >Please Enter Only Text And Special Character Not Number</h5>

<div class="form-group"><label>Student Email-id:<span style="color:red">*</span></label><input name="email" id="email" type="text" class="form-input" onblur="if($('#email').val()=='') { $('#email').css('border','1px solid red'); } else { $('#email').css('border','1px solid #c4dee7'); }" value="<?php if(isset($_SESSION['ProfileEmail'])) { echo $_SESSION['ProfileEmail']; } unset($_SESSION['ProfileEmail']); ?>" /></div>
<h5 id="error_email" style="color:red; display:none;" >Please Enter Valid Email</h5>

<div class="row"><div class="col-sm-6 col-xs-12 col-md-6">
<div class="form-group"><label>First Name:<span style="color:red">*</span> </label><input name="first_name" id="first_name" type="text" class="form-input" onblur="if($('#first_name').val()=='') { $('#first_name').css('border','1px solid red'); } else { $('#first_name').css('border','1px solid #c4dee7'); }" /></div>
<h5 id="error_first_name" style="color:red; display:none;" >Please Enter Only Text</h5></div><div class="col-sm-6 col-xs-12 col-md-6">

<div class="form-group"><label>Last Name:<span style="color:red">*</span> </label><input name="last_name" id="last_name" type="text" class="form-input" onblur="if($('#last_name').val()=='') { $('#last_name').css('border','1px solid red'); } else { $('#last_name').css('border','1px solid #c4dee7'); }"  /></div>
<h5 id="error_last_name" style="color:red; display:none;" >Please Enter Only Text</h5></div></div>

<div class="form-group"><label>Mobile: </label><input maxlength="10" name="mobile" id="mobile" type="text" class="form-input" onblur="if($('#mobile').val()=='') { $('#mobile').css('border','1px solid red'); } else { $('#mobile').css('border','1px solid #c4dee7'); }" /></div>
<h5 id="error_mobile" style="color:red; display:none;" >Please Enter Valid Mobile Number Only Numeric Digits AND Enter 10 Digits </h5>

<div class="form-group"><label>DOB: </label><input name="dateofbirth" id="dateofbirth" type="text" class="form-input dob-input" placeholder="DD/MM/YY"  onblur="if($('#dateofbirth').val()=='') { $('#dateofbirth').css('border','1px solid red'); } else { $('#dateofbirth').css('border','1px solid #c4dee7'); }" /></div>


<div class="form-group" style="float:left" ><label>Gender: </label><input name="gender" checked="checked" id="gender1" type="radio" value="Male" /> Male <input name="gender" id="gender1" type="radio"  value="Female" /> Female </div>


<div class="form-group"><label>Password:<span style="color:red">*</span> </label><input name="password" id="password" type="password" class="form-input" onblur="if($('#password').val()=='') { $('#password').css('border','1px solid red'); } else { $('#password').css('border','1px solid #c4dee7'); }" value="<?php if(isset($_SESSION['ProfilePassword'])) { echo $_SESSION['ProfilePassword']; } unset($_SESSION['ProfilePassword']); ?>" /></div>
<h5 id="error_pass" style="color:red; display:none;" >Please Enter Minimum 6 Character</h5>
<h5 id="error_pass_reg" style="color:red; display:none;" >Please Enter Any Special Character like '%' '$' '*' </h5>

<div class="form-group"><label> Confirm Password:<span style="color:red">*</span> </label><input name="confirm_password" id="confirm_password" type="password" class="form-input" onblur="if($('#confirm_password').val()=='') { $('#confirm_password').css('border','1px solid red'); } else { $('#confirm_password').css('border','1px solid #c4dee7'); }" value="" /></div>
<h5 id="error_con_pass" style="color:red; display:none;" >Password and Confirm Password Not Same...</h5>


<div class="form-group"><span id="captcha_code"><?php echo rand('0000','9999'); ?></span></div>
<div class="form-group"><label> Captcha Code </label><input name="captcha" id="captcha" type="text" class="form-input" /></div>

</form>
</div>
<input type="button" id="reg_submit_button" onclick="RegisterForm1();" class="blue-buttons submit-button" value="Submit" />

<img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100" align="center" />
 
<a href="#" class="blue-buttons close-butt">Close</a>

</div>
</div>-->


<div class="container">    
        <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-9 col-md-offset-2 col-sm-8 col-sm-offset-2">                    
            <div class="panel panel-info" >
                    <div class="panel-heading">
                        <div class="panel-title text-center formtitle">Student Registration</div>
                        
                    </div>     

                    <div style="padding-top:30px" class="panel-body" >

                        <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>

                        <h3 id="error_reg" style="color:red; display:none;" >Username Or Email Already Register</h3>
                        <h3 id="active_reg" style="color:green; display:none;" >"Registered Successfully! Please Check Your Email for Instruction."</h3>

                        
                        <form id="cor_regi_form" method="post" action="javascript:void(0);" class="form-horizontal" role="form">
                            
                            <input type="hidden" name="action" id="action" value="insert"  />
                            <input type="hidden" name="buynow" id="buynow" value="<?php echo $_REQUEST['buynow']; ?>"  />
                            
                            <div class="col-md-6">
                                <div id="formtext1" style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-envelope" aria-hidden="true"></i></span>
                                    <input id="email" type="text" class="form-control" name="email" value="" placeholder="Email" onblur="if($('#email').val()=='') { $('#email').css('border','1px solid red'); } else { $('#email').css('border','1px solid #ccc'); }" value="<?php if(isset($_SESSION['ProfileEmail'])) { echo $_SESSION['ProfileEmail']; } unset($_SESSION['ProfileEmail']); ?>" >
                                </div>
                                
                                <div id="formtext1" style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-user" aria-hidden="true"></i></span>
                                    <input id="first_name" type="text" class="form-control" name="first_name" placeholder="First Name" onblur="if($('#first_name').val()=='') { $('#first_name').css('border','1px solid red'); } else { $('#first_name').css('border','1px solid #ccc'); }"  >
                                </div>
                                
                                
                                <div id="formtext1" style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-user" aria-hidden="true"></i></span>
                                    <input id="last_name" type="text" class="form-control" name="last_name" placeholder="Last Name" onblur="if($('#last_name').val()=='') { $('#last_name').css('border','1px solid red'); } else { $('#last_name').css('border','1px solid #ccc'); }"  >
                                </div>
                                
                                
                                <div id="formtext1" style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-phone" aria-hidden="true"></i></span>
                                    <input id="mobile" maxlength="10" type="text" class="form-control" name="mobile" placeholder="Mobile" onblur="if($('#mobile').val()=='') { $('#mobile').css('border','1px solid red'); } else { $('#mobile').css('border','1px solid #c4dee7'); }" >
                                </div>
                                
                                
                            </div>
                            
                            
                            
                            <div class="col-md-6">
                                <div id="formtext1" style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                                    <input id="dateofbirth" type="text" class="form-control" name="dateofbirth" value="" placeholder="Date fo birth">                                        
                                </div>
                                
                                  <div id="formtext1" style="margin-bottom: 42px" class="input-group">
                                         <i class="fa fa-user" aria-hidden="true"></i>&nbsp;<span class="graytxt"> GENDER</span>   
                                      <div class="radio radio-danger">
                                        <input type="radio" name="gender" id="gender1" value="Male" checked="">
                                        <label for="gender1">
                                            Male
                                        </label>
                                      </div>
                                        <div class="radio radio-danger">
                                            <input type="radio" name="gender" id="gender2" value="Female">
                                            <label for="gender2">
                                               Female
                                            </label>
                                        </div>                                      
                                    </div>
                                
                                 
                                
                                <div id="formtext1" style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-sign-in" aria-hidden="true"></i></span>
                                    <input id="password" type="password" class="form-control" name="password" placeholder="password" onblur="if($('#password').val()=='') { $('#password').css('border','1px solid red'); } else { $('#password').css('border','1px solid #c4dee7'); }" value="<?php if(isset($_SESSION['ProfilePassword'])) { echo $_SESSION['ProfilePassword']; } unset($_SESSION['ProfilePassword']); ?>"  >
                                </div>
                                
                                
                            </div>
                            
                            <div class="col-md-8 pull-right">
                                    <div class="row">
                                    <div class="forgottext graytxt col-md-2">CAPCHA</div>

                                    <div class="captchcode col-md-2"><span id="captcha_code" class="form-control"><?php echo rand('0000','9999'); ?></span></span></div>
                                    <div class="col-md-3">
                                        <input id="captcha" type="text" class="form-control" name="captcha" value="" placeholder="">
                                    </div>

                                    <input type="button" id="reg_submit_button" onclick="RegisterForm1();" class="btn btn-default-1 pull-right" value="SIGN UP" />
                                    </div>
									
								
                                <div style="margin-top:10px" class="form-group row">
                                    <!-- Button -->
                              
									 <div class="col-md-8 col-xs-12">
                                         <div class="clearfix"></div>   <hr>
                                         <i class="fa fa-hand-o-right know1i" aria-hidden="true"></i><span class="graytxt"> Already Account ?</span>
										<div class="pull-right" id="regi">
										<i class="fa fa-credit-card-alt" aria-hidden="true"></i>
											<a id="btn-fblogin" href="<?php echo $RootPath; ?>pages/student/" class="btn btn-default-1">LOGIN</a>
										</div>
									 </div>
                                </div>
                                
                                <p id="error_email" style="color:red; display:none;" >Please Enter Valid Email</p>
                                <p id="error_first_name" style="color:red; display:none;" >Please Enter Only Text In First Name </p>
                                <p id="error_last_name" style="color:red; display:none;" >Please Enter Only Text In Last Name</p>
                                <p id="error_mobile" style="color:red; display:none;" >Please Enter Valid Mobile Number Only Numeric Digits AND Enter 10 Digits </p>
                                <p id="error_pass" style="color:red; display:none;" >Please Enter Minimum 6 Character</p>
                                <p id="error_pass_reg" style="color:red; display:none;" >Please Enter Any Special Character like '%' '$' '*' </p>
                                
                             </div>
                            
                            
                             						
                            </form>
                        
                        
                            
                        </div>                     
                    </div>  
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
          //showOn: "button",
          //buttonImage: "<?php echo $RootPath; ?>images/calendar-icon.gif",
          //buttonImageOnly: true,
          //buttonText: "Select date",
		  changeMonth: true,
          changeYear: true,
          yearRange: "1950:<?php echo date('Y'); ?>",
          maxDate: '0'
  });
} );
  </script>

<script type="text/javascript">
function RegisterForm1(){
	var flag = true;
	/*
	var num_exp_1 = /^[a-zA-Z,(){}\[\]\-+*%\/="'~!&|<>?:;.$@#_ ]+$/;
	var user_name = $('#user_name').val()
	if($('#user_name').val()==''){
		$('#user_name').css('border','1px solid red');
		flag = false;
	} else {
            if (!user_name.match(num_exp_1)) {
                $('#error_username').show();
                $('#user_name').css('border','1px solid red');
                flag = false;
            } else {
                $('#error_username').hide();
                $('#user_name').css('border','1px solid #c4dee7');
            }
    }*/
	
	var regex = /^[a-zA-Z]+$/;
    if($('#first_name').val()==''){
            $('#first_name').css('border','1px solid red');
            flag = false;
	} else {
		if (!$('#first_name').val().match(regex)) {
			$('#first_name').css('border','1px solid red');
			$('#error_first_name').show();
			flag = false;
		} else {
			$('#error_first_name').hide();
			$('#first_name').css('border','1px solid #c4dee7');
		}
	}
	
	if($('#last_name').val()==''){
		$('#last_name').css('border','1px solid red');
		flag = false;
	} else {
		if (!$('#last_name').val().match(regex)) {
			$('#last_name').css('border','1px solid red');
			$('#error_last_name').show();
			flag = false;
		} else {
			$('#error_last_name').hide();
			$('#last_name').css('border','1px solid #c4dee7');
		}
    } 
	
//	if($('#company_name').val()==''){
//		$('#company_name').css('border','1px solid red');
//		flag = false;
//	} else {
//		$('#company_name').css('border','1px solid #c4dee7');
//	}
	
	var num_exp = /^[1-9][0-9]*$/;
    var mobile = $('#mobile').val()
    if (!mobile.match(num_exp)) {
        $('#mobile').css('border', '1px solid red');
		$('#error_mobile').show();
        flag = false;
    } else {
		if(mobile.length!=10){
			$('#error_mobile').show();
        	$('#mobile').css('border', '1px solid #c4dee7');
		} else {
			$('#error_mobile').hide();
        	$('#mobile').css('border', '1px solid #c4dee7');
		}
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
		$('#error_email').hide();
		$('#email').css('border','1px solid #dddddd');
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
//                        if($('#confirm_password').val()!=password){
//                            $('#error_con_pass').show();
//                            $('#password').css('border','1px solid red');
//                            $('#confirm_password').css('border','1px solid red');
//                             flag = false;
//                        } else {
                            $('#error_con_pass').hide();
                            $('#error_pass').hide();
                            $('#error_pass_reg').hide();
                            $('#password').css('border','1px solid #c4dee7');
                            $('#confirm_password').css('border','1px solid #c4dee7');
                        //}
                    }
                    
                }
		
	}
	
	
	var captcha_code =  $('#captcha_code').text();
	if($('#captcha').val()!=captcha_code){
		$('#captcha').css('border','1px solid red');
		flag = false;
	} else {
		$('#captcha').css('border','1px solid #c4dee7');
	}
	
	
	if(flag==false){
		return false;
	} else {
		var datastring = $('#cor_regi_form').serialize();
		$('#reg_submit_button').val('Please Wait');
		$.ajax({
			method:'post',
			url:"<?php echo $RootPath; ?>action/student.php",
			data:datastring,
			success: function(resp){
				$('#reg_submit_button').val('SUBMIT');
				
				//alert(resp);
				if(resp=="0"){
					$('#error_reg').hide();
					$('#active_reg').show();
					//$('#user_name').val('');
					$('#first_name').val('');
					//$('#last_name').val('');
					$('#mobile').val('');
					$('#dateofbirth').val('');
					$('#email').val('');
					$('#password').val('');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
                                        if($('#buynow').val()=='1'){
                                            window.setTimeout(function() {
                                                window.location.href = '<?php echo $RootPath; ?>pages/pricing/';
                                            },3000);
                                        } else {
                                            window.setTimeout(function() {
                                                window.location.href = '<?php echo $RootPath; ?>pages/student/';
                                            },3000);
                                        }
					
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