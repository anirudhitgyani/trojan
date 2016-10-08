/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var UplArrRecords = [];
var IntArrayCounter = 0;
var ITGWaitForLoadCourse = setTimeout(function () {
        $(document).ready(function () {
            try {
                try {
                    clearTimeout(ITGWaitForLoadCourse);
                    // Add Handlers
                    document.getElementById("ITGBtnAddCourse").addEventListener("click", ITGyaniAddCourse);
                    document.getElementById("ITGBtnClearCourse").addEventListener("click", ITGyaniCancelCourse);
                    document.getElementById("ITGBtnSaveCourse").addEventListener("click", ITGyaniSaveCourse);
                    
                    document.getElementById("ITGBtnURLImport").addEventListener("click", ITGyaniImportURL);
                    document.getElementById("ITGBtnFAQImport").addEventListener("click", ITGyaniImportFAQ);
                    document.getElementById("ITGBtnQuestionSet").addEventListener("click", ITGyaniImportQSet);
                    document.getElementById("ITGBtnAdjust").addEventListener("click", ITGyaniAdjustDisplay);
                                        
                    document.getElementById("ITGyaniBtnShowURLDocFiles").addEventListener("click", ITGyaniReadTopics);
                    document.getElementById("ITGyaniBtnUploadURLDocFiles").addEventListener("click", ITGyaniUploadTopics);
                    
                    document.getElementById("ITGyaniBtnShowFAQDocFiles").addEventListener("click", ITGyaniReadFAQS);
                    document.getElementById("ITGyaniBtnUploadFAQDocFiles").addEventListener("click", ITGyaniUploadFAQ);
                    
                    document.getElementById("ITGyaniBtnShowQsetDocFiles").addEventListener("click", ITGyaniReadQSets);
                    document.getElementById("ITGyaniBtnUploadQSetDocFiles").addEventListener("click", ITGyaniUploadQSet);
                    //
                    
                    // Build Tree
                    ITGyaniBuildTree();
                    
                     $('#ITGBtnOpenFile').uploadify({
                            'swf'      : 'uploadify.swf',
                            'uploader' : 'uploadify.php',
                            'onError'      : function(errorType) {
                                alert('The error was: ' + errorType);
                                }
                            // Put your options here
                        });
                     $('#ITGBtnOpenFAQFile').uploadify({
                            'swf'      : 'uploadify.swf',
                            'uploader' : 'uploadify.php'
                            // Put your options here
                        });   
                       $('#ITGBtnOpenQSetFile').uploadify({
                            'swf'      : 'uploadify.swf',
                            'uploader' : 'uploadify.php'
                            // Put your options here
                        });   
                            
                }
                catch (err) {
                    alert(
                        err.message
                        );
                }
            }
            catch (err) {
                alert(err.message);
            }
            
        clearTimeout(ITGWaitForLoadCourse);
        });
        clearTimeout(ITGWaitForLoadCourse);                    }, 500);

