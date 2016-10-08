<?php include('../../connection.php');

	if(!isset($_SESSION['ProfileID'])) {
		header("location:".$RootPath);
		exit();
	}
include('../../header_1.php');

$sql_state = mysql_query("select StateID,StateName from `state` where IsActive = '1' ") or die(mysql_error());

$sql_city = mysql_query("select CityID,CityName from `city` where IsActive = '1' AND StateID = '".$row_user['StateID']."' ") or die(mysql_error());

?>

<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<?php include('sidebar.php'); ?>
<div class="col-sm-12 col-xs-12 col-md-12 no-padding-right right-col">
<div class="student-profile-section grey-box">
<div class="student-titles pull-left text-right"><small>HR Profile</small></div>


<?php if(isset($_SESSION['Success'])) { ?>
<br/><br/>
<div style="color:green; class="student-titles">
    <h5><?php echo $_SESSION['Success']; ?></h5>
</div>
<?php } unset($_SESSION['Success']); ?>   



<div class="row-fluid student-profile-row">
<form action="<?php echo $RootPath; ?>action/corporate.php" method="post" id="Edit_Form" enctype="multipart/form-data" >
<div class="col-sm-2 col-md-2 col-xs-12 text-center">
<div class="avtar-box">
<div class="avtar-image">
	<?php if($row_user['ProfilePicture']!='') { ?>
    	<img id="img1" src="<?php echo $RootPath; ?>images/corporatelogos/<?php echo $row_user['ProfilePicture']; ?>" />
	<?php } else { ?>
    	<img id="img1" src="<?php echo $RootPath; ?>images/avtar-image.png" />
    <?php } ?>
</div><br/>
<a onclick="OpenBrowser();" href="javascript:void(0);">Edit</a>
<input id="uploadFile" name="HrImage" type="file" style="display:none">
</div>
</div>


<div class="col-sm-10 col-md-10 col-xs-12">
<div class="student-forms">

 
 <input type="hidden" name="ProfileID" id="ProfileID" value="<?php echo $_SESSION['ProfileID']; ?>" />
 <input type="hidden" name="action" id="action" value="edit_profile" />
 
 <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">HR Name</label>
        
        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" class="form-control" id="ProfileFirstName" name="ProfileFirstName" placeholder="First Name" value="<?php echo $row_user['ProfileFirstName']; ?>" >
        </div>
        
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" name="ProfileLastName" id="ProfileLastName" placeholder="Last Name" value="<?php echo $row_user['ProfileLastName']; ?>" >
        </div>
        
<!--        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" readonly="readonly" class="form-control" id="ProfileName" name="ProfileName" placeholder="Profile Name" value="<?php echo $row_user['ProfileName']; ?>" >
        </div>-->
        
    </div>
 <div class="form-group row">
        <label for="dateofbirth" class="control-label col-md-2 col-xs-12 col-sm-3">Date of Birth </label>
        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" class="form-control" id="ProfileDBO" name="ProfileDBO" placeholder="Date Of Birth" value="<?php echo $row_user['ProfileDBO']; ?>" >
        </div>
        
        <div class="col-xs-12 col-md-6 col-sm-6"><label for="inputEmail" class="control-label">Gender </label>
            <select class="selectpicker show-tick form-control gender" name="ProfileGender" id="ProfileGender" >
 
  <option <?php if($row_user['ProfileGender']=="Male") { ?> selected="selected" <?php } ?> value="Male" >Male</option>
  <option <?php if($row_user['ProfileGender']=="Female") { ?> selected="selected" <?php } ?> value="Female" >Female</option>
