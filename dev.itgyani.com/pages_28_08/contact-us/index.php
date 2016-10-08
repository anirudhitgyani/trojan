<?php include('../../connection.php');
include('../../header.php');
?>

<div class="middle-content">
 <div class="contact-section">
 <div class="contact-tag">
 <span class="location"></span>
 <div class="contact-box">
 <span><strong>Techno Flair Lab Pvt. Ltd.</strong></span>
 <span><i class="fa fa-map-marker"></i> Vatika Business Centre,Level-5, Panchshil Tech <br/>Park One, Airport Road, <br/>Yerwada, Pune - 411006, India</span> 
 <span><i class="fa fa-mobile"></i><strong>Office:</strong> + 91.20.4011 1336 | <br/><strong>Fax:</strong> + 91.020. 40111105<br/><strong>Contact</strong>: +91 777 406 0320 / +91 777 406 0328</span> 

<span><i class="fa fa-globe"></i> www.itgyani.com</span> 

 </div>
 </div>
 <div class="contact-detail">
 <!--<div class="social-login contact-social text-center"><label>social media links</label><a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i class="fa fa-twitter"></i></a><a href="#"><i class="fa fa-linkedin"></i></a><a href="#"><i class="fa fa-linkedin"></i></a></div>-->
 
 <div class="social-login footer-login text-center">
    <label>social media links</label>
        <a target="_blank"  href="https://www.facebook.com/ITgyani"><i class="fa fa-facebook"></i></a>
        <a target="_blank" href="https://twitter.com/info_itgyani"><i class="fa fa-twitter"></i></a>
        <a target="_blank" href="https://plus.google.com/u/0/100206678218261154294"><i class="fa fa-google-plus"></i></a>
        <a target="_blank" href="https://www.linkedin.com/company/itgyani"><i class="fa fa-linkedin"></i></a>
</div>

<h3 id="success" style="color:white; display:none;"> Your Form Succesfully Submitted...</h3>
<h3 id="error" style="color:red; display:none;"> Form Not Submitted Please Try After Some Time...</h3>
 <div class="contact-form">
<form action="javascript:void(0);" method="post" id="contact_form" >
<input type="text" name="email" id="email" placeholder="email" />
<p id="email_err" style="color:red; display:none;" > Please Enter Valid Email Address </p>
<input type="text" name="subject" id="subject" placeholder="Subject" />
<p id="subject_err" style="color:red; display:none;" > Please Enter Subject </p>
<textarea placeholder="Message" name="message" id="message" rows="8"></textarea>
<p id="message_err" style="color:red; display:none;" > Please Enter Message At Least 20 Character </p>
<input type="button" onClick="SendMessage();" id="send_btn" value="Send Message" class="blue-buttons" />
<img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100" align="center" />
</form> 
 </div>
 <div class="contact-numbers">
<span><i class="fa fa-globe"></i><a href="www.itgyani.com" target="_blank">www.itgyani.com </a></span>
<span><i class="fa fa-envelope-o"></i><a href="mailto:support@itgyani.com" target="_blank">support@itgyani.com</a></span>
 </div>
 </div>
 </div>
</div>

<script type="text/javascript">
function SendMessage(){
	var flag = true;
	
	var emailstr = /^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	var email = $('#email').val();
	if(!email.match(emailstr) || email==''){
		$('#email').css('border','1px solid red');
		$('#email_err').show();
		flag = false;
	}else{
		$('#email').css('border','1px solid #dddddd');
		$('#email_err').hide();
	}
	
	if($('#subject').val()==''){
		$('#subject').css('border','1px solid red');
		$('#subject_err').show();
		flag = false;
	} else {
		$('#subject').css('border','1px solid #c4dee7');
		$('#subject_err').hide();
	}
	
	
	if($('#message').val().length < 20){
		$('#message').css('border','1px solid red');
		$('#message_err').show();
		flag = false;
	} else {
		$('#message').css('border','1px solid #c4dee7');
		$('#message_err').hide();
	}
	
	if(flag==false){
		return false;
	} else {
		var datastring = $('#contact_form').serialize();
		$('#send_btn').val('Please Wait');
		$('#loader-img').show();
		$.ajax({
			method:'post',
			url:"<?php echo $RootPath; ?>action/contact.php",
			data:datastring,
			success: function(resp){
				//alert(resp);
				$('#send_btn').val('SUBMIT');
				$('#loader-img').hide();
				$('html, body').animate({ scrollTop: 0 }, 'slow');
				if(resp=="0") {
					$('#email').val('');
					$('#subject').val('');
					$('#message').val('');
					$('#success').show();
					$('#error').hide();
				} else {
					$('#error').show();
					$('#success').hide();
				}
			}
		});
	}
}
</script>
<?php include('../../footer.php'); ?>