function ITGyaniAdjustDisplay()
{
    try{
        
        if(document.getElementById('ITGSpnAdjust').innerHTML.trim() == "Maximize")
        {            
            document.getElementById('ITGSpnAdjust').innerHTML = 'Minimize';
            document.getElementById('ITGDtlCourse').className = "col-xs-12 col-sm-12 col-md-12 col-lg-12";
            $('#ITGTrvCourse').hide();
        }
        else
        {
            document.getElementById('ITGSpnAdjust').innerHTML = 'Maximize';
            document.getElementById('ITGDtlCourse').className = "col-xs-8 col-sm-8 col-md-8 col-lg-8 pull-right";
            $('#ITGTrvCourse').show();
        }
    }catch(err)
    {
        alert(err.message)
    }
}
function ITGyaniAddCourse()
{
    try
    {
            $("#ITGDivCourseName").show();
            $("#ITGBtnURLImport").hide();
            $("#ITGBtnFAQImport").hide();
            $("#ITGBtnQuestionSet").hide();
            BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID = 0;
            $("#ITGTxtCourseName").val("");$("#ITGTxtCourseDesc").val("");$("#ITGChkCourseActive").prop('checked', true);
            $("#ImgCourse").remove();$("#ITGTxtImageName").val("");
            $("#ITGDivURLImport").hide();
            $("#ITGDivFAQImport").hide();
            $("#ITGDivQuestionSetImport").hide();
            $('#ITGTrvCourse').jstree("deselect_all");
            $('#ITGBadCurrent').hide();
    }catch(err) {alert(err.message)}
}
function ITGyaniSaveCourse()
{
    try{
        if (document.getElementById('ITGTxtCourseName').value.toString().trim() == "") {
            BrizBVKStandardProcBootboxRequired("Please, Enter Course Name.", document.getElementById('ITGTxtCourseName'), "Min. 5 Character's, Max. 50 Character's", "Please, Enter Leagal Course Name As Per Institute Standard.", "i.e. [Foundation]");
                return;
            }
        if (document.getElementById('ITGTxtCourseName').value.toString().trim().length < 5) {
            BrizBVKStandardProcBootboxInvalid("Please, Enter Course Name.", document.getElementById('ITGTxtCourseName'), "Min. 5 Character's, Max. 50 Character's", "Please, Enter Leagal Course Name As Per Institute Standard.", "i.e. [Foundation]");
                return;
            }
        if (document.getElementById('ITGTxtCourseDesc').value.toString().trim() == "") {
            BrizBVKStandardProcBootboxRequired("Please, Enter Course Description.", document.getElementById('ITGTxtCourseDesc'), "Min. 15 Character's, Max. 500 Character's", "Please, Enter Leagal Course Description As Per Institute Standard.", "i.e. [Fundamental course covers all required fundamental aspect of computer ... etc.]");
                return;
            }
        if (document.getElementById('ITGTxtCourseDesc').value.toString().trim().length < 15) {
            BrizBVKStandardProcBootboxRequired("Please, Enter Course Description.", document.getElementById('ITGTxtCourseDesc'), "Min. 15 Character's, Max. 500 Character's", "Please, Enter Leagal Course Description As Per Institute Standard.", "i.e. [Fundamental course covers all required fundamental aspect of computer ... etc.]");
                return;
            }
        if(document.getElementById('ITGTxtImageName').value == "")
        {
            BrizBVKStandardProcBootboxRequired("Please, Select Course Image.", document.getElementById('ITGTxtImageName'), "Clock On Select Bar And Choose Image");
                return;
        }   
        var data ;
        var ObjCavImageContainer = document.createElement("canvas");
                    var ctx = ObjCavImageContainer.getContext("2d");
                    var ObjImgBinary = new Image();
                    ObjImgBinary.onload = function () {
                        ObjCavImageContainer.width = ObjImgBinary.width;
                        ObjCavImageContainer.height = ObjImgBinary.height;
                        ctx.drawImage(ObjImgBinary, 0, 0);
                        var data = ObjCavImageContainer.toDataURL("image/jpeg");
                        //alert(data)
                          
                        //alert(data);
                    };
                    ObjImgBinary.src = document.getElementById('ImgCourse').getAttribute('src');
                    var ObjDBSaveCourse = BrizBVKStandardObjGetHandler();
                    ObjDBSaveCourse.onreadystatechange = function ()
                    {
                            if (ObjDBSaveCourse.readyState == 4 && ObjDBSaveCourse.status == 200)
                            {
                                    var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                
                                    $.each($.parseJSON(ObjDBSaveCourse.responseText), function (key, TabValue) {
                                        if(TabValue.ResultID == 201)// Already Exist's
                                        {
                                            BrizBVKStandardProcBootboxAlreadyExists(TabValue.TransMessage,document.getElementById('ITGTxtCourseName'),"You Can Find Newly Added Course In Left Side Pan.","Do Verify Data By Clicking Course From Left Pan.")
                                            return;
                                        }
                                        else if (TabValue.ResultID == 202)// Added Successfully
                                        {
                                            BrizBVKStandardProcBootboxTransactionSuccessful(TabValue.TransMessage,document.getElementById('ITGTxtCourseName'),"You Can Find Newly Added Course In Left Side Pan.","Do Verify Data By Clicking Course From Left Pan.")                                            
                                            ITGyaniBuildTree(document.getElementById('ITGTxtCourseName').value);
                                            return;
                                        }
                                        else if (TabValue.ResultID == 203)// Failure
                                        {
                                        }
                                        else if (TabValue.ResultID == 204)// Updated Successfully
                                        {
                                        }
                                        else if (TabValue.ResultID == 205)// Deleted Successfully
                                        {
                                        }
                                        else if (TabValue.ResultID == 206)//Error
                                        {
                                        }
                                        else if (TabValue.ResultID == 207)
                                        {
                                            var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                                            BrizBVKStandardProcBootboxUnderMaintenance("OPPP'S. Site Is Under Maintinance.", document.getElementById('EwebTxtUserID'), TabValue.TransMessage);                                            
                                        }
                                        else if (TabValue.ResultID == 208)//Access Denied
                                        {
                                        }
                                        //ArrDownload.push(TabValue.downloads);
                                    });
                
                            }
                            else
                            {
                                return false;
                            }
                    }
                    
                
                        ObjDBSaveCourse.open("GET", "API/ITGStandardPHPPageCourse.php?CallID=Save&XXX01=" + encodeURIComponent( document.getElementById('ITGTxtCourseName').value) + "&XXX02=" + encodeURIComponent( document.getElementById('ITGTxtCourseDesc').value) + "&XXX03="+ document.getElementById('ITGTxtImageName').value + "&XXX04="+data+ "&XXX05="+(document.getElementById('ITGChkCourseActive').checked ? "1" : "0")+ "&XXX06=0"+ "&XXX07="+BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID);
                        ObjDBSaveCourse.setRequestHeader("Content-Type", "'application/json'");
                        ObjDBSaveCourse.send();  
            BrizBVKStandardProcShowStaticModel('Wait ... Saving ... !!! ...', 'red', false);
    }catch(err)
    {
        alert(err.message);
    }
}
function ITGyaniBuildTree(ParaITGCurrentNode)
{
    try{
                    $('#ITGTrvCourse').jstree("destroy").empty();
                    var ObjDBCourseTree = BrizBVKStandardObjGetHandler();
                    ObjDBCourseTree.onreadystatechange = function ()
                    {
                            if (ObjDBCourseTree.readyState == 4 && ObjDBCourseTree.status == 200)
                            {
                                    var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                                    //$.parseJSON(ObjDBCourseTree.responseText)
                                    $('#ITGTrvCourse').jstree({ 'core' : {
                                            'data' : $.parseJSON(ObjDBCourseTree.responseText)
                                    } });
                                   if( ParaITGCurrentNode)
                                   {
                                       var ITGSelectTimer = setTimeout(function () {
                                                 ITGyaniSelectNode(ParaITGCurrentNode, null);
                                                 clearTimeout(ITGSelectTimer);
                                            }, 1000);
                                   }                                   
                                       $("#ITGTrvCourse").bind(
                                                "select_node.jstree", function(evt, data){
                                                    //selected node object: data.inst.get_json()[0];
                                                    //selected node text: data.inst.get_json()[0].data
                                                    try{                                                        
                                                        //alert('selected called');
                                                        var id = $('#ITGTrvCourse').jstree(true).get_selected();
                                                        BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01 = $("#ITGTrvCourse").jstree().get_selected(true)[0].text ;
                                                        //alert(BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01 );
                                                        $("#ITGDivCourseName").show();
                                                        $("#ITGBtnURLImport").show();
                                                        $("#ITGBtnFAQImport").show();
                                                        $("#ITGBtnQuestionSet").show();
                                                        $("#ITGDivURLImport").hide();
                                                        $("#ITGDivFAQImport").hide();
                                                        $("#ITGDivQuestionSetImport").hide();
                                                        $('#ITGBadCurrent').show();
                                                        document.getElementById('ITGBadCurrent').style.display = "inline-block";
                                                        document.getElementById('ITGBadCurrent').innerHTML = $("#ITGTrvCourse").jstree().get_selected(true)[0].text;
                                                        BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID = id;
                                                        ITGyaniSelectNode(null , BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID);
                                                       // alert(BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID);
                                                        //$("#ITGTxtCourseName").val("");$("#ITGTxtCourseDesc").val("");$("#ITGChkCourseActive").prop('checked', true);
                                                        //$("#ImgCourse").remove();$("#ITGTxtImageName").val("");
                                                        //alert('called');
                                                }catch(err){alert(err.message);}
                                                }
                                        );
                                   
                
                            }
                            else
                            {
                                return false;
                            }
                    }
                    
                
                        ObjDBCourseTree.open("GET", "API/ITGStandardPHPPageCourse.php?CallID=TreeView");
                        ObjDBCourseTree.setRequestHeader("Content-Type", "'application/json'");
                        ObjDBCourseTree.send();  
            BrizBVKStandardProcShowStaticModel('Wait ... Pulling Course ... !!! ...', 'red', false);
    }catch(err)
    {alert(err.message)}
}
function ITGyaniSelectNode(ParaITGCurrentNode, ParaITGCurrentNodeID)
{
    try{
                
                    var ObjDBCurrentNode= BrizBVKStandardObjGetHandler();
                    ObjDBCurrentNode.onreadystatechange = function ()
                    {
                            if (ObjDBCurrentNode.readyState == 4 && ObjDBCurrentNode.status == 200)
                            {
                                    var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                                    
                                    $.each($.parseJSON(ObjDBCurrentNode.responseText), function (key, TabValue) {
                                        if(! ParaITGCurrentNodeID)
                                        {
                                            
                                            $('#ITGTrvCourse').jstree('select_node', TabValue.ID);
                                            
                                        }
                                        document.getElementById('ITGTxtCourseName').value = TabValue.CourseName;
                                        document.getElementById('ITGTxtCourseDesc').value = TabValue.CourseDesc;
                                    });
                                    
                                   
                
                            }
                            else
                            {
                                return false;
                            }
                    }
                        if(ParaITGCurrentNodeID)
                        {
                            //BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01
                            ObjDBCurrentNode.open("GET", "API/ITGStandardPHPPageCourse.php?CallID=CurrentNodeID&XXX01=" + encodeURIComponent( ParaITGCurrentNodeID.toString())  );
                        }
                        else
                        {
                            ObjDBCurrentNode.open("GET", "API/ITGStandardPHPPageCourse.php?CallID=CurrentNode&XXX01=" + encodeURIComponent( ParaITGCurrentNode.toLocaleString()) );
                        }
                        ObjDBCurrentNode.setRequestHeader("Content-Type", "'application/json'");
                        ObjDBCurrentNode.send();  
            BrizBVKStandardProcShowStaticModel('Wait ... Pulling Course ... !!! ...', 'red', false);
    }catch(err)
    {alert(err.message)}
}
function ITGyaniCancelCourse()
{
    try{
        
            $("#ITGDivCourseName").hide();
            $("#ITGBtnURLImport").hide();
            $("#ITGBtnFAQImport").hide();
            $("#ITGBtnQuestionSet").hide();
            BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID = 0;
            $("#ITGTxtCourseName").val("");$("#ITGTxtCourseDesc").val("");$("#ITGChkCourseActive").prop('checked', true);
            $("#ImgCourse").remove();$("#ITGTxtImageName").val("");
    //ObjImgBinary.src = document.getElementById('ImgCourse').getAttribute('src');
    //document.body.appendChild(ObjCavImageContainer);
    }catch(err){alert(err.message);}
}
function ITGyaniImportURL()
{
    try{
            $("#ITGDivCourseName").hide();
            $("#ITGDivURLImport").show();
            $("#ITGDivFAQImport").hide();
            $("#ITGDivQuestionSetImport").hide();
            $("#ITGyaniBtnUploadURLDocFiles").hide();
            $('#ITGDivQSetImport').hide();
            $('#ITGTblTopicImport > tbody').html("");
            $('#ITGyaniSelReadURLDocFiles').empty()
            document.getElementById("ITGyaniBtnReadURLDocFiles").addEventListener("click", ITGyaniReadFiles);
            FillTopicList();
            
    }catch(err)
    {
        alert(err.message)
    }
}
function ITGyaniImportFAQ()
{
    try{
        $("#ITGDivCourseName").hide();
        $("#ITGDivURLImport").hide();
        $("#ITGDivFAQImport").show();
        $("#ITGDivQuestionSetImport").hide();
        $('#ITGDivQSetImport').hide();
        $('#ITGTblTopicImport > tbody').html("");
        $('#ITGyaniSelReadURLDocFiles').empty()
        $('#ITGTblFAQImport > tbody').html("");
        $('#ITGyaniBtnUploadFAQDocFiles').hide();
            document.getElementById("ITGyaniBtnReadFAQFiles").addEventListener("click", ITGyaniReadFAQFiles);
            FillFAQList();
    }catch(err)
    {
        alert(err.message)
    }
}
function ITGyaniImportQSet()
{
    try{
        $("#ITGDivCourseName").hide();
        $("#ITGDivURLImport").hide();
        $("#ITGDivFAQImport").hide();
        $("#ITGDivQuestionSetImport").show();
        $('#ITGDivQSetImport').show();
        document.getElementById("ITGyaniBtnReadQSetFiles").addEventListener("click", ITGyaniReadQSetFiles);
        $('#ITGTblQSetImport > tbody').html("");
            FillQSetList();
    }catch(err)
    {
        alert(err.message)
    }
}
function ITGyaniReadFiles()
{
    try{
        //http://stackoverflow.com/questions/18480550/how-to-load-all-the-images-from-one-of-my-folder-into-my-web-page-using-jquery
        var dir = "Upload/";
        $('#ITGyaniSelReadURLDocFiles').empty();
            $.ajax({
                url : dir,
                success: function (data) {
                    $(data).find("a").attr("href", function (i, val) {
                        if( val.match(/\.(xlsx)$/) ) { 
                            val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');
                            val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');
                            $('#ITGyaniSelReadURLDocFiles').append($('<option>', {value:val, text:val}));
                            document.getElementById('ITGyaniBtnShowURLDocFiles').style.display = "inline-block";
                           // alert(val);
                            //$("body").append( "<img src='"+ folder + val +"'>" );
                        } 
                    });
                }
            });        
        
    }catch(err)
    {
        alert(err.message)
    }
}
function ITGyaniReadFAQFiles()
{
    try{
        //http://stackoverflow.com/questions/18480550/how-to-load-all-the-images-from-one-of-my-folder-into-my-web-page-using-jquery
        var dir = "Upload/";        
        $('#ITGyaniSelReadFAQDocFiles').empty();
        $('#ITGyaniBtnShowFAQDocFiles').hide();
            $.ajax({
                url : dir,
                success: function (data) {
                    $(data).find("a").attr("href", function (i, val) {
                        if( val.match(/\.(xlsx)$/) ) { 
                            val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');
                            val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');
                            $('#ITGyaniSelReadFAQDocFiles').append($('<option>', {value:val, text:val}));
                            document.getElementById('ITGyaniSelReadFAQDocFiles').style.display = "inline-block";
                            $('#ITGyaniBtnShowFAQDocFiles').show();
                            //alert(val);
                            //$("body").append( "<img src='"+ folder + val +"'>" );
                        } 
                    });
                }
            });        
        
        
        
    }catch(err)
    {
        alert(err.message)
    }
}

