

$(document).ready(function () {
   try{
       // Add Handlers
        document.getElementById("ITGBtnAddNew").addEventListener("click", ITGAddNewCareerPath);
        document.getElementById("ITGBtnSaveCareerPath").addEventListener("click", ITGValidateAndSaveCareerPath);
        
        document.getElementById("ITGBtnAddNew").click("slow");
        
       FillCareerPathList();
       //alert('called');
   }catch(err){alert(err.message)}
});

function ITGAddNewCareerPath()
{
    try{
        $("#IGDivDataEntry").toggle();
        if($('#IGDivDataEntry').css('display') != 'none')
            {
                $('#ITGChkCourseActive').prop('checked', true);
                ITGyaniBuildCourseList();
                BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID = 0;
            }
        
    }catch(err){alert(err.message)}
}
function ITGValidateAndSaveCareerPath()
{
    try{
        
    
                if(document.getElementById('ITGTxtCareerPathName').value.trim().length < 5)
                {
                    BrizBVKStandardProcBootboxRequired("Please, Enter Career Path.", document.getElementById('ITGTxtCareerPathName'), "Min. 5 Character's, Max. 50 Character's", "Please, Enter Career Path As Per IT Gyani Standard.", "----");
                    return;
                }
                if(document.getElementById('ITGTxtCareerPathDesc').value.trim().length < 10)
                {
                    BrizBVKStandardProcBootboxRequired("Please, Enter Career Path Description.", document.getElementById('ITGTxtCareerPathDesc'), "Min. 10 Character's, Max. 50 Character's", "Please, Enter Career Path Description As Per IT Gyani Standard.", "----");
                    return;
                }
                var CourseCount = 0;
                $('input[name^="ITGCourseList"]:checkbox').each(function(i){                    
                    if(this.checked)
                    {
                       CourseCount = CourseCount + 1; 
                    }
                 });
                 if(CourseCount == 0)
                {
                    BrizBVKStandardProcBootboxInvalid("Please, Select Course From Career Course's..", document.getElementById('ITGTxtCareerPathDesc'), "At Least One Course Need To Be Selected.", "Career Path Can't Be Without Course's.", "For Any Further Help Talk With Managment Team.");
                    return;
                }
                 $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
                            url: "API/ITGStandardPHPPageCareerPath.php?CallID=ManageCareerPath&XXX01=" +
                                encodeURIComponent( $("#ITGTxtCareerPathName").val()) +
                                "&XXX02=" + encodeURIComponent( $("#ITGTxtCareerPathDesc").val()) +
                                "&XXX03=" + encodeURIComponent( $("#ITGChkCourseActive").is(':checked') ? '1' : '0') +
                                "&XXX04=" + encodeURIComponent( "0") +
                                "&XXX05=" + encodeURIComponent( 0) +
                                "&XXX06=" + encodeURIComponent( BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID)  
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
    }catch(err){
        alert(err.message)
    }
}
// Code To Fill Treeview
function FillCareerPathList()
{
    $.ajax({
            //This will retrieve the contents of the folder if the folder is configured as 'browsable'
            url: "API/ITGStandardPHPPageCourse.php?CallID=GetFAQForGrid&XXX01=" +
                    encodeURIComponent( '1') 
                    ,
            success: function (data) {
                
                var TblFAQ = $('#BrizBTblCareerPathDataGrid').DataTable();
                TblFAQ.destroy();
                //$('#ITGTrvCourse').jstree(true).get_selected()
                $("#BrizBTblCareerPathDataGrid > tbody").empty();
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
                                $('#BrizBTblCareerPathDataGrid').append('<tr >' + $FAQRow + '</tr>');                                                                                               
                        });
                        
                $('#BrizBTblCareerPathDataGrid').DataTable({    
            
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
                           BrizBObjSelect = document.getElementsByName('BrizBTblCareerPathDataGrid_length')[0] ; 
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
                        var BrizBObjSearch = document.getElementById('BrizBTblCareerPathDataGrid_filter');
                        BrizBObjSearch = BrizBObjSearch.children[0].children[0];
                        BrizBObjSearch.style="width:50%";

                        var element = document.getElementById("BrizBTblCareerPathDataGrid_filter");
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
                        document.getElementById('BrizBTblCareerPathDataGrid_length').innerHTML = "";
                        document.getElementById('BrizBTblCareerPathDataGrid_length').appendChild(BrizBHeader);
                        //document.getElementById('BrizBTblCareerPathDataGrid_length').appendChild(BrizBVKStandardSelectText);
                        //document.getElementById('BrizBTblCareerPathDataGrid_length').appendChild(BrizBObjSelect);
                        //document.getElementById('BrizBTblCareerPathDataGrid_length').appendChild(BrizBVKStandardSelectImg);
                        //document.getElementById('BrizBTblCareerPathDataGrid_length').appendChild(BrizBObjSearch);
                        
                        //document.getElementById('BrizBTblCareerPathDataGrid_length').appendChild(BrizBVKStandardTransaction);
                        
                        //document.getElementById('BrizBTblCareerPathDataGrid_length').appendChild(BrizBVKStandardAddSearchImage);
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

function ITGyaniBuildCourseList(ParaITGCurrentNode)
{
    try{
                    
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
                                     $('#ITGDivCourseList').empty();                                    
                                    //alert(ObjDBCourseTree.responseText)
                                    $.each($.parseJSON(ObjDBCourseTree.responseText), function (key, TabValue) {
                                        $( "#ITGDivCourseList" ).append( "<div id='ITGDivCourse" + TabValue.id  + "' class='btn btn-danger' style='min-width:100%;text-align:left;'> " + TabValue.Parent  + " <input type='checkbox' name='ITGCourseList' value='value' id='ITGChkCourse" + TabValue.id  + "' class='pull-right'> </div>" );
                                        //alert(TabValue.id)
                                    });
                                   
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