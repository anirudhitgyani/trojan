<?php include('connection.php'); 
$sql_user = mysql_query("select * from `profile` where ProfileID = '".$_SESSION['AdminID']."' ") or die(mysql_error());
$row_user = mysql_fetch_array($sql_user);
$Url =  'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
$ExplodeUrl = explode("/",$Url);
$Pagename = $ExplodeUrl[5];
$DetailPage = $ExplodeUrl[6];
?>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    <head>
        <meta charset="utf-8" />
        <title>Itgyani</title>
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
        <link href="<?php echo $AdminPath; ?>assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="<?php echo $AdminPath; ?>assets/global/css/components.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="<?php echo $AdminPath; ?>assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="<?php echo $AdminPath; ?>assets/layouts/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css" id="style_color" />
       <script src="<?php echo $AdminPath; ?>assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> </head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo">
        <div class="page-wrapper">
            <!-- BEGIN HEADER -->
            <div class="page-header navbar navbar-fixed-top">
                <!-- BEGIN HEADER INNER -->
                <div class="page-header-inner ">
                    <!-- BEGIN LOGO -->
                    <div class="page-logo">
                        <a href="<?php echo $AdminPath; ?>">
                            <img src="<?php echo $AdminPath; ?>assets/layouts/layout/img/logo.png" alt="logo" class="logo-default" /> </a>
                        <div class="menu-toggler sidebar-toggler">
                            <span></span>
                        </div>
                    </div>
                    <!-- END LOGO -->
                    <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                    <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
                        <span></span>
                    </a>
                    <!-- END RESPONSIVE MENU TOGGLER -->
                    <!-- BEGIN TOP NAVIGATION MENU -->
                    <div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                        
                            <li class="dropdown dropdown-user">
                                <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                    <img alt="" class="img-circle" src="<?php echo $AdminPath; ?>assets/layouts/layout/img/avatar3_small.jpg" />
                                    <span class="username username-hide-on-mobile"> <?php echo $row_user['ProfileName']; ?> </span>
                                    <i class="fa fa-angle-down"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-default">
                                    <li>
                                        <a href="page_user_profile_1.html">
                                            <i class="icon-user"></i> My Profile </a>
                                    </li>
                                    <li>
                                        <a href="app_calendar.html">
                                            <i class="icon-calendar"></i> My Calendar </a>
                                    </li>
                                    <li>
                                        <a href="app_inbox.html">
                                            <i class="icon-envelope-open"></i> My Inbox
                                            <span class="badge badge-danger"> 3 </span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="app_todo.html">
                                            <i class="icon-rocket"></i> My Tasks
                                            <span class="badge badge-success"> 7 </span>
                                        </a>
                                    </li>
                                    <li class="divider"> </li>
                                    <li>
                                        <a href="page_user_lock_1.html">
                                            <i class="icon-lock"></i> Lock Screen </a>
                                    </li>
                                    <li>
                                        <a href="<?php echo $AdminPath; ?>action/login.php?action=logout">
                                            <i class="icon-key"></i> Log Out </a>
                                    </li>
                                </ul>
                            </li>
                            <!-- END USER LOGIN DROPDOWN -->
                            <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                            <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                            
                            <!-- END QUICK SIDEBAR TOGGLER -->
                        </ul>
                    </div>
                    <!-- END TOP NAVIGATION MENU -->
                </div>
                <!-- END HEADER INNER -->
            </div>
            <!-- END HEADER -->
            <!-- BEGIN HEADER & CONTENT DIVIDER -->
            <div class="clearfix"> </div>
            <!-- END HEADER & CONTENT DIVIDER -->
            <!-- BEGIN CONTAINER -->
            <div class="page-container">
                <!-- BEGIN SIDEBAR -->
                <div class="page-sidebar-wrapper">
                    <!-- BEGIN SIDEBAR -->
                  
                    <div class="page-sidebar navbar-collapse collapse">
                        <!-- BEGIN SIDEBAR MENU -->
                       
                        <ul class="page-sidebar-menu  page-header-fixed " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 20px">
                           
                            <li class="sidebar-toggler-wrapper hide">
                                <div class="sidebar-toggler">
                                    <span></span>
                                </div>
                            </li>
                            <!-- END SIDEBAR TOGGLER BUTTON -->
                          
                            
                            <li class="heading">
                                <h3 class="uppercase">Features</h3>
                            </li> <li <?php if($Pagename=="dashboard") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?> >
                                <a href="<?php echo $AdminPath; ?>" class="nav-link">
                                    <i class="fa fa-book"></i>
                                    <span class="title">Home</span>
                                   
                                </a>
                                
                            </li>
                           <li <?php if($Pagename=="course") { ?> class="nav-item open" <?php } else { ?> class="nav-item" <?php } ?> >
                                <a href="javascript:void(0);" class="nav-link nav-toggle">
                                    <i class="fa fa-book"></i>
                                    <span class="title">Manage Courses</span>
                                    <span class="arrow "></span>
                                </a>
                                <ul id="course_sub" class="sub-menu" <?php if($Pagename=="course" || $Pagename=="topic" || $Pagename=="question_answers" || $Pagename=="faqs" || $Pagename=="category" ) { ?> style="display:block;" <?php } else { ?> style="display:none;" <?php } ?>  >
                                    <li <?php if($Pagename=="course") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?> >
                                        <a href="<?php echo $AdminPath; ?>pages/course/" class="nav-link">
                                            <i class="icon-power"></i> Course </a>
                                    </li>
                                    <li <?php if($Pagename=="topic") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?> >
                                        <a href="<?php echo $AdminPath; ?>pages/topic/" class="nav-link">
                                            <i class="icon-power"></i> Topic</a>
                                    </li>
                                    <li <?php if($Pagename=="question_answers") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?> >
                                        <a href="<?php echo $AdminPath; ?>pages/question_answers/" class="nav-link">
                                            <i class="icon-power"></i> Question & Answers</a>
                                    </li>
                                    <li <?php if($Pagename=="faqs") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?> >
                                        <a href="<?php echo $AdminPath; ?>pages/faqs/" class="nav-link">
                                            <i class="icon-power"></i> FAQ'S </a>
                                    </li>
                                    <li <?php if($Pagename=="category") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?> >
                                        <a href="<?php echo $AdminPath; ?>pages/category/" class="nav-link">
                                            <i class="icon-power"></i> Category </a>
                                    </li>
                                 </ul>
                            </li>
                            
                            
                            <li <?php if($Pagename=="users" || $Pagename=="invites") { ?> class="nav-item open" <?php } else { ?> class="nav-item" <?php } ?> >

                                <a href="javascript:;" class="nav-link nav-toggle">
                                    <i class="icon-folder"></i>
                                    <span class="title">Manage Account</span>
                                    <span class="arrow "></span>
                                </a>
                                <ul  class="sub-menu" <?php if($Pagename=="users" || $Pagename=="invites") { ?> style="display:block;" <?php } else { ?> style="display:none;" <?php } ?>  >
                                    <li <?php if($Pagename=="users") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?>>
                                        <a href="<?php echo $AdminPath; ?>pages/users/" class="nav-link">
                                            <i class="fa fa-user"></i> Manage User</a>
                                    </li>
                                    <li class="nav-item">

                                            <a href="javascript:;" class="nav-link nav-toggle">
                                                <i class="icon-folder"></i>
                                                <span class="title">Manage Corporate</span>
                                                <span class="arrow "></span>
                                            </a>
                                            <ul class="sub-menu" <?php if($DetailPage=="corporate.php" || $Pagename=="invites") { ?> style="display:block;" <?php } else { ?> style="display:none;" <?php } ?> >
                                                <li <?php if($DetailPage=="corporate.php") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?>>
                                                    <a href="<?php echo $AdminPath; ?>pages/users/corporate.php" class="nav-link">
                                                        <i class="fa fa-user"></i> Manage Corporate</a>
                                                </li>
                                                <li <?php if($Pagename=="invites") { ?> class="nav-item active" <?php } else { ?> class="nav-item" <?php } ?> >
                                                        <a href="<?php echo $AdminPath; ?>pages/invites/" class="nav-link nav-toggle">
                                                        <i class="icon-power"></i> Manage Interview Invites</a>
                                                        <span class="arrow "></span>
                                                </li>
                                            </ul>
                                    </li>
                                </ul>
                            </li>
                            
                            <li class="nav-item">

                                <a href="javascript:;" class="nav-link nav-toggle">
                                    <i class="icon-folder"></i>
                                    <span class="title">Manage User</span>
                                    <span class="arrow "></span>
                                </a>
                                <ul class="sub-menu">
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            <i class="fa fa-user"></i> Add User</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#" class="nav-link">
                                            <i class="fa fa-user"></i>Add HR / Corporate</a>
                                    </li>
                                </ul>
                            </li>
                            
                            
                            <li class="nav-item">
                                <a href="manage-email.html" class="nav-link">
                                    <i class="fa fa-envelope"></i>
                                    <span class="title">Manage Email</span>
                                   
                                </a>
                                
                            </li>
                            
                            <li class="nav-item">
                                <a href="<?php echo $AdminPath; ?>action/login.php?action=logout" class="nav-link">
                                    <i class="icon-power"></i>
                                    <span class="title">Log out</span>
                                   
                                </a>
                                
                            </li>
                            
                            
                            
                          
                        </ul>
                        <!-- END SIDEBAR MENU -->
                        <!-- END SIDEBAR MENU -->
                    </div>
                    <!-- END SIDEBAR -->
                </div>
                <!-- END SIDEBAR -->