function ITGyaniReadQSetFiles()
{
    try{
        //http://stackoverflow.com/questions/18480550/how-to-load-all-the-images-from-one-of-my-folder-into-my-web-page-using-jquery
        var dir = "Upload/";        
        $('#ITGyaniSelReadQSetDocFiles').empty();
        $('#ITGyaniBtnShowQsetDocFiles').hide();
            $.ajax({
                url : dir,
                success: function (data) {
                    $(data).find("a").attr("href", function (i, val) {
                        if( val.match(/\.(xlsx)$/) ) { 
                            val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');
                            val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');val = val.replace('%20', ' ');
                            $('#ITGyaniSelReadQSetDocFiles').append($('<option>', {value:val, text:val}));
                            document.getElementById('ITGyaniSelReadQSetDocFiles').style.display = "inline-block";
                            $('#ITGyaniBtnShowQsetDocFiles').show();
                       //     alert(val);
                            //$("body").append( "<img src='"+ folder + val +"'>" );
                        } 
                    });
                }
            });                        
        
    }catch(err)
    {
        alert(err.message)
    }
}
function ITGyaniReadTopics()
{
    try{
        $("#ITGyaniBtnUploadURLDocFiles").hide();
        BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01 = $("#ITGTrvCourse").jstree().get_selected(true)[0].text + ".xlsx" ;
        var dir = "API/ITGStandardPHPPageCourse.php?CallID=ReadTopic&XXX01=" + encodeURIComponent( $('#ITGyaniSelReadURLDocFiles :selected').text())+ "&XXX02=" + encodeURIComponent(BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01);
        var fileextension = ".xlsx";
        $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: dir,
            success: function (data) {
                //List all .png file names in the page
                try{
                        var ErrState = 0;
                        $('#ITGTblTopicImport > tbody').html("");
                        $.each($.parseJSON(data), function (key, TabValue) { 
                            if(TabValue.TopSrNo == "-1")
                            {
                                ErrState = 1;
                                bootbox.alert( TabValue.ErrorDesc);                                
                                return false;
                            }
                        });
                            
                        
                        var IntIndex = 1;
                        $.each($.parseJSON(data), function (key, TabValue) { 
                           if(ErrState == 0)
                           {
                               if(TabValue.SrNo == null)
                               {
                                   TabValue.SrNo = "";
                               }
                               if(TabValue.Name == null)
                               {
                                   TabValue.Name = "";
                               }
                               if(TabValue.Desc == null)
                               {
                                   TabValue.Desc = "";
                               }
                               if(TabValue.URL01 == null)
                               {
                                   TabValue.URL01 = "";
                               }
                               if(TabValue.URL01Locked == null)
                               {
                                   TabValue.URL01Locked = "";
                               }
                               if(TabValue.URL02 == null)
                               {
                                   TabValue.URL02 = "";
                               }
                               if(TabValue.URL02Locked == null)
                               {
                                   TabValue.URL02Locked = "";
                               }
                               if(TabValue.URL03 == null)
                               {
                                   TabValue.URL03 = "";
                               }
                               if(TabValue.URL03Locked == null)
                               {
                                   TabValue.URL03Locked = "";
                               }
                               if(TabValue.URL04 == null)
                               {
                                   TabValue.URL04 = "";
                               }
                               if(TabValue.URL04Locked == null)
                               {
                                   TabValue.URL04Locked = "";
                               }
                               
                               if(TabValue.Doc01 == null)
                               {
                                   TabValue.Doc01 = "";
                               }
                               if(TabValue.Doc01Locked == null)
                               {
                                   TabValue.Doc01Locked = "";
                               }
                               if(TabValue.Doc02 == null)
                               {
                                   TabValue.Doc02 = "";
                               }
                               if(TabValue.Doc02Locked == null)
                               {
                                   TabValue.Doc02Locked = "";
                               }
                               if(TabValue.Doc03 == null)
                               {
                                   TabValue.Doc03 = "";
                               }
                               if(TabValue.Doc03Locked == null)
                               {
                                   TabValue.Doc03Locked = "";
                               }
                               if(TabValue.Doc04 == null)
                               {
                                   TabValue.Doc04 = "";
                               }
                               if(TabValue.Doc04Locked == null)
                               {
                                   TabValue.Doc04Locked = "";
                               }
                               
                                $TopicRow = '<td nowrap >' + TabValue.SrNo.toString().replace('null','') + '</td>';
                                $TopicRow += '<td nowrap >' + TabValue.Name.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Desc.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.URL01.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.URL01Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.URL02.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.URL02Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.URL03.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.URL03Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.URL04.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.URL04Locked.toString().replace('null','')  + '</td>';

                                $TopicRow += '<td nowrap>' + TabValue.Doc01.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Doc01Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Doc02.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Doc02Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Doc03.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Doc03Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Doc04.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Doc04Locked.toString().replace('null','')  + '</td>';
                                
                                $TopicRow += '<td nowrap>' + TabValue.Active.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Deleted.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.ChangeLog.toString().replace('null','')  + '</td>';
                            }
                            else
                            {
                                $TopicRow = '<td nowrap">' + TabValue.TopSrNo + '</td>';
                                $TopicRow += '<td nowrap">' + TabValue.Error + '</td>';
                                $TopicRow += '<td nowrap">' + TabValue.ErrorDesc + '</td>';
                            }
                            switch(IntIndex)
                            {
                                case 1:                                    
                                    $('#ITGTblTopicImport').append('<tr class="success">' + $TopicRow + '</tr>');                                    
                                    IntIndex = 2;
                                    break;
                                case 2:
                                    $('#ITGTblTopicImport').append('<tr class="danger">' + $TopicRow + '</tr>');
                                    IntIndex = 3;
                                    break;
                                case 3:
                                    $('#ITGTblTopicImport').append('<tr class="info">' + $TopicRow + '</tr>');
                                    IntIndex = 1;
                                    break;
                                default:
                                    break;
                            }
                               
                        });
                        var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if(ErrState == 0)
                                                {
                                                    $('#ITGyaniBtnUploadURLDocFiles').show();
                                                }
                                                else
                                                {
                                                    $('#ITGyaniBtnUploadURLDocFiles').hide();
                                                }
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                    }catch(err)
                    {alert(err.message);}
            }
        });
        BrizBVKStandardProcShowStaticModel('Wait ... Reading Excel ... !!! ...', 'red', false);
    }catch(err)
    {
        alert(err.message)
    }
}
function ITGyaniReadFAQS()
{
    try{
        $("#ITGyaniBtnUploadFAQDocFiles").hide();
        BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01 = $("#ITGTrvCourse").jstree().get_selected(true)[0].text + ".xlsx" ;
        var dir = "API/ITGStandardPHPPageCourse.php?CallID=ReadFAQ&XXX01=" + encodeURIComponent( $('#ITGyaniSelReadFAQDocFiles :selected').text())+ "&XXX02=" + encodeURIComponent(BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01);
        var fileextension = ".xlsx";
        $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: dir,
            success: function (data) {
                //List all .png file names in the page
                try{
                        var ErrState = 0;
                        $('#ITGTblFAQImport > tbody').html("");
                        $.each($.parseJSON(data), function (key, TabValue) { 
                            if(TabValue.FAQSrNo == "-1")
                            {
                                ErrState = 1;
                                bootbox.alert( TabValue.ErrorDesc);                                
                                return false;
                            }
                        });
                                                    
                        var IntIndex = 1;
                        $.each($.parseJSON(data), function (key, TabValue) { 
                            
                           if(ErrState == 0)
                           {
                               if(TabValue.FAQNo == null)
                               {
                                   TabValue.FAQNo = "";
                               }
                               if(TabValue.FAQ == null)
                               {
                                   TabValue.FAQ = "";
                               }
                               if(TabValue.Answer == null)
                               {
                                   TabValue.Answer = "";
                               }
                              // alert('called');
                                $TopicRow = '<td nowrap >' + TabValue.FAQNo.toString().replace('null','') + '</td>';
                                $TopicRow += '<td nowrap >' + TabValue.FAQ.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Answer.toString().replace('null','')  + '</td>';
                                
                                $TopicRow += '<td nowrap>' + TabValue.Active.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.Deleted.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td nowrap>' + TabValue.ChangeLog.toString().replace('null','')  + '</td>';
                            }
                            else
                            {
                                $TopicRow = '<td nowrap">' + TabValue.FAQSrNo + '</td>';
                                $TopicRow += '<td nowrap">' + TabValue.Error + '</td>';
                                $TopicRow += '<td nowrap">' + TabValue.ErrorDesc + '</td>';
                            }
                            //alert($TopicRow );
                            switch(IntIndex)
                            {
                                case 1:                                    
                                    $('#ITGTblFAQImport').append('<tr class="success">' + $TopicRow + '</tr>');                                    
                                    IntIndex = 2;
                                    break;
                                case 2:
                                    $('#ITGTblFAQImport').append('<tr class="danger">' + $TopicRow + '</tr>');
                                    IntIndex = 3;
                                    break;
                                case 3:
                                    $('#ITGTblFAQImport').append('<tr class="info">' + $TopicRow + '</tr>');
                                    IntIndex = 1;
                                    break;
                                default:
                                    break;
                            }
                               
                        });
                        var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if(ErrState == 0)
                                                {
                                                    $('#ITGyaniBtnUploadFAQDocFiles').show();
                                                }
                                                else
                                                {
                                                    $('#ITGyaniBtnUploadFAQDocFiles').hide();
                                                }
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                    }catch(err)
                    {alert(err.message);}
            }
        });
        BrizBVKStandardProcShowStaticModel('Wait ... Reading Excel ... !!! ...', 'red', false);
    }catch(err)
    {
        alert(err.message)
    }
}