</select>

        </div>
        
    </div>
    
 <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Email ID </label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="email" onblur="CheckEmail(this.value);" class="form-control" id="ProfileEmail" name="ProfileEmail" placeholder="Enter Email Address" value="<?php echo $row_user['ProfileEmail']; ?>" >
            <h5 id="error_email" style="color:red; display:none;" >Please Enter Valid Email</h5>
            <h5 id="ch_em_err" style="color:red; display:none;" >Email Not Available</h5>
            <h5 id="ch_em_su" style="color:green; display:none;" >Email Available</h5>
        </div>
        
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Phone</label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" id="ProfileMobile" name="ProfileMobile" placeholder="Enter Phone Number" value="<?php echo $row_user['ProfileMobile']; ?>" >
            <h5 id="error_mobile" style="color:red; display:none;" >Please Enter Valid Mobile Number Only Numeric Digits</h5>
        </div>
        
        
    </div>
    
    
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Company Name</label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" name="ProfileCompanyName" id="ProfileCompanyName" placeholder="Enter Company Name" value="<?php echo $row_user['ProfileCompanyName']; ?>" >
        </div>
        
        
        <label for="inputPincode" class="control-label col-md-2 col-xs-12 col-sm-3">Pincode</label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" maxlength="6" class="form-control" id="ProfilePincode" name="ProfilePincode" placeholder="Enter Pin Coe" value="<?php echo $row_user['ProfilePincode']; ?>" >
            <h5 id="error_pincode" style="color:red; display:none;" >Please Enter Valid Pin code Number Only Numeric Digits & 6 Digits</h5>
        </div>
        
    </div>
    
    
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-3">Residence Address</label>
        <div class="col-xs-12 col-md-9 col-sm-9 address-field">
            <input type="text" class="form-control" id="ProfileAddress" name="ProfileAddress" placeholder="Enter Address " value="<?php echo $row_user['ProfileAddress']; ?>" >
            <input type="text" class="form-control" id="ProfileAddress1" name="ProfileAddress1" placeholder="Enter Address " value="<?php echo $row_user['ProfileAddress1']; ?>" >
        </div>
       
        
        
    </div>
    
   <div class="form-group row">
   		<label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">Country</label>
   		<div class="col-xs-12 col-md-3 col-sm-2">
            <input type="text" class="form-control" name="ProfileCountry" id="ProfileCountry" placeholder="Enter Country" value="INDIA" readonly="readonly" >
        </div>
        <label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">State</label>
        <div class="col-xs-12 col-md-3 col-sm-2">
          	<select class="selectpicker show-tick form-control state" onchange="ChangeState(this.value);"  id="StateID" name="StateID" >
 				<option value="0" >Select State</option>
                <?php while($row_state = mysql_fetch_array($sql_state)) { ?>
                	<option <?php if($row_user['StateID']==$row_state['StateID']) { ?> selected="selected" <?php } ?> value="<?php echo $row_state['StateID']; ?>" ><?php echo $row_state['StateName']; ?></option>
                <?php } ?>
			</select>
        </div>
        <?php if($row_user['CityID']!='') { ?>
        	<label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">City </label>
            <div id="city_div" class="col-xs-12 col-md-3 col-sm-2">
                <select class="selectpicker show-tick form-control city" id="CityID" name="CityID" >
                <?php while($row_city = mysql_fetch_array($sql_city)) { ?>
                    <option <?php if($row_city['CityID']==$row_user['CityID']) { ?> selected="selected" <?php } ?> value="<?php echo $row_city['CityID']; ?>" ><?php echo $row_city['CityName']; ?></option>
                <?php } ?>    
                
                </select>
            </div>
        <?php } else { ?>
        	<label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">City </label>
            <div id="city_div" class="col-xs-12 col-md-3 col-sm-2">
                <select class="selectpicker show-tick form-control city" id="CityID" name="CityID" >
                    <option value="0" >Select City</option>
                </select>
            </div>
        <?php } ?>
        
        
        
    </div>
    
    
    <div class="buttons-box text-center">
        <input type="button" onclick="EditProfile();" class="green-butt green-back" value="Save" />
    	<!--<input type="reset" class="green-butt" />-->
    </div>
    <input type="hidden" name="email_value" id="email_value" value="0" />
    </form>
    </div>
</div> 
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
	$( "#ProfileDBO" ).datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: "1950:<?php echo date('Y'); ?>",
        dateFormat:"yy-mm-dd",
        maxDate: '0',
        showOn: "button",
        buttonImage: "<?php echo $RootPath; ?>images/calendar-icon.gif",
        buttonImageOnly: true,
        buttonText: "Select date",
    });
} );
</script>
<script type="text/javascript">
function ChangeState(stateval){
	var action = "change_state";
	$.ajax({
		method:'post',
		url:'<?php echo $RootPath; ?>action/corporate.php',
		data:{stateval:stateval,action:action},
		success: function(resp){
			$('#city_div').html(resp);
		}
	});
}
</script>
<script type="text/javascript">

