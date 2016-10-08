<?php include('../../db.php');
include('../../head1.php');
?>
<?php
 require('../../db.php');
 // If form submitted, insert values into the database.
 if (isset($_POST['username'])){
 <!--$username = $_POST['username'];-->
 $email = $_POST['email'];
 $firstname = $_POST['firstname'];
 <!--$username = stripslashes($username);
 $username = mysql_real_escape_string($username);-->
 $email = stripslashes($email);
 $email = mysql_real_escape_string($email);
 $firstname = stripslashes($firstname);
 $firstname = mysql_real_escape_string($firstname);
 <!--$trn_date = date("Y-m-d H:i:s");
 $query = "INSERT into `users` (firstname, lastname, email,) VALUES ('$username', '".md5($password)."', '$email', '$trn_date')";
 $result = mysql_query($query);
 if($result){
 echo "<div class='form'><h3>You are registered successfully.</h3><br/>Click here to <a href='login.php'>Login</a></div>";
 }
 }else{
?>

<div class="container">    
        
        <div id="signupbox" style="display; margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <div class="panel-title text-center">ITGYANI Trainer Registration Form</div>
                            <div style="float:right; font-size: 85%; position: relative; top:-10px"><a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()"></a></div>
                        </div>  
                        <div class="panel-body" >
                            <form id="signupform" class="form-horizontal" role="form">
                            <div id="signupalert" style="display:none" class="alert alert-danger">
                                    <p>Error:</p>
                                    <span></span>
                                </div>
                                    
                                
                                  
                                <div class="form-group">
                                    <label for="email" class="col-md-4 control-label">Email :</label>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="email" placeholder="Email Address">
                                    </div>
                                </div>
                                    
                                <div class="form-group">
                                    <label for="firstname" class="col-md-4 control-label">First Name :</label>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="firstname" placeholder="First Name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="lastname" class="col-md-4 control-label">Last Name :</label>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="lastname" placeholder="Last Name">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="password" class="col-md-4 control-label">Mobile No :</label>
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="mno" placeholder="10-digit Mob No">
                                    </div>
                                </div>
                                    
                                <div class="form-group">
                                    <label for="icode" class="col-md-4 control-label">Skill Set :</label>
                                    <div class="col-md-8">
                                        <select class= "form-control">
  
  <option value="oracle">Oracle</option>
  <option value="saab">Tableau</option>
  <option value="opel">Java Programming</option>
  <option value="audi">MongoDb</option>
  <option value="audi">SAP</option>
  <option value="audi">Talend - ETL</option>
  <option value="audi">Click View</option>
  <option value="audi">PHP</option>
  <option value="audi">Android Development </option>
  <option value="audi">Pentaho</option>
</select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email" class="col-md-4 control-label">Upload Resume:</label>
                                    <div class="col-md-8">
                                        <input type="file" class="form-control" name="email" placeholder="Upload File">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <!-- Button -->                                        
                                    <div class="col-md-12 text-center">
                                        <button id="btn-signup" type="button" class="btn btn-info"><i class="icon-hand-right"></i> &nbsp Submit</button>
                                     
                                    </div>
                                </div>
                                                            
                                
                                
                            </form>
                         </div>
                    </div>

            
         </div> 
    </div>
<?php include('../../footer.php');?>