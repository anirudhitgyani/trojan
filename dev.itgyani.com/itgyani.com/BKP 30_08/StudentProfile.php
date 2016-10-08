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

<div class="panel-group" id="ITGStudentProfile">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#ITGStudentProfile" href="#ITGAcademic">
        Academic</a>
      </h4>
    </div>
    <div id="ITGAcademic" class="panel-collapse collapse in">
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-12 col-sm-offset-1">
                    <form class="form-inline" role="form">
                        <div class="form-group">
                            <label for="email" >High School:</label>                          
                        </div>
                        <div class="form-group" style="margin-left:5%; ">                          
                          <select id="ITG10Board" class="btn-warning chosen-select" style="width: 250px; z-index: 9999; margin-top: 5px;" tabindex="2">
                                </select>
                        </div>
                        <div class="form-group">                          
                            <input type="input" class="form-control input-sm" placeholder="school name" style="min-width:400px; " id="ITGSchoolName">
                        </div>
                        <div class="form-group">                          
                            <input type="input" class="form-control input-sm" placeholder="%" style="min-width:100px;max-width: 100px;text-align:center;  " maxlength="5" id="ITGSchoolPer">
                        </div>
                        <div class="form-group" style="margin-top: 6px;">                          
                          <select id="ITG10SchoolYear" class="btn-warning chosen-select" style="min-width: 100px;max-width: 100px; z-index: 9999; margin-top: 5px;" tabindex="2">
                                </select>
                        </div>
                        <div style="min-height:5px; "></div>
                        <div class="form-group" >
                          <label for="email">Pre Degree 12 th:</label>                          
                        </div>
                        <div class="form-group" style="margin-left:2%;margin-top: 14px; ">                          
                          <select id="ITG12Board" class="btn-warning chosen-select" style="width: 250px; z-index: 9999; " tabindex="2">
                                </select>
                        </div>
                        <div class="form-group">                          
                            <input type="input" class="form-control input-sm" placeholder="college name" style="min-width:400px; " id="ITGCollegeName">
                        </div>
                        <div class="form-group">                          
                          <input type="input" class="form-control input-sm" placeholder="%" style="min-width:100px;max-width: 100px;text-align:center;  " maxlength="5" id="ITGColPer">
                        </div>
                        <div class="form-group" style="margin-top: 6px;">                          
                          <select id="ITG12SchoolYear" class="btn-warning chosen-select" style="min-width: 100px;max-width: 100px; z-index: 9999; margin-top: 5px;" tabindex="2">
                                </select>
                        </div>
                        <div style="min-height:5px; "></div>
                        <div class="form-group" >
                          <label for="email">Graduation :</label>                          
                        </div>
                        <div class="form-group" style="margin-left:5%;margin-top: 6px; ">                          
                          <select id="ITGGraduation" class="btn-warning chosen-select" style="width: 250px; z-index: 9999; margin-left:  5px;" tabindex="2">
                                </select>
                        </div>
                        <div class="form-group">                          
                            <input type="input" class="form-control input-sm" placeholder="college name" style="min-width:400px; " id="ITGGraduationCollegeName">
                        </div>
                        <div class="form-group" style="margin-top: 6px; ">                          
                          <select id="ITGDegree" class="btn-warning chosen-select" style="width: 210px; z-index: 9999;" tabindex="2">
                                </select>
                        </div>
                        <div style="min-height:5px;background-color: gray;max-width:1100px;  "></div>
                        <div class="row" >
                            <div class="col-xs-12 col-xs-offset-3" >
                                <div class="form-group" >
                                    <label for="email">Year 1 :</label>                          
                                </div>
                                <div class="form-group" style="margin-top: 6px; ">                          
                                    <select id="ITGYear01PassingYear" class="btn-warning chosen-select" style="width: 100px; z-index: 9999;" tabindex="2">
                                 </select>
                                </div>
                                <div class="form-group">                          
                                    <input type="input" class="form-control input-sm" placeholder="%" style="min-width:100px;max-width: 100px;text-align:center;  " maxlength="5" id="ITGYear01PassingYearPer">
                                </div>
                                <br>
                                <div class="form-group" >
                                    <label for="email">Year 2 :</label>                          
                                </div>
                                <div class="form-group" style="margin-top: 6px; ">                          
                                    <select id="ITGYear02PassingYear" class="btn-warning chosen-select" style="width: 100px; z-index: 9999;" tabindex="2">
                                 </select>
                                </div>
                                <div class="form-group">                          
                                    <input type="input" class="form-control input-sm" placeholder="%" style="min-width:100px;max-width: 100px;text-align:center;  " maxlength="5" id="ITGYear02PassingYearPer">
                                </div>
                                <br>
                                <div class="form-group" >
                                    <label for="email">Year 3 :</label>                          
                                </div>
                                <div class="form-group" style="margin-top: 6px; ">                          
                                    <select id="ITGYear03PassingYear" class="btn-warning chosen-select" style="width: 100px; z-index: 9999;" tabindex="2">
                                 </select>
                                </div>
                                <div class="form-group">                          
                                    <input type="input" class="form-control input-sm" placeholder="%" style="min-width:100px;max-width: 100px;text-align:center;  " maxlength="5" id="ITGYear03PassingYearPer">
                                </div>
                                <br>
                                <div class="form-group" >
                                    <label for="email">Year 4 :</label>                          
                                </div>
                                <div class="form-group" style="margin-top: 6px; ">                          
                                    <select id="ITGYear04PassingYear" class="btn-warning chosen-select" style="width: 100px; z-index: 9999;" tabindex="2">
                                 </select>
                                </div>
                                <div class="form-group">                          
                                    <input type="input" class="form-control input-sm" placeholder="%" style="min-width:100px;max-width: 100px;text-align:center;  " maxlength="5" id="ITGYear04PassingYearPer">
                                </div>
                                <br>
                                <br>
                                <div class="form-group"> 
                                    <button type="button" class="form-control btn-danger" style="min-width:100px;max-width: 100px;text-align:center;margin-left:65px; " id="ITGBtnSaveAcademic"> Save </button>
                                    <button type="button" class="form-control btn-default" style="min-width:100px;max-width: 100px;text-align:center;" id="ITGBtnClearAcademic"> Clear </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#ITGStudentProfile" href="#Psychometric">
        Psychometric Evaluation</a>
      </h4>
    </div>
    <div id="Psychometric" class="panel-collapse collapse">
      <div class="panel-body"></div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#ITGStudentProfile" href="#ITGProgressReport">
        IT Gyani Progress reports</a>
      </h4>
    </div>
    <div id="ITGProgressReport" class="panel-collapse collapse">
      <div class="panel-body"></div>
    </div>
  </div>
  <div class="panel panel-danger">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#ITGStudentProfile" href="#ITGSJobProfile">
        Suited job profile</a>
      </h4>
    </div>
    <div id="ITGSJobProfile" class="panel-collapse collapse">
      <div class="panel-body"></div>
    </div>
  </div>
  <div class="panel panel-warning">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#ITGStudentProfile" href="#ITGSCareerGoal">
        Career Goal</a>
      </h4>
    </div>
    <div id="ITGSCareerGoal" class="panel-collapse collapse">
      <div class="panel-body"></div>
    </div>
  </div>
    <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#ITGStudentProfile" href="#ITGSBioData">
        Biodata</a>
      </h4>
    </div>
    <div id="ITGSBioData" class="panel-collapse collapse">
        <div class="panel-body">
            <div class="col-sm-12">
                    <form class="form-inline" role="form">
                        
                        <div class="form-group" style="margin-left:5%; ">                          
                          <input type="input" class="form-control input-sm" placeholder="last name" style="min-width:200px; " id="ITGLastName">
                        </div>
                        <div class="form-group">                          
                            <input type="input" class="form-control input-sm" placeholder="first name" style="min-width:200px; " id="ITGFirstName">
                        </div>
                        <div class="form-group">                          
                            <input type="input" class="form-control input-sm" placeholder="middle name" style="min-width:200px; " id="ITGMiddleName">
                        </div>
                        <div class="form-group">                          
                            <input type="input" class="form-control input-sm" placeholder="date of birth" style="min-width:200px; " id="ITGDBO">
                        </div>
                    </form>
        </div>
    </div>
  </div>
    
</div>
<script src="js/chosen.jquery.js"></script>

<script src="js/BrizBStandardJSPageStandardCodeGallery.js"></script>
<script src="JsAjax/ITGCore.js"></script>
<script src="JsAjax/ITGStudentProfile.js"></script>