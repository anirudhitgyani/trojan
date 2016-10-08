<?php
include_once('header.php');
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 * https://techblog.willshouse.com/2013/02/23/using-videojs-with-youtube/
 */

//echo print_r($_SESSION['profile']);
 
$Profile = $_SESSION['profile'];
//echo print_r( $Profile);
//echo '</br>';echo '</br>';echo '</br>';
//print_r($Profile[0]['ProfileName']);

?>
<!DOCTYPE html>

        <div class="container-fluid" style="padding:0px; ">
            <div id='ITGToolbar' class="row" style="margin-top: -20px;display:none;" >
                <div class="col-sm-5 col-sm-offset-1" > 
                    <form role="form">
                        <label> Topic </label>
                        <label class="radio-inline">
                          <input id='ITGOptVideo' type="radio" name="optradio">Video
                        </label>
                        <label class="radio-inline">
                          <input id='ITGOptDocuement' type="radio" name="optradio">Document
                        </label>
                        <select id='ITGSelTopic' class="btn btn-warning" style="min-width:200px; "></select>
                  </form>                    
                </div>
            </div>
            <div class="clearfix"></div>
            <div class="row"style=";min-height:80%; ">
                <div id='ITGTrvCourse' class="col-sm-1" style="min-height:80%;max-height:80;min-width:20%;    ">

                </div>
                <div id="ITGDivTopics" class="col-sm-10 pull-right" >

                </div>
            </div>
            
            
        </div>
<style type="text/css">
    .panel {
    /* border: aquamarine; */
    border-width: 2px;
}
.VideoDivider
{
    border-top-width: 2px;
    border-top-style: solid;
    border-top-color: #03a9f4;
    border-bottom-width: 2px;
    border-bottom-style: solid;
    border-bottom-color: #03a9f4;
    margin-bottom: 5px;
    background-color: lightgoldenrodyellow;
    font-family: fantasy;
    /* margin-left: 5px; */
    word-spacing: 2px;
}
</style>
<script src="js/BrizBStandardJSPageStandardCodeGallery.js"></script>
<script src="JsAjax/ITGStudentDashboard.js"></script>
<script src="js/videojs-ie8.min.js"></script>
<script src="js/video.js"></script>
<script src="js/Youtube.js"></script>
<script src="js/mediaelement-and-player.min.js"></script>
<script src="js/jquery.video-extend.js"></script>
<script type="text/javascript" src="js/flowplayer-3.1.4.min.js"></script>
