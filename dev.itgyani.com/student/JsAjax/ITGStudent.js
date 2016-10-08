/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function () {
            try {           
                //alert('called');
                    fbAsyncInit(); 
                    //alert('called')
                    $.holdReady( false );
                    // Load the SDK Asynchronously
                    (function(d){
                       var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
                       if (d.getElementById(id)) {return;}
                       js = d.createElement('script'); js.id = id; js.async = true;
                       js.src = "//connect.facebook.net/fr_FR/all.js#xfbml=1";
                       ref.parentNode.insertBefore(js, ref);
                     }(document));
                    //document.getElementById("login").addEventListener("click", FacebookLogin);
                    document.getElementById("SignInUp").addEventListener("click", LoginUp);
                    //document.getElementById("ITGBtnSubmit").addEventListener("click", SignUp);                    
                   // alert('called');
            }
            catch (err) {
                alert(err.message);
            }
            
        
        });
function SignUp()
{
  try{
        if(document.getElementById('ITGRegisterationEmail').value.toString().length == 0)
        {
            bootbox.alert("Please, Enter Email ID!!!");
            return;
        }
        if(! DiStdValidateEmail(document.getElementById('ITGRegisterationEmail').value.toString().trim()))
        {
            bootbox.alert("Please, Enter Valid Email ID!!!");         
            return;
        }
        if(document.getElementById('ITGRegisterationPassword').value.toString().length == 0)
        {
            bootbox.alert("Please, Enter Password!!!");
            return;
        }
        if(document.getElementById('ITGRegisterationPassword').value.toString().length < 8)
        {
            bootbox.alert("Minumum 8 Character Password Required!!!");
            return;
        }
        if(document.getElementById('ITGRegisterationPassword').value.toString() != document.getElementById('ITGRegisterationPasswordConfirm').value.toString())
        {
            bootbox.alert("Password Not Confirmed !!!");
            return;
        }
        XXX002(document.getElementById('ITGRegisterationEmail').value,document.getElementById('ITGRegisterationEmail').value,document.getElementById('ITGRegisterationPassword').value.toString() , '', '1','0' );
    }catch(err){alert(err.message)}
}
function LoginUp()
{
  try{   
        //document.getElementById('myModal2').className='modal hide';
        //alert(document.getElementById('ITGTxtLoginID').value.toString().trim().length);
        //alert('called1');
        //  alert(document.getElementById('user_name').value.toString().trim());
             //   document.getElementById('user_name').value = "vijay.katake@outlook.com";
               //  document.getElementById('password').value = "Vijay890@";
               if(! DiStdValidateEmail(document.getElementById('user_name').value.toString().trim()))
               {
                   bootbox.alert("Please, Enter Valid Email ID!!!");         
                   return;
               }
               if(document.getElementById('password').value.toString().trim().length == 0)
               {
                   bootbox.alert("Please, Enter Password!!!");         
                   return;
               }
               //$("#SignInUp").hide();
               //$("#ITGImgSignUp").show();
                var ObjDBSignIn = BrizBVKStandardObjGetHandler();
                //alert(ObjDBSignIn);
                    ObjDBSignIn.onreadystatechange = function ()
                    {
                            if (ObjDBSignIn.readyState == 4 && ObjDBSignIn.status == 200)
                            {
                                    
                                   // alert(ObjDBSignIn.responseText);
                                    $.each($.parseJSON(ObjDBSignIn.responseText), function (key, TabValue) {
                                        //WHEN 'SignInFailed' THEN 209 
                                        //WHEN 'SignInSuccess' THEN 210
                                        //alert(TabValue.ResultID);
                                        //alert(TabValue.ResultID);
                                        if(TabValue.ResultID == 210)
                                        {
                                            $.ajax({
                                                    //This will retrieve the contents of the folder if the folder is configured as 'browsable'
                                                    url: "../../API/ITGStudent.php?CallID=GetLogin" +            
                                                            "&Email=" + encodeURIComponent( document.getElementById('user_name').value.toString())
                                                            ,
                                                    success: function (data) {                                                                                           
                                                               // alert(data);
                                                                $(location).attr('href', '../../studentdashboard.php');                                                                                        
                                                               //$("#ITGBtnSubmit").show();
                                                               //$("#ITGImgSubmit").hide();
                                                               //$("#SignInUp").show();
                                                               // $("#ITGImgSignUp").hide();
                                                               bootbox.alert("Registered Successfully !!!");
                                                            }
                                                });  
                                           
                                        }
                                        else if (TabValue.ResultID == 209)
                                        {
                                         //   $("#SignInUp").show();
                                         //   $("#ITGImgSignUp").hide();
                                            BrizBVKStandardProcBootboxLoginFailed("Login Failed.", document.getElementById('user_name'), TabValue.TransMessage);
                                        }
                                        else if (TabValue.ResultID == 207)
                                        {
                                           // $("#SignInUp").show();
                                           // $("#ITGImgSignUp").hide();
                                            BrizBVKStandardProcBootboxUnderMaintenance("OPPP'S. Site Is Under Maintinance.", document.getElementById('EwebTxtUserID'), TabValue.TransMessage);                                            
                                        }
                                        else
                                        {
                                            alert(TabValue.ResultID);
                                        }
                                        //ArrDownload.push(TabValue.downloads);
                                    });
                
                            }
                            else
                            {
                                return false;
                            }
                        }
                        //alert('called');
                ObjDBSignIn.open("GET", "../../API/ITGStudent.php?CallID=SignIn&XXX01=" + document.getElementById('user_name').value + "&XXX02="+document.getElementById('password').value);
                ObjDBSignIn.setRequestHeader("Content-Type", "'application/json'");
                ObjDBSignIn.send();   
        
        
    }catch(err){alert(err.message)}
}
function fbAsyncInit() {
                        if(document.URL == "http://localhost:8080/ITGyani-Portal/student.php#" || document.URL == "http://localhost:8080/ITGyani-Portal/student.php")
                        {
                            FB.init({
                                    appId      : '137958193296200',
                                    status     : true, // check login status
                                    cookie     : true, // enable cookies to allow the server to access the session
                                    xfbml      : true,
                                    version    : 'v2.6'
                            });
                        }
                        if(document.URL == "http://localhost/ITGyani-Portal/student.php#" || document.URL == "http://localhost/ITGyani-Portal/student.php")
                        {
                            FB.init({
                                    appId      : '1031482950222065',
                                    status     : true, // check login status
                                    cookie     : true, // enable cookies to allow the server to access the session
                                    xfbml      : true,
                                    version    : 'v2.6'
                            });
                        }
                        if(document.URL == "http://www.itgyani.com/student.php#" || document.URL == "http://www.itgyani.com/student.php")
                        {
                            FB.init({
                                    appId      : '678809938939491',
                                    status     : true, // check login status
                                    cookie     : true, // enable cookies to allow the server to access the session
                                    xfbml      : true,
                                    version    : 'v2.6'
                            });                            
                        }
	}
  function FacebookLogin()
  {
      try {            
            var profilename , profileemail, profilepicture;
            FB.login(
            function(response) {
                            if (response.status== 'connected') {
                                    FB.api('/me/permissions', function(response) {
                                        //console.log(response);
                                      });
                                    FB.api('/me?fields=email,name', function(response) {
                                        if(response.email == undefined)
                                        {
                                           FacebookLogin();
                                           return;
                                        }
                                        if(!response.email )
                                        {
                                            profileemail = response.name.replace(' ' , '') + '@facebook.com' ;
                                        }
                                        else
                                        {
                                            profileemail = response.name;
                                        }
                                       // alert(response.name);
                                        profilename = response.name ;                                            
                                        //alert(profileemail);
                                    //alert(response);
                                    //alert('Good to see you, ' + response.name + '.');				      	
                                    //	alert(response.name  + response.location.name);                                        
                                });

                                FB.api('/me/picture?width=200&redirect=0&type=normal&height=200', function (response) {
                                    if (response && !response.error) {
                                            /* handle the result */
                                            //alert(response.data.url);
                                            profilepicture = response.data.url;
                                            //alert(profileemail);
                                            XXX001(profilename,profileemail,null , profilepicture, '1','0' );
                                    }
                                });
                            }
                            else
                            {
                                
                            }
                    }, {scope: 'email'}
            );
      }catch(err){alert(err.message);}
  }