function ITGyaniReadQSets()
{
    try{
        $("#ITGyaniBtnUploadQSetDocFiles").hide();
        BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01 = $("#ITGTrvCourse").jstree().get_selected(true)[0].text + ".xlsx" ;
        var dir = "API/ITGStandardPHPPageCourse.php?CallID=ReadSQSet&XXX01=" + encodeURIComponent( $('#ITGyaniSelReadQSetDocFiles :selected').text())+ "&XXX02=" + encodeURIComponent(BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01);
        var fileextension = ".xlsx";
        //alert('called');
        $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: dir,
            success: function (data) {
                //List all .png file names in the page
                //alert(data);
                try{
                        var ErrState = 0;
                        $('#ITGTblQSetImport > tbody').html("");
                        $.each($.parseJSON(data), function (key, TabValue) { 
                            if(TabValue.QSetSrNo == "-1")
                            {
                                ErrState = 1;
                                bootbox.alert( TabValue.ErrorDesc);                                
                                return false;
                            }
                        });
                                                    
                        var IntIndex = 1;
                        $.each($.parseJSON(data), function (key, TabValue) { 
                            //alert(data)
                           if(ErrState == 0)
                           {
                               if(TabValue.QTopID == null)
                               {
                                   TabValue.QTopID = "";
                               }
                               if(TabValue.QSetSrNo == null)
                               {
                                   TabValue.QSetSrNo = "";
                               }
                               if(TabValue.Question == null)
                               {
                                   TabValue.Question = "";
                               }
                               if(TabValue.Answer01 == null)
                               {
                                   TabValue.Answer01 = "";
                               }
                               if(TabValue.Answer01Correct == null)
                               {
                                   TabValue.Answer01Correct = "";
                               }
                               if(TabValue.Answer02 == null)
                               {
                                   TabValue.Answer02 = "";
                               }
                               if(TabValue.Answer02Correct == null)
                               {
                                   TabValue.Answer02Correct = "";
                               }
                               if(TabValue.Answer04 == null)
                               {
                                   TabValue.Answer04 = "";
                               }
                               if(TabValue.Answer04Correct == null)
                               {
                                   TabValue.Answer04Correct = "";
                               }
                               if(TabValue.AnswerInTime == null)
                               {
                                   TabValue.AnswerInTime = "";
                               }
                               if(TabValue.ControlType == null)
                               {
                                   TabValue.ControlType = "";
                               }
                               if(TabValue.Active == null)
                               {
                                   TabValue.Active = "";
                               }
                               if(TabValue.Deleted == null)
                               {
                                   TabValue.Deleted = "";
                               }
                               if(TabValue.ChangeLog == null)
                               {
                                   TabValue.ChangeLog = "";
                               }
                              // alert('called');
                                $QSetRow = '<td nowrap >' + TabValue.QTopID.toString().replace('null','') + '</td>';
                                $QSetRow += '<td nowrap >' + TabValue.QSetSrNo.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td nowrap>' + TabValue.Question.toString().replace('null','')  + '</td>';
                                
                                $QSetRow += '<td nowrap>' + TabValue.Answer01.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td nowrap>' + TabValue.Answer01Correct.toString().replace('null','')  + '</td>';
                                
                                $QSetRow += '<td nowrap>' + TabValue.Answer02.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td nowrap>' + TabValue.Answer02Correct.toString().replace('null','')  + '</td>';
                                
                                $QSetRow += '<td nowrap>' + TabValue.Answer03.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td nowrap>' + TabValue.Answer03Correct.toString().replace('null','')  + '</td>';
                                
                                $QSetRow += '<td nowrap>' + TabValue.Answer04.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td nowrap>' + TabValue.Answer04Correct.toString().replace('null','')  + '</td>';
                                
                                $QSetRow += '<td nowrap>' + TabValue.AnswerInTime.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td nowrap>' + TabValue.ControlType.toString().replace('null','')  + '</td>';
                                
                                $QSetRow += '<td nowrap>' + TabValue.Active.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td nowrap>' + TabValue.Deleted.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td nowrap>' + TabValue.ChangeLog.toString().replace('null','')  + '</td>';
                            }
                            else
                            {
                                //alert(TabValue.QSetSrNo);
                                $QSetRow = '<td nowrap">' + TabValue.QSetSrNo + '</td>';
                                $QSetRow += '<td nowrap">' + TabValue.Error + '</td>';
                                $QSetRow += '<td nowrap">' + TabValue.ErrorDesc + '</td>';
                            }
                            //alert($TopicRow );
                            switch(IntIndex)
                            {
                                case 1:                                    
                                    $('#ITGTblQSetImport').append('<tr class="success">' + $QSetRow + '</tr>');                                    
                                    IntIndex = 2;
                                    break;
                                case 2:
                                    $('#ITGTblQSetImport').append('<tr class="danger">' + $QSetRow + '</tr>');
                                    IntIndex = 3;
                                    break;
                                case 3:
                                    $('#ITGTblQSetImport').append('<tr class="info">' + $QSetRow + '</tr>');
                                    IntIndex = 1;
                                    break;
                                default:
                                    break;
                            }
                               
                        });
                        var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if(ErrState == 0)
                                                {
                                                    $('#ITGyaniBtnUploadQSetDocFiles').show();
                                                }
                                                else
                                                {
                                                    $('#ITGyaniBtnUploadQSetDocFiles').hide();
                                                }
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                    }catch(err)
                    {alert(err.message);}
            }
        });
        BrizBVKStandardProcShowStaticModel('Wait ... Reading Question Set Excel ... !!! ...', 'red', false);
    }catch(err)
    {
        alert(err.message)
    }
}
function FormatString(InputString)
{
    var result = '';
        for (var i=0; i < InputString.length; i++) {
                if(InputString.charAt(i) == "'")
                {
                   result +=  "''";
                }
                else
                {
                    result +=  InputString.charAt(i);
                }
            }
            return result;
}
function ITGyaniUploadTopics()
{
    try{
        $("#ITGyaniBtnUploadURLDocFiles").hide();
        BrizBVKStandardProcShowStaticModel('Wait ... Uploading Topic ... !!! ...', 'red', false);
        UplArrRecords.length = 0;
    //alert(FormatString('vijay'));
    $('#ITGTblTopicImport tr').each(function () {          
        $("#ITGyaniBtnUploadURLDocFiles").hide();
        UplArrRecords.push({
            SRNo:$(this).find('td:eq(0)').text(),
            TopicName:FormatString($(this).find('td:eq(1)').text()),
            TopicDesc:FormatString($(this).find('td:eq(2)').text()),
            URL01:FormatString($(this).find('td:eq(3)').text()),
            URL01Locked:$(this).find('td:eq(4)').text(),
            URL02:$(this).find('td:eq(5)').text(),
            URL02Locked:$(this).find('td:eq(6)').text(),
            URL03:$(this).find('td:eq(7)').text(),
            URL03Locked:$(this).find('td:eq(8)').text(),
            URL04:$(this).find('td:eq(9)').text(),
            URL04Locked:$(this).find('td:eq(10)').text(),
            Doc01:$(this).find('td:eq(11)').text(),
            Doc01Locked:$(this).find('td:eq(12)').text(),
            Doc02:$(this).find('td:eq(13)').text(),
            Doc02Locked:$(this).find('td:eq(14)').text(),
            Doc03:$(this).find('td:eq(15)').text(),
            Doc03Locked:$(this).find('td:eq(16)').text(),
            Doc04:$(this).find('td:eq(17)').text(),
            Doc04Locked:$(this).find('td:eq(18)').text(),
            Active:$(this).find('td:eq(19)').text(),
            Deleted:$(this).find('td:eq(20)').text(),
            ChangeLog:$(this).find('td:eq(21)').text()
        });
        
    });
    IntArrayCounter = 0;
    
    ITGyaniManageTopicTransactions();
    
    }catch(err){alert(err.message)}
}

