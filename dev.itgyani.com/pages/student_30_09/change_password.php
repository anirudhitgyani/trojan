<?php include('../../connection.php'); ?>
<?php include('../../header.php');
$ProfileID = $_REQUEST['ProfileID'];
?>


<div class="middle-content">
<div class="registration-section">
<div class="container">
<div class="white-box-pop text-center">

<center><h3 id="error" style="color:red; display:none;" >Password Not Changed</h3></center>
<center><h2 id="success" style="color:green; display:none; background: white; " >"Your Password Successfully Changed..."</h2></center>

  

<h2>Please Enter New Password </h2>
<div class="register-form">
<form action="javascript:void(0);" method="post" id="cor_regi_form" enctype="multipart/form-data" >

<input type="hidden" name="action" id="action" value="change_password"  />
<input type="hidden" name="ProfileID" id="ProfileID" value="<?php echo $ProfileID; ?>"  />

<div class="form-group"><label>New Password: </label><input name="password" id="password" type="password" class="form-input" onblur="if($('#password').val()=='') { $('#password').css('border','1px solid red'); } else { $('#password').css('border','1px solid #c4dee7'); }" value="" /></div>
<h5 id="error_pass" style="color:red; display:none;" >Please Enter Minimum 6 Character</h5>
<h5 id="error_pass_reg" style="color:red; display:none;" >Please Enter Any Special Character like '%' '$' '*' </h5>
<div class="form-group"><label> Confirm Password: </label><input name="confirm_password" id="confirm_password" type="password" class="form-input" onblur="if($('#confirm_password').val()=='') { $('#confirm_password').css('border','1px solid red'); } else { $('#confirm_password').css('border','1px solid #c4dee7'); }" value="" /></div>
<h5 id="error_con_pass" style="color:red; display:none;" >Password and Confirm Password Not Same...</h5>
</form>
</div>
<input type="button" onclick="ChangePassword();" class="blue-buttons submit-button" value="Submit" />
<img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100" align="center" />
<!--<a href="#" class="blue-buttons close-butt">Close</a>-->

</div>
</div>

</div>
</div>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
  
<script type="text/javascript">
function ChangePassword(){
	var flag = true;
	
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
                    var spchar = /[,(){}\[\]\-+*%\/="'~!&|<>?:;.$@# ]/;
                    if(!password.match(spchar)) {
                        $('#password').css('border','1px solid red');
                        $('#error_pass_reg').show();
                        $('#error_pass').hide();
                        flag = false;
                    } else {
                        if($('#confirm_password').val()!=password){
                            $('#error_con_pass').show();
                            $('#password').css('border','1px solid red');
                            $('#confirm_password').css('border','1px solid red');
                             flag = false;
                        } else {
                            $('#error_con_pass').hide();
                            $('#error_pass').hide();
                            $('#error_pass_reg').hide();
                            $('#password').css('border','1px solid #c4dee7');
                            $('#confirm_password').css('border','1px solid #c4dee7');
                        }
                    }
                }
	}
       
	if(flag==false){
		return false;
	} else {
		
		var datastring = $('#cor_regi_form').serialize();
		$('#reg_submit_button').val('Please Wait');
		$('#loader-img').show();
		$.ajax({
			method:'post',
			url:"<?php echo $RootPath; ?>action/student.php",
			data:datastring,
			success: function(resp){
				$('#reg_submit_button').val('SUBMIT');
				$('#loader-img').hide();
				//alert(resp);
				if(resp=="0"){
					$('#success').hide();
                                        $('#error').show();
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				} else if(resp=="1"){
					$('#error').hide();
					$('#success').show();
					$('html, body').animate({ scrollTop: 0 }, 'slow');
				}
			}
		});
	}
}
</script>

<?php include('../../footer.php'); ?>