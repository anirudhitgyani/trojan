<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
session_start();
//echo print_r($_SESSION['profile']);
 
$Profile = $_SESSION['profile'];
//echo print_r( $Profile);
//echo '</br>';echo '</br>';echo '</br>';
//print_r($Profile[0]['ProfileName']);

?>
<!DOCTYPE html>
<html>
    <head>
            <meta charset="utf-8">
            <title>IT GYANI</title>
            <!-- Stylesheets -->
            <link href="css/bootstrap.css" rel="stylesheet">
            <link href="css/animate.css" rel="stylesheet">
            <link href="css/owl.css" rel="stylesheet">
            <link href="css/style.css" rel="stylesheet">
            <link rel="stylesheet" href="css/demo-slideshow.css">
            <link href="css/custom.css" rel="stylesheet">
            <link href="css/chosen.css" rel="stylesheet">
            <!-- Responsive -->
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
            <link href="css/responsive.css" rel="stylesheet">
            <link rel="stylesheet" href="css/jstree.css" />
            <link href="css/video-js.css" rel="stylesheet">
            <link rel="stylesheet" href="css/mediaelementplayer.css" />
            <link rel="stylesheet" href="css/ITGTopicTab.css" />
            <!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    </head>
    <body>
        <!--modal_two-->
	<div class="modal fade" id="myModal1" role="dialog">
    <div class="modal-dialog modal-lg modal_price">
      <div class="modal-content">
        <div class="modal-header text-center">
         <button type="button" class="btn btn-default pull-right" style="position:absolute;right:18px;top:8px" data-dismiss="modal">x</button>
          <h4 class="modal-title text-center" style="display:inline-block;color:#000">The ITGYANI Program - Get your first IT job. </h4>
        </div>
        <div class="wodry"></div>
        <div class="modal-body">
          <div class="row">
           <div class="col-md-8 col-sm-8 col-sm-offset-2 col-lg-8 col-lg-offset-2 col-md-offset-2" >
		   <!-- <p class="text-center">“Know What You Love, Love What You Know”</p> -->
		<div class="table-responsive">
		<table class="table table-bordered">
		<thead>
		<tr>
		<th style="width:243px"></th>
		<th style="text-align:center">Free</th>
		<th style="text-align:center"><i class="fa fa-inr" aria-hidden="true"></i> 25000/- </th>
		</tr>
		</thead>
		
		<tbody>
		<tr>
		<td>Aptitude test</td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Foundation course</td>
		<td style="color:orange">Partial</td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Guarantee</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Counseling</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Trainer access</td>
		<td style="color:orange">Partial</td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Psychometric evaluation</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Specialized training tests</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes<i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Corporate access</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Interview preparation</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		
		<tr>
		<td>Live environment training</td>
		<td class="font_red">No <i class="fa fa-times" aria-hidden="true"></i></td>
		<td class="bold_font">Yes <i class="fa fa-check" aria-hidden="true"></i></td>
		</tr>
		</tbody>
		</table>
		</div>
			<div class="two_buttons">
			<!-- <div class="col-md-5 col-sm-5"></div>
			<div class="col-md-3 col-sm-3"> -->
                <button type="button" class="btn btn-info join">Join Free <span class="fa fa-sign-in" ></span></button>
              <!-- </div> -->
			 <!--  <div class="col-md-1 col-sm-1"></div>
              <div class="col-md-3 col-sm-3"> -->
                <button type="button" class="btn  btn-info buy_now">Buy Now <span class="fa fa-money" ></span></button>
             <!--  </div> -->
             </div>
		<div class="clearFix"></div>
		</div>
          </div>
        </div>
        <div class="modal-footer">
			<p class="text-center" style="font-family:lucida sans;font-size:16px;font-weight:bold">Know What You Love, Love What You Do!</p>
          <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
        </div>
      </div>
    </div>
  </div>
	<!--modal_two-->
        <div class="container-fluid" style="padding:0px; ">
        <div class="well well-sm" style="background-color:lightcyan; ">
            <div class="row">
                <div class="col-sm-8 col-xs-8 col-md-8 col-lg-8">
                    <img src="images/Dashboard.jpg" height="50" width="50">
                </div>
                <div class="col-sm-2 col-xs-2 col-md-2 col-lg-2">
                    <p class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"><img src="images/Upgrade Now.png"></a></p>                    
                </div>
                <div class="col-sm-2 col-xs-2 col-md-2 col-lg-2">
                    <?php
                     if( trim( $Profile[0]['ProfilePicture']) != '')
                     {
                        echo  '<a href="#"><img class="img-circle" height=50 width=50 src="' .  $Profile[0]['ProfilePicture'] . '"  /></a>' ;
                     }
                     else
                     {
                         echo  '<a href="#"><img class="img-circle" height=50 width=50 src="images/ITGProfile.png"  /></a>' ;
                     }
                    ?>                    
                    <div class="dropdown pull-right">
                            <?php 
                               global $PrfileTitle;
                                if($Profile[0]['ProfileName'] == $Profile[0]['ProfileEmail'])
                                {
                                    $ProfileFiler = explode("@", $Profile[0]['ProfileEmail']);
                                    $PrfileTitle = $ProfileFiler[0]; // piece1                                    
                                }
                                else
                                {
                                    $PrfileTitle = $Profile[0]['ProfileName'];
                                }
                            ?>
                            <a href="#" data-toggle="dropdown" class="dropdown-toggle"><?php echo $PrfileTitle;?> <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="studentdashboard.php">Dashboard</a></li>
                                <li><a href="StudentProfile.php">Profile</a></li>
                                <li><a href="#">Resume</a></li>
                                <li><a href="#">Account</a></li>
                                <li><a href="logout.php">Logout </a></li>
                            </ul>
                    </div>
                </div>
            </div>
        </div>
            
  </div>
        
    </body>
    <script src="js/jquery.js"></script> 
<script src="js/bootstrap.min.js"></script>
<script src="js/bootbox.min.js"></script>
<script src="js/jstree.js"></script>