function ITGyaniManageTopicTransactions()
{
    //alert(UplArrRecords[IntArrayCounter].SRNo)
    IntArrayCounter = IntArrayCounter + 1;
    if(UplArrRecords.length > IntArrayCounter)
    {
      //  alert($('#ITGTrvCourse').jstree(true).get_selected());
        $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStandardPHPPageCourse.php?CallID=UploadTopic&XXX01=" +
                    encodeURIComponent( $('#ITGTrvCourse').jstree(true).get_selected()) +
                    "&XXX02=" + encodeURIComponent( UplArrRecords[IntArrayCounter].SRNo) +
                    "&XXX03=" + encodeURIComponent( UplArrRecords[IntArrayCounter].TopicName) +
                    "&XXX04=" + encodeURIComponent( UplArrRecords[IntArrayCounter].TopicDesc) +
                    "&XXX05=" + encodeURIComponent( UplArrRecords[IntArrayCounter].URL01) +
                    "&XXX06=" + encodeURIComponent( UplArrRecords[IntArrayCounter].URL01Locked) +
                    "&XXX07=" + encodeURIComponent( UplArrRecords[IntArrayCounter].URL02) +
                    "&XXX08=" + encodeURIComponent( UplArrRecords[IntArrayCounter].URL02Locked) +
                    "&XXX09=" + encodeURIComponent( UplArrRecords[IntArrayCounter].URL03) +
                    "&XXX10=" + encodeURIComponent( UplArrRecords[IntArrayCounter].URL03Locked) +
                    "&XXX11=" + encodeURIComponent( UplArrRecords[IntArrayCounter].URL04) +
                    "&XXX12=" + encodeURIComponent( UplArrRecords[IntArrayCounter].URL04Locked) +
                    "&XXX13=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Doc01) +
                    "&XXX14=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Doc01Locked) +
                    "&XXX15=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Doc02) +
                    "&XXX16=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Doc02Locked) +
                    "&XXX17=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Doc03) +
                    "&XXX18=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Doc03Locked) +
                    "&XXX19=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Doc04) +
                    "&XXX20=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Doc04Locked) +
                    "&XXX21=" + encodeURIComponent( UplArrRecords[IntArrayCounter].ChangeLog) +
                    "&XXX22=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Active) +
                    "&XXX23=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Deleted) + 
                    "&XXX24=" + encodeURIComponent( '1') + 
                    "&XXX25=" + encodeURIComponent( '0') 
                    ,
            success: function (data) {
                data = JSON.parse(data);
                if(data[0].ResultID == 202 || data[0].ResultID == 201)
                {
                    ITGyaniManageTopicTransactions();
                }
                else
                {
                   var DiWaitTimer = setTimeout(function () {
                        var remove = document.getElementById('BrizBVKStandardDivMainContainer');                                                
                        if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                        FillTopicList();
                        bootbox.alert( data[0].TransMessage) 
                   }, 500);                   
                }
                //alert(data[0].ResultID);
            }
        });
        
    }
    else
    {
        var DiWaitTimer = setTimeout(function () {
            FillTopicList();
            var remove = document.getElementById('BrizBVKStandardDivMainContainer');                                                
            if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
       }, 500);
    }
}