function OpenBrowser(){
	$('#uploadFile').click();
}

/*$("#uploadFile").on("change", function() {
	var src = $(this).val();
	//alert(src);
    $("#uploadFile").prop("src", $(this).val());
	

});*/
</script>

<script type="text/javascript">
$(function() {
    $("#uploadFile").on("change", function()
    {
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support

        if (/^image/.test( files[0].type)){ // only image file
            var reader = new FileReader(); // instance of the FileReader
            reader.readAsDataURL(files[0]); // read the local file

            reader.onloadend = function(){ // set image data as background of div
                //$(".avtar-image").css("background-image", "url("+this.result+")");
				//$("#img1").attr("src",'this.result');
				$('#img1').attr('src',this.result);
			}   
        }
    });
});
</script>
<script type="text/javascript">
function ChangeImage(){
	$('#image_form').submit();
}
</script>


<script type="text/javascript">
function EditProfile(){
	var flag = true;
	
	
	if($('#ProfileFirstName').val()==''){
		$('#ProfileFirstName').css('border','1px solid red');
		flag = false;
	} else {
		$('#ProfileFirstName').css('border','1px solid #c4dee7');
	}
	
	if($('#ProfileLastName').val()==''){
		$('#ProfileLastName').css('border','1px solid red');
		flag = false;
	} else {
		$('#ProfileLastName').css('border','1px solid #c4dee7');
	}
	
	if($('#ProfileCompanyName').val()==''){
		$('#ProfileCompanyName').css('border','1px solid red');
		flag = false;
	} else {
		$('#ProfileCompanyName').css('border','1px solid #c4dee7');
	}
	
	var num_exp = /^[1-9][0-9]*$/;
    var mobile = $('#ProfileMobile').val()
    if (!mobile.match(num_exp)) {
        $('#ProfileMobile').css('border', '1px solid red');
		$('#error_mobile').show();
        flag = false;
    } else {
		$('#error_mobile').hide();
        $('#ProfileMobile').css('border', '1px solid #c4dee7');
    }
	
	
	var pincode = $('#ProfilePincode').val();
	if(pincode!='') {
		if (!pincode.match(num_exp)) {
			$('#ProfilePincode').css('border', '1px solid red');
			$('#error_pincode').show();
			flag = false;
		} else {
                        if($('#ProfilePincode').val().length > 5){
                            $('#error_pincode').hide();
                            $('#ProfilePincode').css('border', '1px solid #c4dee7');
                        } else {
                            $('#ProfilePincode').css('border', '1px solid red');
                            $('#error_pincode').show();
                            flag = false;
                        }
			
		}
	}
	
	if($('#ProfileDBO').val()==''){
		$('#ProfileDBO').css('border','1px solid red');
		flag = false;
	} else {
		$('#ProfileDBO').css('border','1px solid #c4dee7');
	}
	
	var emailstr = /^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	var email = $('#ProfileEmail').val();
	if(!email.match(emailstr) || email==''){
		$('#ProfileEmail').css('border','1px solid red');
		$('#error_email').show();
		flag = false;
	}else{
		$('#ProfileEmail').css('border','1px solid #dddddd');
		$('#error_email').hide();
	}
	
	
	if(flag==false){
		return false;
	} else {
		if($('#email_value').val()=='1') {
			return false;
		} else {
			$('#Edit_Form').submit();
		}
		
	}
}
</script>
<script type="text/javascript">
function CheckEmail(emailvalue){
	var emailvalue = emailvalue;
	var action = "check_email";
	$.ajax({
		method:'post',
		url:'<?php echo $RootPath; ?>action/corporate.php',
		data:{emailvalue:emailvalue,action:action},
		success:function(resp){
			 if(resp=="0") {
				 $('#email_value').val('0');
				 $('#ch_em_err').hide();
				 $('#ch_em_su').hide();
			 } else if(resp=="1") {
				 $('#email_value').val('1');
				 $('#ch_em_err').show();
				 $('#ch_em_su').hide();
			 } else if(resp=="2"){
			 	$('#email_value').val('0');
				$('#ch_em_su').show();
				$('#ch_em_err').hide();
			 }
		}
	});
}
</script>
<?php include('../../footer.php'); ?>