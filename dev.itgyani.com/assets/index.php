<?php include('connection.php');
    if(isset($_SESSION['AdminID'])) {
        header("location:".$AdminPath."pages/dashboard/");
        exit();
    }
?>
<!DOCTYPE html>
<!-- 
Template Name: Metronic - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.3.6
Version: 4.6
Author: KeenThemes
Website: http://www.keenthemes.com/
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Dribbble: www.dribbble.com/keenthemes
Like: www.facebook.com/keenthemes
Purchase: http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes
Renew Support: http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
-->
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    <head>
        <meta charset="utf-8" />
        <title> ITGYANI | ADMIN </title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="<?php echo $AdminPath; ?>assets/global/css/components.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="<?php echo $AdminPath; ?>assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/layouts/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css" id="style_color" />
       <link href="<?php echo $AdminPath; ?>assets/global/css/login.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> </head>
    <!-- END HEAD -->

    <body class=" login">
        <!-- BEGIN LOGO -->
        <div class="logo">
            <a href="<?php echo $AdminPath; ?>">
 
                <img src="<?php echo $AdminPath; ?>assets/layouts/layout/img/logo.png" alt="logo" />
                </a>
        </div>
        <!-- END LOGO -->
        <!-- BEGIN LOGIN -->
        <div class="content">
            <!-- BEGIN LOGIN FORM -->
            <form class="login-form" id="login_form" action="<?php echo $AdminPath; ?>action/login.php" method="post">
                <input type="hidden" name="action" id="action" value="login"  /> 
                <h3 class="form-title font-green">Sign In</h3>
                <div id="login_err" style="display: none;" class="alert alert-danger display">
                    <button class="close" data-close="alert"></button>
                    <span> Enter Any Username And Password. </span>
                </div>
                <div id="error" style="display: none;" class="alert alert-danger display">
                    <button class="close" data-close="alert"></button>
                    <span> Your Username and Password Invalid </span>
                </div>
                <?php if(isset($_SESSION['error'])) { ?>
                    <div id="error" style="display: none;" class="alert alert-danger display">
                    <button class="close" data-close="alert"></button>
                    <span> <?php echo $_SESSION['error']; ?> </span>
                </div>
                <?php } unset($_SESSION['error']);?>
                <div class="form-group">
                    <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                    <label class="control-label visible-ie8 visible-ie9">Username</label>
                    <input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="Username" name="ProfileName" id="ProfileName" /> </div>
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Password</label>
                    <input class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="Password" name="ProfilePassword" id="ProfilePassword" /> </div>
                <div class="form-actions">
                    <button type="button" onclick="CheckLogin();" class="btn green uppercase">Login</button>
                    <!--<label class="rememberme check mt-checkbox mt-checkbox-outline">
                        <input type="checkbox" name="remember" id="remember" value="1" />Remember
                        <span></span>
                    </label>-->
                    <a href="javascript:;" id="forget-password" class="forget-password">Forgot Password?</a>
                </div>
                <img id="loader-img" style="display:none" alt="" src="<?php echo $RootPath; ?>images/loading_new.gif" width="100" height="100" align="center" />
            </form>
            <!-- END LOGIN FORM -->
            <!-- BEGIN FORGOT PASSWORD FORM -->
            <form class="forget-form" action="javascript:void(0);" method="post">
                <h3 class="font-green">Forget Password ?</h3>
                <p> Enter your e-mail address below to reset your password. </p>
                <div class="form-group">
                    <input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="Email" name="email" /> </div>
                <div class="form-actions">
                    <button type="button" id="back-btn" class="btn green btn-outline">Back</button>
                    <button type="submit" class="btn btn-success uppercase pull-right">Submit</button>
                </div>
            </form>
            <!-- END FORGOT PASSWORD FORM -->
            
        </div>
       
        <!--[if lt IE 9]>
<script src="../assets/global/plugins/respond.min.js"></script>
<script src="../assets/global/plugins/excanvas.min.js"></script> 
<![endif]-->
<script src="<?php echo $AdminPath; ?>assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="<?php echo $AdminPath; ?>assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="<?php echo $AdminPath; ?>assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="<?php echo $AdminPath; ?>assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="<?php echo $AdminPath; ?>assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="<?php echo $AdminPath; ?>assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="<?php echo $AdminPath; ?>assets/global/scripts/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->
<!-- BEGIN THEME LAYOUT SCRIPTS -->
<script src="<?php echo $AdminPath; ?>assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).keypress(function(e) {
    if(e.which == 13) {
        CheckLogin();
    }
});
</script>
<script type="text/javascript">
function CheckLogin(){
    var flag = true;

    if($('#ProfileName').val()==''){
            $('#ProfileName').css('border','1px solid red');
            flag = false;
    } else {
            $('#ProfileName').css('border','1px solid #dde3ec');
    }

    if($('#ProfilePassword').val()==''){
            $('#ProfilePassword').css('border','1px solid red');
            flag = false;
    } else {
            $('#ProfilePassword').css('border','1px solid #dde3ec');
    }

    if(flag==false){
        $('#login_err').show();
        return false;
    } else {
        $('#login_err').hide();
        $('#login_form').submit();
//        $('#login_err').hide();
//        var datastring = $('#login_form').serialize();
//        $('#loader-img').show();
//        $.ajax({
//                method:'post',
//                url:"<?php echo $AdminPath; ?>action/login.php",
//                data:datastring,
//                success: function(resp){
//                    //alert(resp);
//                    $('#loader-img').hide();
//                    if(resp=="0"){
//                        $('#error').show();
//                    } else if(resp=="1"){
//                        $('#error').hide();
//                        window.location.href = "<?php echo $AdminPath; ?>pages/dashboard/";
//                    }
//                }
//        });
    } 
}
</script>
    </body>

</html>