function FillTopicList()
{
    $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStandardPHPPageCourse.php?CallID=GetTopicForGrid&XXX01=" +
                    encodeURIComponent( $('#ITGTrvCourse').jstree(true).get_selected()) 
                    ,
            success: function (data) {
                
                //data = JSON.parse(data);  
                /*
                $("#BrizBTblTopicDataGrid").dataTable({
                    "aaData": data, "paging": true, "bDestroy": true, "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]], "bAutoWidth": false, "bJQueryUI": false,
                    "aoColumns": [                        
                        { "mDataProp": "SrNo" },
                        { "mDataProp": "TopicName" },
                        { "mDataProp": "TopicDesc" },
                        { "mDataProp": "URL01" },
                        { "mDataProp": "URL01Locked" },
                        { "mDataProp": "URL02" },
                        { "mDataProp": "URL02Locked" },
                        { "mDataProp": "URL03" },
                        { "mDataProp": "URL03Locked" },
                        { "mDataProp": "URL04" },
                        { "mDataProp": "URL04Locked" },
                        { "mDataProp": "Doc01" },
                        { "mDataProp": "Doc01Locked" },
                        { "mDataProp": "Doc02" },
                        { "mDataProp": "Doc02Locked" },
                        { "mDataProp": "Doc03" },
                        { "mDataProp": "Doc03Locked" },
                        { "mDataProp": "Doc04" },
                        { "mDataProp": "Doc04Locked" },                        
                        { "mDataProp": "ChangeLog" },
                        { "mDataProp": "IsActive" },
                        { "mDataProp": "IsDeleted" }
                    ],
                    "columns": [
                        { "swidth": "20%" },
                        null,
                        { "width": "990%" },
                        null,
                        null
                    ]
                });*/
                //$("#BrizBTblTopicDataGrid").find("tr:gt(0)").remove();
                var TblTopic = $('#BrizBTblTopicDataGrid').DataTable();
                TblTopic.destroy();
                
                $("#BrizBTblTopicDataGrid > tbody").empty();
                //alert(data);
                $.each($.parseJSON(data), function (key, TabValue) {    
                                
                                $TopicRow = '<td  >' + TabValue.SrNo.toString().replace('null','') + '</td>';
                                $TopicRow += '<td >' + TabValue.TopicName.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.TopicDesc.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.URL01.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.URL01Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.URL02.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.URL02Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.URL03.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.URL03Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.URL04.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.URL04Locked.toString().replace('null','')  + '</td>';
                                    
                                $TopicRow += '<td >' + TabValue.Doc01.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.Doc01Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.Doc02.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.Doc02Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.Doc03.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.Doc03Locked.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.Doc04.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.Doc04Locked.toString().replace('null','')  + '</td>';
                                //alert($TopicRow);
                                $TopicRow += '<td >' + TabValue.IsActive.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.IsDeleted.toString().replace('null','')  + '</td>';
                                $TopicRow += '<td >' + TabValue.ChangeLog.toString().replace('null','')  + '</td>';
                                $('#BrizBTblTopicDataGrid').append('<tr >' + $TopicRow + '</tr>');                                                                                               
                        });
                        
                $('#BrizBTblTopicDataGrid').DataTable({    
            
                        scrollY: '50vh',
                        sScrollX: "100%",
                        sScrollXInner: "110%",
                        bScrollCollapse: true,
                        autoWidth:false  
                });
                
            //TblTopic.columns.adjust().draw( false );
                try {
                        var BrizBObjSelect;
                        for (BrizBCtrGridSearch = 0 ; BrizBCtrGridSearch < document.getElementsByTagName('select').length ; BrizBCtrGridSearch++) {
                            if (document.getElementsByTagName('select')[BrizBCtrGridSearch].innerHTML == '<option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option>') {
                                BrizBObjSelect = document.getElementsByTagName('select')[BrizBCtrGridSearch];
                            }
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[0] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[1] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[2] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[3] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[4] ; 
                        }
                        
                        // Search Button
                        var BrizBObjSearch = document.getElementById('BrizBTblTopicDataGrid_filter');
                        BrizBObjSearch = BrizBObjSearch.children[0].children[0];

                        var element = document.getElementById("BrizBTblTopicDataGrid_filter");
                        element.parentNode.removeChild(element);

                        BrizBObjSearch.className = "img-rounded";
                        BrizBObjSearch.id = "ObjBtnDataGridSearch";
                        BrizBObjSearch.placeholder = "Type Search ...";
                        BrizBObjSearch.style.fontSize = "1em";

                        // Add Search Button
                        // Add Div
                        var BrizBVKStandardSearch = document.createElement("div");
                        BrizBVKStandardSearch.id = 'BrizBVKStandardDivDataGridSearch';
                        BrizBVKStandardSearch.setAttribute("class", "col-sm-5");
                        BrizBVKStandardSearch.setAttribute("align", "center");
                        BrizBVKStandardSearch.setAttribute("display", "inline-block");
                        BrizBVKStandardSearch.setAttribute("padding", "5px");
                            
                        var BrizBVKStandardAddSearchImage = document.createElement('img');
                        BrizBVKStandardAddSearchImage.id = 'BrizBVKStandardBtnSearchImage';
                        BrizBVKStandardAddSearchImage.src = "Images\\Filter.ico";
                        BrizBVKStandardAddSearchImage.height = 30;
                        BrizBVKStandardAddSearchImage.width = 30;
                        BrizBVKStandardAddSearchImage.float = "right";
                        BrizBVKStandardAddSearchImage.setAttribute("display", "inline-block");
                        BrizBVKStandardAddSearchImage.setAttribute("class", "img-thumbnail");
                        BrizBVKStandardAddSearchImage.setAttribute("height", "40");
                        BrizBVKStandardAddSearchImage.setAttribute("width", "40");
                        BrizBVKStandardSearch.appendChild(BrizBVKStandardAddSearchImage);
                        BrizBVKStandardSearch.appendChild(BrizBObjSearch);
                        
                            
                        //
                        document.getElementsByClassName('dataTables_length')[0].innerHTML = "";
                        BrizBObjSelect.display = "inline-block";
                        BrizBObjSelect.margin = "10px";
                        BrizBObjSelect.setAttribute("class", "btn-primary BrizBDataGridSelectRowsDropDown");
                        
                        var BrizBVKStandardSelectImg = document.createElement('img');
                        BrizBVKStandardSelectImg.id = 'BrizBVKStandardBtnServer1';
                        BrizBVKStandardSelectImg.src = "Images\\Nike - Red.ico";
                        BrizBVKStandardSelectImg.height = 40;
                        BrizBVKStandardSelectImg.width = 50;

                        var BrizBVKStandardSelectText = document.createElement('label');
                        BrizBVKStandardSelectText.id = 'BrizBVKStandardBtnGidText';
                        BrizBVKStandardSelectText.innerHTML = "Select No Of Rows"
                        BrizBVKStandardSelectText.setAttribute("class", "BrizBDataGridSelectRowsLabel");
                        BrizBVKStandardSelectText.setAttribute("fontfamily", "seirf");
                        
                        
                        // Add Div
                        //var BrizBVKStandardTransaction = document.createElement("div");
                        //BrizBVKStandardTransaction.id = 'BrizBVKStandardDivDataGridTopicTransaction';
                        //BrizBVKStandardTransaction.setAttribute("class", "col-sm-1");
                        //BrizBVKStandardTransaction.setAttribute("align", "center");


                        //BrizBVKStandardTransaction.appendChild(BrizBVKStandardAddButton);

                        // Import & Report Buttons
                        var BrizBVKStandardFeature = document.createElement("div");
                        BrizBVKStandardFeature.id = 'BrizBVKStandardDivDataGridFeatures';
                        BrizBVKStandardFeature.setAttribute("class", "col-sm-2");
                        BrizBVKStandardFeature.setAttribute("align", "left");
                        
                        var BrizBVKStandardImportButton = document.createElement("button");
                        BrizBVKStandardImportButton.id = 'BrizBBtnStandardImport';
                        BrizBVKStandardImportButton.setAttribute("class", "btn btn-warning BrizBButtonFunctionality jdbpopup");
                        BrizBVKStandardImportButton.style = "background-color:maroon;margin-right:10px;";
                        BrizBVKStandardImportButton.setAttribute("type", "button");
                        
                        var BrizBVKStandardImportButtonLi = document.createElement("li");
                        BrizBVKStandardImportButtonLi.id = 'BrizBBtnStandardAddLi';
                        BrizBVKStandardImportButtonLi.setAttribute("class", "fa fa-file-excel-o 10px");
                        BrizBVKStandardImportButtonLi.innerHTML = "Export";

                        BrizBVKStandardImportButton.appendChild(BrizBVKStandardImportButtonLi);
                        BrizBVKStandardFeature.appendChild(BrizBVKStandardImportButton);
                        
                        //<button id="BrizBBtnStandardAdd" type="button" class="btn btn-warning BrizBButtonFunctionality jdbpopup" ><li class="fa fa-plus 10px"> Add </li></button>
                        //<button id="BrizBBtnStandardExport" type="button" class="btn btn-warning BrizBButtonFunctionality" style="background-color:maroon;" > <li class="fa fa-file-excel-o 10px" > Export </li></button>
                        //<button id="BrizBBtnStandardReport" type="button" class="btn btn-warning BrizBButtonFunctionality" style="background-color:lightskyblue;" ><li class="fa fa-sticky-note-o 10px" > Report </li></button>

                        document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardSelectText);
                        document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBObjSelect);
                        document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardSelectImg);
                        //document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardTransaction);
                        document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardFeature);
                        document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardSearch);

                        // 3. Add Button Event
                        //document.getElementById("BrizBBtnCloseDialogSave").addEventListener("click", BrizBStandardGroupValidateAndSaveData);
                         

                        $("#BrizBBtnStandardAddLi").animatedModal({
                            modalTarget: 'modal-02',
                            animatedIn: 'lightSpeedIn',
                            animatedOut: 'bounceOutDown',
                            color: 'lightgray',
                            // Callbacks
                            beforeOpen: function () {
                                try {
                                    if (document.getElementById('BrizBLblGroupManagement').innerHTML) {
                                        document.getElementById('BrizBLblGroupManagement').innerHTML = "System Group Management";
                                        $('.icheckbox_flat-red').attr("class", "icheckbox_flat-red checked");
                                        $('.icheckbox_flat-red').class = "icheckbox_flat-red checked";
                                       // alert('called');
                                    }
                                        document.getElementById("BrizBStandardDivMenuContainer").remove();
                                } catch (err) { alert(err.message); }
                            },
                            afterOpen: function () {
                                //console.log("The animation is completed");
                            },
                            beforeClose: function () {
                                //console.log("The animation was called");

                            },
                            afterClose: function () {
                                //document.body.appendChild(BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu);
                                //document.body.insertBefore(BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu, document.body.firstChild);
                                //BrizBStandardDivBodyContainer
                            }
                        });
                        $('#BrizBChkStandardActive').on('ifCreated ifClicked ifChanged ifChecked ifUnchecked ifDisabled ifEnabled ifDestroyed', function (event) {
                            if (this.checked) {
                                //alert('yes');
                            }
                        }).iCheck({
                            checkboxClass: 'icheckbox_flat-red',
                            radioClass: 'iradio_flat-red',
                            increaseArea: '20%'
                        });

                    } catch (err) { alert(err.message) }
            }
        });    
                    
}
function FillFAQList()
{
    $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStandardPHPPageCourse.php?CallID=GetFAQForGrid&XXX01=" +
                    encodeURIComponent( $('#ITGTrvCourse').jstree(true).get_selected()) 
                    ,
            success: function (data) {
                
                var TblFAQ = $('#BrizBTblFAQDataGrid').DataTable();
                TblFAQ.destroy();
                
                $("#BrizBTblFAQDataGrid > tbody").empty();
                //alert(data);
                $.each($.parseJSON(data), function (key, TabValue) {    
                                //alert(TabValue.SrNo.toString());
                                $FAQRow = '<td  >' + TabValue.SrNo.toString().replace('null','') + '</td>';
                                $FAQRow += '<td >' + TabValue.FAQ.toString().replace('null','')  + '</td>';
                                $FAQRow += '<td >' + TabValue.FAQAnswer.toString().replace('null','')  + '</td>';
                                
                                //alert($TopicRow);
                                $FAQRow += '<td >' + TabValue.IsActive.toString().replace('null','')  + '</td>';
                                $FAQRow += '<td >' + TabValue.IsDeleted.toString().replace('null','')  + '</td>';
                                $FAQRow += '<td >' + TabValue.ChangeLog.toString().replace('null','')  + '</td>';
                                $('#BrizBTblFAQDataGrid').append('<tr >' + $FAQRow + '</tr>');                                                                                               
                        });
                        
                $('#BrizBTblFAQDataGrid').DataTable({    
            
                        scrollY: '50vh',
                        sScrollX: "100%",
                        sScrollXInner: "110%",
                        bScrollCollapse: true,
                        autoWidth:false  
                });
                
            //TblTopic.columns.adjust().draw( false );
                try {
                        var BrizBObjSelect;
                        for (BrizBCtrGridSearch = 0 ; BrizBCtrGridSearch < document.getElementsByTagName('select').length ; BrizBCtrGridSearch++) {
                            if (document.getElementsByTagName('select')[BrizBCtrGridSearch].innerHTML == '<option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option>') {
                                BrizBObjSelect = document.getElementsByTagName('select')[BrizBCtrGridSearch];
                            }
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblFAQDataGrid_length')[0] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[0] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[1] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[2] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[3] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblTopicDataGrid_length')[4] ; 
                        }
                        
                        // Search Button
                        var BrizBObjSearch = document.getElementById('BrizBTblFAQDataGrid_filter');
                        BrizBObjSearch = BrizBObjSearch.children[0].children[0];
                        BrizBObjSearch.style="width:50%";

                        var element = document.getElementById("BrizBTblFAQDataGrid_filter");
                        element.parentNode.removeChild(element);

                        BrizBObjSearch.className = "img-rounded";
                        BrizBObjSearch.id = "ObjBtnDataGridSearchFAQ";
                        BrizBObjSearch.placeholder = "Type Search ...";
                        BrizBObjSearch.style.fontSize = "1em";
                        
                        // Add Search Button
                        // Add Div
                            
                        var BrizBVKStandardAddSearchImage = document.createElement('li');
                        BrizBVKStandardAddSearchImage.id = 'BrizBVKStandardBtnSearchImageFAQ';
                        BrizBVKStandardAddSearchImage.className = "fa fa-search fa-lg";
                        BrizBVKStandardAddSearchImage.style="color:yellow;text-shadow: 1px 1px 3px red;";
                        
                        BrizBObjSelect.display = "inline-block";
                        BrizBObjSelect.margin = "10px";
                        BrizBObjSelect.setAttribute("class", "btn-primary BrizBDataGridSelectRowsDropDown");

                        var BrizBVKStandardSelectText = document.createElement('label');
                        BrizBVKStandardSelectText.id = 'BrizBVKStandardBtnGidTextFAQ';
                        BrizBVKStandardSelectText.innerHTML = "Select No Of Rows"
                        BrizBVKStandardSelectText.setAttribute("class", "BrizBDataGridSelectRowsLabel");
                        BrizBVKStandardSelectText.setAttribute("fontfamily", "seirf");
                                                
                        var BrizBVKStandardImportButton = document.createElement("button");
                        BrizBVKStandardImportButton.id = 'BrizBBtnStandardImportFAQ';
                        BrizBVKStandardImportButton.setAttribute("class", "btn btn-warning BrizBButtonFunctionality jdbpopup");
                        BrizBVKStandardImportButton.style = "background-color:maroon;margin-right:10px;";
                        BrizBVKStandardImportButton.setAttribute("type", "button");
                        
                        var BrizBVKStandardImportButtonLi = document.createElement("li");
                        BrizBVKStandardImportButtonLi.id = 'BrizBBtnStandardAddLiFAQ';
                        BrizBVKStandardImportButtonLi.setAttribute("class", "fa fa-file-excel-o 10px");
                        BrizBVKStandardImportButtonLi.innerHTML = "Export";
                        BrizBVKStandardImportButton.appendChild(BrizBVKStandardImportButtonLi);
                        
                        var BrizBHeader = document.createElement("div");
                        BrizBHeader.appendChild(BrizBVKStandardImportButton);
                        BrizBHeader.appendChild(BrizBVKStandardSelectText);
                        BrizBHeader.appendChild(BrizBObjSelect);
                        
                        BrizBHeader.appendChild(BrizBVKStandardAddSearchImage);
                        BrizBHeader.appendChild(BrizBObjSearch);
                        document.getElementById('BrizBTblFAQDataGrid_length').innerHTML = "";
                        document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBHeader);
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBVKStandardSelectText);
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBObjSelect);
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBVKStandardSelectImg);
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBObjSearch);
                        
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBVKStandardTransaction);
                        
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBVKStandardAddSearchImage);
                            //alert(document.getElementsByClassName('dataTables_length').parent);
                        // 3. Add Button Event
                        //document.getElementById("BrizBBtnCloseDialogSave").addEventListener("click", BrizBStandardGroupValidateAndSaveData);
                         

                        $("#BrizBBtnStandardAddLiFAQ").animatedModal({
                            modalTarget: 'modal-02',
                            animatedIn: 'lightSpeedIn',
                            animatedOut: 'bounceOutDown',
                            color: 'lightgray',
                            // Callbacks
                            beforeOpen: function () {
                                try {
                                    if (document.getElementById('BrizBLblGroupManagement').innerHTML) {
                                        document.getElementById('BrizBLblGroupManagement').innerHTML = "System Group Management";
                                        $('.icheckbox_flat-red').attr("class", "icheckbox_flat-red checked");
                                        $('.icheckbox_flat-red').class = "icheckbox_flat-red checked";
                                       // alert('called');
                                    }
                                        document.getElementById("BrizBStandardDivMenuContainer").remove();
                                } catch (err) { alert(err.message); }
                            },
                            afterOpen: function () {
                                //console.log("The animation is completed");
                            },
                            beforeClose: function () {
                                //console.log("The animation was called");

                            },
                            afterClose: function () {
                                //document.body.appendChild(BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu);
                                //document.body.insertBefore(BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu, document.body.firstChild);
                                //BrizBStandardDivBodyContainer
                            }
                        });
                        $('#BrizBChkStandardActive').on('ifCreated ifClicked ifChanged ifChecked ifUnchecked ifDisabled ifEnabled ifDestroyed', function (event) {
                            if (this.checked) {
                                //alert('yes');
                            }
                        }).iCheck({
                            checkboxClass: 'icheckbox_flat-red',
                            radioClass: 'iradio_flat-red',
                            increaseArea: '20%'
                        });

                    } catch (err) { alert(err.message) }
            }
        });    
                    
}
function FillQSetList()
{
  $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStandardPHPPageCourse.php?CallID=GetQSetForGrid&XXX01=" +
                    encodeURIComponent( $('#ITGTrvCourse').jstree(true).get_selected()) 
                    ,
            success: function (data) {
                //alert('called')
                var TblQSet = $('#BrizBTblQSetDataGrid').DataTable();
                TblQSet.destroy();
                
                $("#BrizBTblQSetDataGrid > tbody").empty();
                //alert(data);
                $.each($.parseJSON(data), function (key, TabValue) {    
                            //    alert(TabValue.TopicName.toString());
                                $QSetRow = '<td  >' + TabValue.TopicName.toString().replace('null','') + '</td>';
                                $QSetRow += '<td >' + TabValue.TopicID.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.QuestionSetSrNo.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.Question.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.Answer01.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.IsAnswer01Ok.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.Answer02.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.IsAnswer02Ok.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.Answer03.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.IsAnswer03Ok.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.Answer04.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.IsAnswer04Ok.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.AnswerTimeInSec.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.ControlType.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.ChangeLog.toString().replace('null','')  + '</td>';                                
                                $QSetRow += '<td >' + TabValue.IsActive.toString().replace('null','')  + '</td>';
                                $QSetRow += '<td >' + TabValue.IsDeleted.toString().replace('null','')  + '</td>';
                                $('#BrizBTblQSetDataGrid').append('<tr >' + $QSetRow + '</tr>');                                                                                               
                        });
                      
                $('#BrizBTblQSetDataGrid').DataTable({                
                        scrollY: '50vh',
                        sScrollX: "100%",
                        sScrollXInner: "110%",
                        bScrollCollapse: true,
                        autoWidth:false  
                });
            
                try {
                        var BrizBObjSelect;
                        for (BrizBCtrGridSearch = 0 ; BrizBCtrGridSearch < document.getElementsByTagName('select').length ; BrizBCtrGridSearch++) {
                            if (document.getElementsByTagName('select')[BrizBCtrGridSearch].innerHTML == '<option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option>') {
                                BrizBObjSelect = document.getElementsByTagName('select')[BrizBCtrGridSearch];
                            }
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblQSetDataGrid_length')[0] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblQSetDataGrid_length')[0] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblQSetDataGrid_length')[1] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblQSetDataGrid_length')[2] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblQSetDataGrid_length')[3] ; 
                        }
                        if(!BrizBObjSelect)
                        {
                           BrizBObjSelect = document.getElementsByName('BrizBTblQSetDataGrid_length')[4] ; 
                        }
                        //alert(BrizBObjSelect)
                        
                        // Search Button
                        var BrizBObjSearch = document.getElementById('BrizBTblQSetDataGrid_filter');
                        BrizBObjSearch = BrizBObjSearch.children[0].children[0];
                        BrizBObjSearch.style="width:50%";

                        var element = document.getElementById("BrizBTblQSetDataGrid_filter");
                        element.parentNode.removeChild(element);

                        BrizBObjSearch.className = "img-rounded";
                        BrizBObjSearch.id = "ObjBtnDataGridSearchQSet";
                        BrizBObjSearch.placeholder = "Type Search ...";
                        BrizBObjSearch.style.fontSize = "1em";
                        
                        // Add Search Button
                        // Add Div
                            
                        var BrizBVKStandardAddSearchImage = document.createElement('li');
                        BrizBVKStandardAddSearchImage.id = 'BrizBVKStandardBtnSearchImageQSet';
                        BrizBVKStandardAddSearchImage.className = "fa fa-search fa-lg";
                        BrizBVKStandardAddSearchImage.style="color:yellow;text-shadow: 1px 1px 3px red;";
                        
                        BrizBObjSelect.display = "inline-block";
                        BrizBObjSelect.margin = "10px";
                        BrizBObjSelect.setAttribute("class", "btn-primary BrizBDataGridSelectRowsDropDown");

                        var BrizBVKStandardSelectText = document.createElement('label');
                        BrizBVKStandardSelectText.id = 'BrizBVKStandardBtnGidTextQSet';
                        BrizBVKStandardSelectText.innerHTML = "Select No Of Rows"
                        BrizBVKStandardSelectText.setAttribute("class", "BrizBDataGridSelectRowsLabel");
                        BrizBVKStandardSelectText.setAttribute("fontfamily", "seirf");
                                                
                        var BrizBVKStandardImportButton = document.createElement("button");
                        BrizBVKStandardImportButton.id = 'BrizBBtnStandardImportQSet';
                        BrizBVKStandardImportButton.setAttribute("class", "btn btn-warning BrizBButtonFunctionality jdbpopup");
                        BrizBVKStandardImportButton.style = "background-color:maroon;margin-right:10px;";
                        BrizBVKStandardImportButton.setAttribute("type", "button");
                        
                        var BrizBVKStandardImportButtonLi = document.createElement("li");
                        BrizBVKStandardImportButtonLi.id = 'BrizBBtnStandardAddLiQSet';
                        BrizBVKStandardImportButtonLi.setAttribute("class", "fa fa-file-excel-o 10px");
                        BrizBVKStandardImportButtonLi.innerHTML = "Export";
                        BrizBVKStandardImportButton.appendChild(BrizBVKStandardImportButtonLi);
                        
                        var BrizBHeader = document.createElement("div");
                        BrizBHeader.appendChild(BrizBVKStandardImportButton);
                        BrizBHeader.appendChild(BrizBVKStandardSelectText);
                        BrizBHeader.appendChild(BrizBObjSelect);
                        
                        BrizBHeader.appendChild(BrizBVKStandardAddSearchImage);
                        BrizBHeader.appendChild(BrizBObjSearch);
                        document.getElementById('BrizBTblQSetDataGrid_length').innerHTML = "";
                        document.getElementById('BrizBTblQSetDataGrid_length').appendChild(BrizBHeader);
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBVKStandardSelectText);
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBObjSelect);
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBVKStandardSelectImg);
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBObjSearch);
                        
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBVKStandardTransaction);
                        
                        //document.getElementById('BrizBTblFAQDataGrid_length').appendChild(BrizBVKStandardAddSearchImage);
                            //alert(document.getElementsByClassName('dataTables_length').parent);
                        // 3. Add Button Event
                        //document.getElementById("BrizBBtnCloseDialogSave").addEventListener("click", BrizBStandardGroupValidateAndSaveData);
                         

                        $("#BrizBBtnStandardAddLiQSet").animatedModal({
                            modalTarget: 'modal-02',
                            animatedIn: 'lightSpeedIn',
                            animatedOut: 'bounceOutDown',
                            color: 'lightgray',
                            // Callbacks
                            beforeOpen: function () {
                                try {
                                    if (document.getElementById('BrizBLblGroupManagement').innerHTML) {
                                        document.getElementById('BrizBLblGroupManagement').innerHTML = "System Group Management";
                                        $('.icheckbox_flat-red').attr("class", "icheckbox_flat-red checked");
                                        $('.icheckbox_flat-red').class = "icheckbox_flat-red checked";
                                       // alert('called');
                                    }
                                        document.getElementById("BrizBStandardDivMenuContainer").remove();
                                } catch (err) { alert(err.message); }
                            },
                            afterOpen: function () {
                                //console.log("The animation is completed");
                            },
                            beforeClose: function () {
                                //console.log("The animation was called");

                            },
                            afterClose: function () {
                                //document.body.appendChild(BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu);
                                //document.body.insertBefore(BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu, document.body.firstChild);
                                //BrizBStandardDivBodyContainer
                            }
                        });
                        $('#BrizBChkStandardActive').on('ifCreated ifClicked ifChanged ifChecked ifUnchecked ifDisabled ifEnabled ifDestroyed', function (event) {
                            if (this.checked) {
                                //alert('yes');
                            }
                        }).iCheck({
                            checkboxClass: 'icheckbox_flat-red',
                            radioClass: 'iradio_flat-red',
                            increaseArea: '20%'
                        });

                    } catch (err) { alert(err.message) }
            }
        });    
}
function ITGyaniUploadFAQ()
{
    try{
        $("#ITGyaniBtnUploadFAQDocFiles").hide();
        BrizBVKStandardProcShowStaticModel('Wait ... Uploading FAQ\'s ... !!! ...', 'red', false);
        UplArrRecords.length = 0;
    //alert(FormatString('vijay'));
    $('#ITGTblFAQImport tr').each(function () {          
        $("#ITGyaniBtnUploadFAQDocFiles").hide();
        if($(this).find('td:eq(1)').text().trim().length > 0)
        {
            UplArrRecords.push({
                SRNo:$(this).find('td:eq(0)').text(),
                FAQ:FormatString($(this).find('td:eq(1)').text()),
                Answer:FormatString($(this).find('td:eq(2)').text()),
                Active:$(this).find('td:eq(3)').text(),
                Deleted:$(this).find('td:eq(4)').text(),
                ChangeLog:$(this).find('td:eq(5)').text()
            });
        }
    });
    IntArrayCounter = 0;
    
    ITGyaniManageFAQTransactions();
    
    }catch(err){alert(err.message)}
}
function ITGyaniUploadQSet()
{
    try{
        $("#ITGyaniBtnUploadQSetDocFiles").hide();
        BrizBVKStandardProcShowStaticModel('Wait ... Uploading Question Set ... !!! ...', 'red', false);
        UplArrRecords.length = 0;
    //alert(FormatString('vijay'));
    $('#ITGTblQSetImport tr').each(function () {          
        $("#ITGyaniBtnUploadQSetDocFiles").hide();
        if($(this).find('td:eq(1)').text().trim().length > 0)
        {
            UplArrRecords.push({
                TopicID:$(this).find('td:eq(0)').text(),
                QuestionID:FormatString($(this).find('td:eq(1)').text()),
                Question:FormatString($(this).find('td:eq(2)').text()),
                Answer01:FormatString($(this).find('td:eq(3)').text()),
                Answer01Correct:FormatString($(this).find('td:eq(4)').text()),
                Answer02:FormatString($(this).find('td:eq(5)').text()),
                Answer02Correct:FormatString($(this).find('td:eq(6)').text()),
                Answer03:FormatString($(this).find('td:eq(7)').text()),
                Answer03Correct:FormatString($(this).find('td:eq(8)').text()),
                Answer04:FormatString($(this).find('td:eq(9)').text()),
                Answer04Correct:FormatString($(this).find('td:eq(10)').text()),
                AnswerTimeinSec:FormatString($(this).find('td:eq(11)').text()),
                ControlType:FormatString($(this).find('td:eq(12)').text()),
                Active:$(this).find('td:eq(13)').text(),
                Deleted:$(this).find('td:eq(14)').text(),
                ChangeLog:$(this).find('td:eq(15)').text()
            });
        }
    });
    IntArrayCounter = 0;
    
    ITGyaniManageQSetTransactions();
    
    }catch(err){alert(err.message)}
}

