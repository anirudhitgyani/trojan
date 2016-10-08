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
    <link rel="stylesheet" type="text/css" href="CSS/BrizBVKStandardCSSCore.css" />
    <link rel="stylesheet" type="text/css" href="CSS/BrizBVKStandardCSSTags.css" />
    <link href="CSS/jquery.filer.css" type="text/css" rel="stylesheet" />
	<link href="CSS/themes/jquery.filer-dragdropbox-theme.css" type="text/css" rel="stylesheet" />

<div class="row">
    <div id="ITGTrvCourse" class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
        
    </div>    
    
    
    <div id="ITGDtlCourse" class="col-xs-8 col-sm-8 col-md-8 col-lg-8 pull-right"  >
        <div style="margin: 0px 0px 5px 0px; ">
            <span id="ITGBadCurrent" class="badge" style="text-align:center;font-size:1em;font-weight:bold;margin:2px;color:chocolate; display:none;  "></span>
            <button id="ITGBtnAddCourse" class="btn btn-primary" > Add Course</button>
            <button id="ITGBtnURLImport" class="btn btn-warning" style="display: none;" > Topics</button>
            <button id="ITGBtnFAQImport" class="btn btn-warning" style="display: none;"> FAQ's</button>
            <button id="ITGBtnQuestionSet" class="btn btn-danger" style="display: none;"> Question Set</button>
            
            <button id="ITGBtnAdjust" class="btn btn-default pull-right" > <span id="ITGSpnAdjust" style="font-weight:normal;font-family: sans-serif;letter-spacing: 2px;    " class="label label-danger"> Maximize </span></button>
        </div>
            
            <div id="BrizBVKStandardFrmDataEntry"  style="min-height:80%; ">
                <div class="row" id="ITGDivCourseName" style="min-height:78%; border-bottom-color:chocolate;border-bottom-style:solid;border-bottom-width: 2px;display:none;    ">
                    <div class="row" style="padding:2% 0% 1% 0%;font-size:2em;font-weight:bold;   ">
                        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4" style="margin-top:1%; "  >
                            <span class="label label-success" style="padding:5px; ">Course Name</span>  
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8" >
                            <input id="ITGTxtCourseName"  class="form-control input-sm"  placeholder="Enter Course Name" type="text" style="min-width