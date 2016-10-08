<?php
include_once('ITGHeader.php');
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

?>
<style>

      .filepicker-preview .thumbnail {
        max-width: 100px;
        display: inline-block;
      }
      
      .filepicker-preview .thumbnail img {
        max-width: 100%;
      }
      
    </style>
<script type="text/javascript" src="CoreJS.js"></script>
<link rel="stylesheet" type="text/css" href="CSS/BrizBVKStandardCSSCore.css" />
<link rel="stylesheet" type="text/css" href="CSS/BrizBVKStandardCSSTags.css" />
<script src="js/jquery-1.11.1.min.js"></script> 
<script src="js/bootbox.min.js"></script>
<script src="js/BrizBStandardJSPageStandardCodeGallery.js"></script> 
<script src="JsAjax/ITGStandardJSPageCareerPath.js"></script>   

<button id="ITGBtnAddNew" class="btn btn-danger" style="margin: 2px; " > Add New </button>
<br><br>
<div class="row">
    <div id="IGDivDataEntry">
    <div id="BrizBVKStandardFrmDataEntry" class="col-xs-8 col-sm-8 col-md-8 col-lg-8 ">
        
        <div class="row" id="ITGDivCareerPathName" style=" border-bottom-color:chocolate;border-bottom-style:none;border-bottom-width: 2px;   ">
                    <div class="row" style="padding:2% 0% 1% 0%;font-size:1em;font-weight:bold;   ">
                        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4" style="margin-top:1%; "  >
                            <span class="label label-success" style="padding:2px; ">Career Path Name</span>  
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8" >
                            <input id="ITGTxtCareerPathName"  class="form-control input-sm"  placeholder="Enter Career Path Name ..." type="text" style="min-width:90%; ">
                        </div>
                    </div>
                    <div class="row" style="padding:.5% 0% 1% 0%;font-size:1em;font-weight:bold;   ">
                        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4" style="margin-top:2%; " >
                            <span class="label label-success" style="padding:5px; ">Career Path Description</span>  
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8" >
                            
                            <textarea  class="form-control" id="ITGTxtCareerPathDesc" maxlength="500" rows="4" placeholder="Enter Career Path Description ..."></textarea>
                        </div>
                    </div>
                    <div class="row" style="padding:0% 0% 1% 0%;font-size:1em;fon