function XXX001(ParaProfileName ,ParaEmail , ParaPassword,ParaProfilePicture, ParaIsFaceBook,ParaIsGmail)
{
    try{
            //alert(ParaProfileName);
            //alert(ParaEmail);
            //alert(ParaPassword);
            //alert(ParaProfilePicture);
            //alert(ParaIsFaceBook);
            //alert(ParaIsGmail);
        $.ajax({
            
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStudent.php?CallID=XXX001" +            
                    "&XXX01=" + encodeURIComponent( ParaProfileName) +
                    "&XXX02=" + encodeURIComponent( ParaEmail) +
                    "&XXX03=" + encodeURIComponent( ParaPassword) +
                    "&XXX04=" + encodeURIComponent( ParaProfilePicture) +
                    "&XXX05=" + encodeURIComponent( ParaIsFaceBook) +
                    "&XXX06=" + encodeURIComponent( ParaIsGmail) 
                    ,
            success: function (data) {                
                data = JSON.parse(data);
                //alert(data[0].ResultID);
                if(data[0].ResultID == 202 || data[0].ResultID == 201)
                {  
                    //alert(data[0].ResultID);
                    $.ajax({
                                //This will retrieve the contents of the folder if the folder is configured as 'browsable'
                                url: "API/ITGStudent.php?CallID=GetLogin" +            
                                        "&Email=" + encodeURIComponent( ParaEmail)
                                        ,
                                success: function (data) {                                                                                           
                                            $(location).attr('href', 'studentdashboard.php');                                                                                        
                                           $("#ITGBtnSubmit").show();
                                           $("#ITGImgSubmit").hide();
                                           bootbox.alert("Registered Successfully !!!");
                                        }
                            });
                   
                }
                else
                {
                   alert( 'Registeration Failed !!!') ;                   
                }
                //alert(data[0].ResultID);
            }
        });
    }catch(err){alert(err.message)}
}
function XXX002(ParaProfileName ,ParaEmail , ParaPassword,ParaProfilePicture, ParaIsFaceBook,ParaIsGmail)
{
    try{
            //alert(ParaEmail);
            //alert(ParaEmail);
            //alert(ParaPassword);
            //alert(ParaProfilePicture);
            //alert(ParaIsFaceBook);
            //alert(ParaIsGmail);
            $("#ITGBtnSubmit").hide();
            $("#ITGImgSubmit").show();
        $.ajax({
            
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStudent.php?CallID=XXX001" +            
                    "&XXX01=" + encodeURIComponent( ParaProfileName) +
                    "&XXX02=" + encodeURIComponent( ParaEmail) +
                    "&XXX03=" + encodeURIComponent( ParaPassword) +
                    "&XXX04=" + encodeURIComponent( ParaProfilePicture) +
                    "&XXX05=" + encodeURIComponent( ParaIsFaceBook) +
                    "&XXX06=" + encodeURIComponent( ParaIsGmail) 
                    ,
            success: function (data) {                
                data = JSON.parse(data);
                //alert(data[0].ResultID);
                if(data[0].ResultID == 202)
                {                      
                    $('#myModal2').modal('toggle');
                    document.getElementById('ITGRegisterationEmail').value = '';
                    document.getElementById('ITGRegisterationPassword').value = '';
                    document.getElementById('ITGRegisterationPasswordConfirm').value = '';
                    $.ajax({            
                        //This will retrieve the contents of the folder if the folder is configured as 'browsable'
                        url: "API/ITGStudent.php?CallID=RegisterationMail" +            
                                "&XXX01=" + encodeURIComponent( ParaProfileName) +
                                "&XXX02=" + encodeURIComponent( ParaEmail) +
                                "&XXX03=" + encodeURIComponent( ParaPassword) +
                                "&XXX04=" + encodeURIComponent( ParaProfilePicture) +
                                "&XXX05=" + encodeURIComponent( ParaIsFaceBook) +
                                "&XXX06=" + encodeURIComponent( ParaIsGmail) 
                        ,
                    success: function (data) {

                    }
                    });
                    $.ajax({
                                //This will retrieve the contents of the folder if the folder is configured as 'browsable'
                                url: "API/ITGStudent.php?CallID=GetLogin" +            
                                        "&Email=" + encodeURIComponent( ParaEmail)
                                        ,
                                success: function (data) {                                                                                           
                                         $(location).attr('href', 'studentdashboard.php');                                                                                        
                                        //  bootbox.alert("Registered Successfully !!!");
                                        }
                            });
                            $("#ITGBtnSubmit").show();
                            $("#ITGImgSubmit").hide();
                    bootbox.alert(data[0].TransMessage.replace('Name' , 'Email'));                                        
                }
                else if (data[0].ResultID == 201)
                {
                    $("#ITGBtnSubmit").show();
                    $("#ITGImgSubmit").hide();
                   bootbox.alert(data[0].TransMessage.replace('Name' , 'Email'));
                }
                else
                {
                    bootbox.alert("Registeration Failed !!!");                                      
                }
                //alert(data[0].ResultID);
            }
        });
    }catch(err){alert(err.message)}
}