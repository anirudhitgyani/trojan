<?php include('../../connection.php');
	if(!isset($_SESSION['ProfileID'])) {
		header("location:".$RootPath);
		exit();
	}
include('../../header_1.php');

$sql_state = mysql_query("select StateID,StateName from `state` where IsActive = '1' ") or die(mysql_error());

?>

<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<?php include('sidebar.php'); ?>
<div class="col-sm-9 col-xs-12 col-md-10 no-padding-right right-col">
<div class="student-profile-section grey-box">
<div class="student-titles pull-left text-right">HR<br/><small>Profile</small></div>


<div class="row-fluid student-profile-row">
<div class="col-sm-2 col-md-2 col-xs-12 text-center">
<div class="avtar-box">
<div class="avtar-image">
<img src="<?php echo $RootPath; ?>images/avtar-image.png" /></div><br/>
<a href="#">Edit</a> / <a href="#">Uploads</a>
</div>
</div>
<div class="col-sm-10 col-md-10 col-xs-12">
<div class="student-forms">
<form>
 <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">HR Name</label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" name="ProfileLastName" id="ProfileLastName" placeholder="Last Name" value="<?php echo $row_user['ProfileLastName']; ?>" >
        </div>
        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" class="form-control" id="MiddleName" name="MiddleName" placeholder="Middle Name" value="<?php echo $row_user['middle_name']; ?>" >
        </div>
        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" class="form-control" id="ProfileFirstName" name="ProfileFirstName" placeholder="First Name" value="<?php echo $row_user['ProfileFirstName']; ?>" >
        </div>

        
    </div>
 <div class="form-group row">
        <label for="dateofbirth" class="control-label col-md-2 col-xs-12 col-sm-3">Date of Birth </label>
        <div class="col-xs-12 col-md-3 col-sm-3">
            <input type="text" class="form-control" id="ProfileDBO" name="ProfileDBO" placeholder="Date Of Birth" value="<?php echo $row_user['ProfileDBO']; ?>" >
        </div>
        
        <div class="col-xs-12 col-md-6 col-sm-6"><label for="inputEmail" class="control-label">Gender </label>
            <select class="selectpicker show-tick form-control gender">
 
  <option <?php if($row_user['ProfileGender']=="Male") { ?> selected="selected" <?php } ?> value="Male" >Male</option>
  <option <?php if($row_user['ProfileGender']=="Female") { ?> selected="selected" <?php } ?> value="Female" >Female</option>
</select>

        </div>
        
    </div>
 <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Email id </label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="email" class="form-control" id="inputEmail" placeholder="Enter Email Address" value="<?php echo $row_user['ProfileEmail']; ?>" >
        </div>
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Phone</label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" id="inputEmail" placeholder="Enter Phone Number" value="<?php echo $row_user['ProfileMobile']; ?>" >
        </div>
        
        
    </div>
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-3 col-xs-12 col-sm-3">Residence Address</label>
        <div class="col-xs-12 col-md-9 col-sm-9 address-field">
            <input type="text" class="form-control" id="Address" name="Address" placeholder="Enter Address ">
            <input type="text" class="form-control" id="Address1" name="Address1" placeholder="Enter Address ">
        </div>
       
        
        
    </div>
    
   <div class="form-group row">
   		<label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">Country</label>
   		<div class="col-xs-12 col-md-3 col-sm-2">
            <input type="text" class="form-control" id="Country" placeholder="Enter Country" value="INDIA" readonly="readonly" >
        </div>
        <label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">State</label>
        <div class="col-xs-12 col-md-3 col-sm-2">
          	<select class="selectpicker show-tick form-control state" onchange="ChangeState(this.value);"  id="StateID" name="StateID" >
 				<option value="0" >Select State</option>
                <?php while($row_state = mysql_fetch_array($sql_state)) { ?>
                	<option value="<?php echo $row_state['StateID']; ?>" ><?php echo $row_state['StateName']; ?></option>
                <?php } ?>
			</select>
        </div>
        <label for="inputEmail" class="control-label col-md-1 col-xs-12 col-sm-2">City </label>
        <div id="city_div" class="col-xs-12 col-md-3 col-sm-2">
            <select class="selectpicker show-tick form-control city" id="CityID" name="CityID" >
 				<option value="0" >Select City</option>
            </select>
        </div>
        
        
        
    </div>
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Pancard No:</label>
        <div class="col-xs-12 col-md-6 col-sm-6">
            <input type="text" class="form-control" id="PanCard" name="PanCard" placeholder="Enter Pancard Number">
        </div>
        
        
        
        
    </div>
    <div class="form-group row">
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Passport no: </label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" id="PassportNo" name="PassportNo" placeholder="Enter Passport Number">
        </div>
        <label for="inputEmail" class="control-label col-md-2 col-xs-12 col-sm-3">Validity Date:</label>
        <div class="col-xs-12 col-md-4 col-sm-3">
            <input type="text" class="form-control" id="PassportExpiryDate" name="PassportExpiryDate" placeholder="Enter Validity Date">
        </div>
        
        
    </div>
    <div class="buttons-box text-center">
    	<input type="submit" class="green-butt green-back" />
    	<!--<input type="reset" class="green-butt" />-->
    </div>
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
	$( "#DateOfBirth" ).datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: "1950:<?php echo date('Y'); ?>"
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

<?php include('../../footer.php'); ?>