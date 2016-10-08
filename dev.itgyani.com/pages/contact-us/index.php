<?php include('../../connection.php');
include('../../header.php');
?>

<div class="middle-content">
    
    <div class="contact-section">
        <div class="container-fluid">
           <div class="col-md-8 contact-tag">
               
                <div class="contact-box">
                <!--google map start-->
                   <div class="mapWraper" style="height:100%;width:100%">
                         <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                         <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3782.468286393725!2d73.89079795075722!3d18.552915072963838!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc2c11fcddc2481%3A0xbf208c37a98e0358!2sTechpark+One+Yerwada+Pune+-+Vatika+Business+Centre!5e0!3m2!1sen!2sin!4v1473855106075" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
                   </div>

               <!--google map end-->
               </div>
          </div>
          <div class="contact-detail">
 
 
          </div>
          <h3 id="success" style="color:white; display:none;"> Your Form Succesfully Submitted...</h3>
          <h3 id="error" style="color:red; display:none;"> Form Not Submitted Please Try After Some Time...</h3>
          <div class="col-md-4">
              
              
			  <div class="col-md-10 center contact-form">
					<h3 style="color: white;">Leave a Message</h3>
				   <form action="javascript:void(0);" method="post" id="contact_form" >
					  <input type="text" name="email" id="email" placeholder="email"  />
					  <p id="email_err" style="color:red; display:none;" > Please Enter Valid Email Address </p>
					  <input type="text" name="subject" id="subject" placeholder="Subject" />
					  <p id="subject_err" style="color:red; display:none;" > Please Enter Subject </p>
					  <textarea placeholder="Message" name="message" id="message" rows="8"></textarea>
					  <p id="message_err" style="color:red; display:none;" > Please Enter Message At Least 20 Character </p>
					  <input type="button" onClick="SendMessage();" id="send_btn" value="Send Message" class="blue-buttons" />
					  <img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100"     align="center" />
				   </form> 
				  
			  </div>
				<div class="contact-numbers text-left">
					<span><i class="fa fa-globe"></i><a href="www.itgyani.com" target="_blank">www.itgyani.com </a></span>
				   <span><i class="fa fa-envelope-o"></i><a href="mailto:support@itgyani.com" target="_blank">support@itgyani.com</a></span>
				</div>
          </div>
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