function ITGyaniManageFAQTransactions()
{
    //alert(UplArrRecords[IntArrayCounter].SRNo)
    //alert(UplArrRecords.length );
    //alert(IntArrayCounter);
    if(UplArrRecords.length > IntArrayCounter)
    {
        //alert(encodeURIComponent( UplArrRecords[IntArrayCounter].SRNo));
        $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStandardPHPPageCourse.php?CallID=UploadFAQ&XXX01=" +
                    encodeURIComponent( $('#ITGTrvCourse').jstree(true).get_selected()) +
                    "&XXX02=" + encodeURIComponent( UplArrRecords[IntArrayCounter].SRNo) +
                    "&XXX03=" + encodeURIComponent( UplArrRecords[IntArrayCounter].FAQ) +
                    "&XXX04=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer) +
                    "&XXX05=" + encodeURIComponent( UplArrRecords[IntArrayCounter].ChangeLog) +
                    "&XXX06=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Active) +
                    "&XXX07=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Deleted) + 
                    "&XXX08=" + encodeURIComponent( '1') + 
                    "&XXX09=" + encodeURIComponent( '0') 
                    ,
            success: function (data) {
               // alert(data);
                data = JSON.parse(data);
               // alert(data[0].ResultID);
                if(data[0].ResultID == 202 || data[0].ResultID == 201)
                {  
                    IntArrayCounter = IntArrayCounter + 1;
                    ITGyaniManageFAQTransactions();
                }
                else
                {
                   var DiWaitTimer = setTimeout(function () {
                        var remove = document.getElementById('BrizBVKStandardDivMainContainer');                                                
                        if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                        FillFAQList();
                        bootbox.alert( data[0].TransMessage) 
                   }, 500);                   
                }
                //alert(data[0].ResultID);
            }
        });
        
    }
    else
    {
        var DiWaitTimer = setTimeout(function () {
            FillFAQList();
            var remove = document.getElementById('BrizBVKStandardDivMainContainer');                                                
            if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
       }, 500);
    }
}
function ITGyaniManageQSetTransactions()
{
    //alert(UplArrRecords[IntArrayCounter].SRNo)
    //alert(UplArrRecords.length );
    //alert(IntArrayCounter);
    if(UplArrRecords.length > IntArrayCounter)
    {
        //alert($('#ITGTrvCourse').jstree(true).get_selected());
        $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStandardPHPPageCourse.php?CallID=UploadQSet&XXX01=" +
                    encodeURIComponent( $('#ITGTrvCourse').jstree(true).get_selected()) +
                    "&XXX02=" + encodeURIComponent( UplArrRecords[IntArrayCounter].TopicID) +
                    "&XXX03=" + encodeURIComponent( UplArrRecords[IntArrayCounter].QuestionID) +
                    "&XXX04=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Question) +
                    "&XXX05=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer01) +
                    "&XXX06=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer01Correct) +
                    "&XXX07=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer02) +
                    "&XXX08=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer02Correct) +
                    "&XXX09=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer03) +
                    "&XXX10=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer03Correct) +
                    "&XXX11=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer04) +
                    "&XXX12=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Answer04Correct) +
                    "&XXX13=" + encodeURIComponent( UplArrRecords[IntArrayCounter].AnswerTimeinSec) +
                    "&XXX14=" + encodeURIComponent( UplArrRecords[IntArrayCounter].ControlType) +
                    "&XXX15=" + encodeURIComponent( UplArrRecords[IntArrayCounter].ChangeLog) +
                    "&XXX16=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Active) +
                    "&XXX17=" + encodeURIComponent( UplArrRecords[IntArrayCounter].Deleted) + 
                    "&XXX18=" + encodeURIComponent( '1') + 
                    "&XXX19=" + encodeURIComponent( '0') 
                    ,
            success: function (data) {
               // alert(data);
                data = JSON.parse(data);
               // alert(data[0].ResultID);
                if(data[0].ResultID == 202 || data[0].ResultID == 201)
                {  
                    IntArrayCounter = IntArrayCounter + 1;
                    ITGyaniManageQSetTransactions();
                }
                else
                {
                   var DiWaitTimer = setTimeout(function () {
                        var remove = document.getElementById('BrizBVKStandardDivMainContainer');                                                
                        if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                        FillQSetList();
                        //FillFAQList();
                        bootbox.alert( data[0].TransMessage) 
                   }, 500);                   
                }
                //alert(data[0].ResultID);
            }
        });
        
    }
    else
    {
        var DiWaitTimer = setTimeout(function () {
            FillQSetList();
            var remove = document.getElementById('BrizBVKStandardDivMainContainer');                                                
            if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
       }, 500);
    }
}