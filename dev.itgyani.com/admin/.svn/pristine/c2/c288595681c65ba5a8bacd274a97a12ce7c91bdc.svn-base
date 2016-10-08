// Code Date     : 18-Mar-2015
// Developer Name: Vijay Katake.
// Version       : 1.0

// Functions.
// Function to create handler for retriving data from database.
// 
// Plugin info
// 1. Dropdown : http://jquery-plugins.net/bselect-custom-select-for-bootstrap , http://silviomoreto.github.io/bootstrap-select/
// 2. Export: http://ngiriraj.com/pages/htmltable_export/demo.php#
// 3. Awasome Font: http://fortawesome.github.io/Font-Awesome/3.2.1/
// 4. Treeview: http://www.jqueryrain.com/?7zg9QYD3 - ZTree
// 5. Verticle Form: http://www.bootply.com/pppeater/jrNvaahcOh
// 6. JTable: http://jtable.org/
// 7. Time Picker: https://fgelinas.com/code/timepicker/
function BrizBVKStandardObjGetHandler() {
        // Development Date: 08-Oct-2014
        // Specification: Commonly used DOM Request handler created here.
        //----------------------------------------------------------------
        var sgXmlHttp
        try {
            //Firefox, Opera 8.0+, Safari
            sgXmlHttp = new XMLHttpRequest();
        }
        catch (e) {
            //Internet Explorer
            try {
                sgXmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e) {
                try {
                    sgXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                catch (e) {
                    alert("Your browser does not support AJAX!")
                    return false;
                }
            }
        }
        return sgXmlHttp;
    }
function BrizBVKStandardObjReturnJSON(BrizBVKStandardStrURL)
{   
   try{ 
        var BrizBVKStandardJSONResult = sgGetHandler();
        BrizBVKStandardJSONResult.onreadystatechange = function ()
        {
            if (BrizBVKStandardJSONResult.readyState == 4 && BrizBVKStandardJSONResult.status == 200)
            {
                return $.parseJSON(BrizBVKStandardJSONResult.responseText);
                
            }
            else
            {
                // document.getElementById("sgTxtInput").value = "Call-Error";
                return false;
            }
        }
        BrizBVKStandardJSONResult.open("GET", BrizBVKStandardStrURL, true);
        BrizBVKStandardJSONResult.setRequestHeader("Content-Type", "'application/json'");
        BrizBVKStandardJSONResult.send();
    } catch (err)
    {
        alert(err.message)
    }
}
// Objects
// Global Transaction Object to store ongoing screen or transaction properties.
        var BrizBVKStandardObjTransaction = {
            BrizBVKStandardVarScreenMode: "", // Can be Add for new record, Edit for being updated record.
            BrizBVKStandardVarIntCurrentMasterRecordID: 0, // Probably used for record being updated. Primary key value is stored.
            BrizBVKStandardVarIntCurrentChildRecordID01: 0, // Probably used for sub-record being updated. Primary key value is stored.
            BrizBVKStandardVarIntCurrentChildRecordID02: 0, // Probably used for sub-record being updated. Primary key value is stored.
            BrizBVKStandardVarIntCurrentChildRecordID03: 0, // Probably used for sub-record being updated. Primary key value is stored.
            BrizBVKStandardVarIntCurrentChildRecordID04: 0, // Probably used for sub-record being updated. Primary key value is stored.
            BrizBVKStandardVarIntCurrentChildRecordID05: 0, // Probably used for sub-record being updated. Primary key value is stored.
            BrizBVKStandardVarIntRC: 0, // Probably used for sub-record being updated. Primary key value is stored.
            BrizBVKStandardVarCurrentTransactionLog: "", // Custom error message to be added at database whenever failure meet in transaction.
            BrizBVKStandardVarStrCurrentDataTableSQL: "", // Current data table to be initialized.
            BrizBVKStandardVarBoolProjectUnderDevelopment: false,
            BrizBVKStandardVarObjMenu : null,
            BrizBVKStandardVarStrAllRightsReserved: "All Right's Reserved @ 2016 By ITGyani",
            BrizBVKStandardVarStr01:""
        };
        
// Methods
// Static Model for wait loading 
        function BrizBVKStandardProcShowStaticModel(BrizBVKStandardVarStrParaAjaxLoadMessage, BrizBVKStandardVarColrParaAjaxLoadColor, BrizBVKStandardVarIntParaShowPercentage) {
            try{
                var BrizBVKStandardDivMainContainer = document.createElement("div");            
                BrizBVKStandardDivMainContainer.id = 'BrizBVKStandardDivMainContainer';
                BrizBVKStandardDivMainContainer.setAttribute("class", "modal show");
                document.body.appendChild(BrizBVKStandardDivMainContainer);
                // Add dialogue
                var BrizBVKStandardDivDialog = document.createElement("div");
                BrizBVKStandardDivDialog.id = 'BrizBVKStandardDivDialog';
                BrizBVKStandardDivDialog.setAttribute("class", "modal-dialog");
                BrizBVKStandardDivMainContainer.appendChild(BrizBVKStandardDivDialog);
                var BrizBVKStandardDivContent = document.createElement("div");
                BrizBVKStandardDivContent.id = 'BrizBVKStandardDivContent';
                BrizBVKStandardDivContent.setAttribute("class", "modal-content");
                BrizBVKStandardDivContent.style.top = "150px";
                BrizBVKStandardDivDialog.appendChild(BrizBVKStandardDivContent);
                // Add Header
                var BrizBVKStandardDivHeader = document.createElement("div");
                BrizBVKStandardDivHeader.id = 'BrizBVKStandardDivHeader';
                BrizBVKStandardDivHeader.setAttribute("class", "modal-header");
                BrizBVKStandardDivContent.appendChild(BrizBVKStandardDivHeader);
                BrizBVKStandardDivHeader.style.height = '65px';
                // Add Row In Header
                var BrizBVKStandardDivHeaderRow = document.createElement("div");
                BrizBVKStandardDivHeaderRow.id = 'BrizBVKStandardDivHeaderRow';
                BrizBVKStandardDivHeader.appendChild(BrizBVKStandardDivHeaderRow);
                // Add logo column to row
                var BrizBVKStandardDivLogoColumn = document.createElement("div");
                BrizBVKStandardDivLogoColumn.id = 'BrizBVKStandardDivLogoColumn';
                BrizBVKStandardDivLogoColumn.setAttribute("class", "col-sm-1 ");
                BrizBVKStandardDivHeaderRow.appendChild(BrizBVKStandardDivLogoColumn);
                // Add logo to column
                var BrizBVKStandardImgWait = document.createElement('img');
                BrizBVKStandardImgWait.id = "BrizBVKStandardImgWait";
                BrizBVKStandardImgWait.src = "Images\\BrizBImgProcessing.gif";
                BrizBVKStandardImgWait.float = "right";
                BrizBVKStandardDivLogoColumn.appendChild(BrizBVKStandardImgWait);
                // Add wait text column to row
                var BrizBVKStandardDivWaitTextColumn = document.createElement("div");
                BrizBVKStandardDivWaitTextColumn.id = 'BrizBVKStandardDivWaitTextColumn';
                BrizBVKStandardDivWaitTextColumn.setAttribute("class", "col-sm-9 col-xs-offset-1");
                BrizBVKStandardDivWaitTextColumn.setAttribute("align", "center");
                BrizBVKStandardDivHeaderRow.appendChild(BrizBVKStandardDivWaitTextColumn);
                // Add wait text
                var BrizBVKStandardHWaitText = document.createElement('h4');
                BrizBVKStandardHWaitText.id = "BrizBVKStandardHWaitText";
                BrizBVKStandardHWaitText.innerHTML = BrizBVKStandardVarStrParaAjaxLoadMessage;
                BrizBVKStandardHWaitText.style.color = BrizBVKStandardVarColrParaAjaxLoadColor;
                BrizBVKStandardHWaitText.setAttribute("class", "inline");
                BrizBVKStandardDivWaitTextColumn.appendChild(BrizBVKStandardHWaitText);
                // Add modeal body
                var BrizBVKStandardDivBody = document.createElement("div");
                BrizBVKStandardDivBody.id = 'BrizBVKStandardDivBody';
                BrizBVKStandardDivBody.setAttribute("class", "modal-body");
                BrizBVKStandardDivContent.appendChild(BrizBVKStandardDivBody);

                var BrizBVKStandardServerInstruction = document.createElement('label');
                BrizBVKStandardServerInstruction.id = 'BrizBVKStandardBtnServer';
                BrizBVKStandardServerInstruction.innerHTML = "Working At Server"
                BrizBVKStandardServerInstruction.setAttribute("class", "btn btn-danger");
                BrizBVKStandardDivBody.appendChild(BrizBVKStandardServerInstruction);

                var BrizBVKStandardServerImg = document.createElement('img');
                BrizBVKStandardServerImg.id = 'BrizBVKStandardBtnServer';
                BrizBVKStandardServerImg.src = "Images\\BrizBImgServer.gif";
                BrizBVKStandardServerImg.height = 50;
                BrizBVKStandardServerImg.width = 50;
                BrizBVKStandardServerImg.float = "right";
                BrizBVKStandardServerInstruction.appendChild(BrizBVKStandardServerImg);

                var BrizBVKStandardServerWaitUntil = document.createElement('div');
                BrizBVKStandardServerWaitUntil.id = 'BrizBVKStandardServerWaitUntil';
                BrizBVKStandardServerWaitUntil.setAttribute("class", "");
                BrizBVKStandardServerWaitUntil.style.display = "block";
                BrizBVKStandardDivBody.appendChild(BrizBVKStandardServerWaitUntil);

                var BrizBVKStandardServerWaitUntilImg = document.createElement('span');
                BrizBVKStandardServerWaitUntilImg.id = 'BrizBVKStandardServerWaitUntilImg';
                BrizBVKStandardServerWaitUntilImg.innerHTML = "  Please, Do Not Tamper With Screen Until Processing Is Done. Or Do Not Try To Perform Any Action.";
                BrizBVKStandardServerWaitUntilImg.setAttribute("class", "fa fa-chevron-circle-right");
                BrizBVKStandardServerWaitUntil.appendChild(BrizBVKStandardServerWaitUntilImg);

                var BrizBVKStandardCustomerCare = document.createElement('div');
                BrizBVKStandardCustomerCare.id = 'BrizBVKStandardCustomerCare';
                BrizBVKStandardCustomerCare.setAttribute("class", "");
                BrizBVKStandardCustomerCare.style.display = "block";
                BrizBVKStandardDivBody.appendChild(BrizBVKStandardCustomerCare);

                var BrizBVKStandardCustomerCareImg = document.createElement('span');
                BrizBVKStandardCustomerCareImg.id = 'BrizBVKStandardCustomerCareImg';
                BrizBVKStandardCustomerCareImg.innerHTML = "  For Any Abnormal Performance Delay Or Slowness, Call To Customer For Support.";
                BrizBVKStandardCustomerCareImg.setAttribute("class", "fa fa-chevron-circle-right");
                BrizBVKStandardCustomerCare.appendChild(BrizBVKStandardCustomerCareImg);

                var BrizBVKStandardRight = document.createElement('div');
                BrizBVKStandardRight.id = 'BrizBVKStandardRight';
                BrizBVKStandardRight.innerHTML = BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved
                BrizBVKStandardRight.setAttribute("class", "btn btn-danger");
                BrizBVKStandardDivBody.appendChild(BrizBVKStandardRight);
                //BrizBImgServer.gif
                $('#BrizBVKStandardDivMainContainer').modal({
                    backdrop: 'static',
                    keyboard: false
                })
                $("#BrizBVKStandardDivMainContainer").modal('show');
            } catch (BrizBVKStandardError) { bootbox.alert(BrizBVKStandardError.message); }
        }
        
      // function to reset model dialog when already appearing.
        function BrizBVKStandardObjResetShowStaticModel(BrizBVKStandardVarStrParaAjaxLoadMessage, BrizBVKStandardVarColrParaAjaxLoadColor, BrizBVKStandardVarIntParaShowPercentage) {
            try {
                    document.body.removeChild(document.getElementById("BrizBVKStandardDivMainContainer"));
                    BrizBVKStandardProcShowStaticModel(BrizBVKStandardVarStrParaAjaxLoadMessage, BrizBVKStandardVarColrParaAjaxLoadColor, BrizBVKStandardVarIntParaShowPercentage);
                }
                catch (e) {
                }
        }
//function to remove model dialog.
        function BrizBVKStandardFunRemoveWait() {
            document.body.removeChild(document.getElementById("BrizBVKStandardDivMainContainer"));
        }
// function to toggle div
        function BrizBVKStandardFunToggalTransaction(BrizBVKStandardParaDivId) {
            if ($("#" + BrizBVKStandardParaDivId.id.toString()).is(":visible") == true) {
                $("#" + BrizBVKStandardParaDivId.id.toString()).fadeOut();
                $("#" + BrizBVKStandardParaDivId.id.toString()).hide("slow");

            }
            else {
                $("#" + BrizBVKStandardParaDivId.id.toString()).show("slow");
                
            }
        }

// Standard methods to be executed for filling up dropdown.
        function BrizBVKStandardProcFillDropdown(BrizBVKStandardVarStrParaSQL, BrizBVKStandardObjControlName, BrizBVKStandardVarIntSelectedIndex, BrizBVKStandardVarBoolAllowSelect) {

            try {
                var BrizBVKStandardTmrLoad = setTimeout(function () {
                    $('#' + BrizBVKStandardObjControlName).css("display", "none");
                    $('#' + BrizBVKStandardObjControlName + 'TempImg').remove();
                    $('#' + BrizBVKStandardObjControlName + '_chzn').remove();
                    $('#' + BrizBVKStandardObjControlName).closest("div").append('<img id="' + BrizBVKStandardObjControlName + 'TempImg' + '" class="img-circle img-responsive center-block" style="height:50;width:50;"  src="/Images/waitloading02.gif" />');
                    
                    //alert(document.getElementById(BrizBVKStandardObjControlName + 'TempImg').id);
                    clearTimeout(BrizBVKStandardTmrLoad);
                }, 100);
                $.post("/BrizBVKConStandardCore/BrizBVKStandardFunFillDropDown/", { DiSQL: BrizBVKStandardVarStrParaSQL }, function (data) {
                $('#' + BrizBVKStandardObjControlName).empty();                                
                if (data) {
                    if (BrizBVKStandardVarBoolAllowSelect) {
                        var DiStdOptionSelect = document.createElement("option");
                        DiStdOptionSelect.text = "Select";
                        document.getElementById(BrizBVKStandardObjControlName).add(DiStdOptionSelect, 0);
                    }
                    var DiStdJOSONList = data.split('},{');
                    var DiStdDropDown = document.getElementById(BrizBVKStandardObjControlName);

                    var DiStdTotalRows = Number(DiStdJOSONList.length);
                    var DiStdCurrentRow = 1;

                    for (var DiStdJSONRow in DiStdJOSONList) {
                        var DiStdJSONColumns = DiStdJOSONList[DiStdJSONRow];
                        DiStdJSONColumns = DiStdJSONColumns.replace('[{', '{');
                        DiStdJSONColumns = DiStdJSONColumns.replace('}]', '}');
                        if (DiStdJSONColumns.length > 0) {
                            if (DiStdJSONColumns.substring(0, 1) != '{') {
                                DiStdJSONColumns = "{" + DiStdJSONColumns;
                            }
                            if (DiStdJSONColumns.charAt(DiStdJSONColumns.length - 1) != '}') {
                                DiStdJSONColumns = DiStdJSONColumns + "}";
                            }
                            DiStdJSONColumns = JSON.parse(DiStdJSONColumns);
                            DiStdDropDown.options[DiStdDropDown.options.length] = new Option(DiStdJSONColumns.Value, DiStdJSONColumns.ID);
                            if (BrizBVKStandardVarIntSelectedIndex != null) {
                                if (BrizBVKStandardVarIntSelectedIndex == DiStdJSONColumns.ID || BrizBVKStandardVarIntSelectedIndex == DiStdJSONColumns.Value) {
                                    DiStdDropDown.selectedIndex = DiStdDropDown.options.length - 1;
                                }
                            }
                        }
                        DiStdCurrentRow = DiStdCurrentRow + 1;
                    }
                    var BrizBVKStandardTmrDisplay = setTimeout(function () {
                        $('#' + BrizBVKStandardObjControlName).css("display", "block");
                        $('#' + BrizBVKStandardObjControlName).css("zindex", "999");
                        $('#' + BrizBVKStandardObjControlName + '_chzn').css("zindex", "999");
                        $('#' + BrizBVKStandardObjControlName + 'TempImg').remove();
                        //$('#' + BrizBVKStandardObjControlName + '_chzn').remove();
                        if ($('[id^=' + BrizBVKStandardObjControlName + '_chzn]').length > 0) {
                            $('#' + BrizBVKStandardObjControlName + '_chzn').remove();
                        }
                        $('#' + BrizBVKStandardObjControlName).css({ display: "inline-block" }).removeClass("chosen chzn-done").addClass("chosen");

                        jQuery(".chosen").chosen();
                        clearTimeout(BrizBVKStandardTmrDisplay);
                    }, 1000);
                    
                } else {
                    var BrizBVKStandardTmrDisplay = setTimeout(function () {
                        $('#' + BrizBVKStandardObjControlName).css("display", "block");
                        $('#' + BrizBVKStandardObjControlName + 'TempImg').remove();
                        clearTimeout(BrizBVKStandardTmrDisplay);
                    }, 1000);
                }
                
                    
            });

        }
            catch (err) {
                alert(err.message);
                return false;
            }
        }
// Standard Function For Required Dialog
        function BrizBVKStandardProcBootboxRequired(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4)
        {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" + 
                           " <img src='Images/BrizBVKNoBlank.gif'  class='img-thumbnail img-responsive' > " + 
                        "</div>" + 
                        "<div class=\"col-sm-9 pull-right\"> " + 
                            "<div class=\"row\">" + 
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;\">" + 
                                  " <h4> <span class=\"label label-danger\" >" + BrizBVKStandardVarStrParaMsg + "</span> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" + 
                                "<div class=\"col-sm-12\">" + 
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:lightgreen;\" aria-hidden=\"true\"> Easy Help ...</i>" + 
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" ></div> " + 
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\"></div>" + 
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\"></div>" + 
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\"></div>" + 
                                   " <br /> " + 
                                    " <div class=\"row\" id=\"BrizBRwOk\">" + 
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" + 
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" + 
                                    "</div>" + 
                                "</div>" + 
                            "</div>" + 
                        "</div>" + 
                    "</div>",
                className: "BrizBVKStandardDlgRequired BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); BrizBVKStandardVarObjInput.focus() } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); BrizBVKStandardVarObjInput.focus() } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/                                                            
                        if (BrizBTxtHelp1 == null) {
                            document.getElementById("BrizBTxtHelp1").remove();
                        }
                        else {
                            document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                        }
                        if (BrizBTxtHelp2 == null) {
                            document.getElementById("BrizBTxtHelp2").remove();
                        }
                        else {
                            document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                        }
                        if (BrizBTxtHelp3 == null) {
                            document.getElementById("BrizBTxtHelp3").remove();
                        }
                        else {
                            document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                        }
                        if (BrizBTxtHelp4 == null) {
                            document.getElementById("BrizBTxtHelp4").remove();
                        }
                        else {
                            document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                        }
                    
                } catch (err) {
                    alert(err.message);
                }
            });
        }
// Standard Function For Invalid Dialog
        function BrizBVKStandardProcBootboxInvalid(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4) {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" +
                           " <img src='Images/BrizBVKNoInvalid.png'  class='img-thumbnail img-responsive' > " +
                        "</div>" +
                        "<div class=\"col-sm-9 pull-right\"> " +
                            "<div class=\"row\">" +
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;\">" +
                                  " <h4> <span class=\"label label-danger\" >" + BrizBVKStandardVarStrParaMsg + "</span> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" +
                                "<div class=\"col-sm-12\">" +
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:lightgreen;\" aria-hidden=\"true\"> Easy Help ...</i>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" ></div> " +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\"></div>" +
                                   " <br /> " +
                                    " <div class=\"row\" id=\"BrizBRwOk\">" +
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" +
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                    "</div>",
                className: "BrizBVKStandardDlgInvalid BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); BrizBVKStandardVarObjInput.focus() } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); BrizBVKStandardVarObjInput.focus() } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/
                    if (BrizBTxtHelp1 == null) {
                        document.getElementById("BrizBTxtHelp1").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                    }
                    if (BrizBTxtHelp2 == null) {
                        document.getElementById("BrizBTxtHelp2").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                    }
                    if (BrizBTxtHelp3 == null) {
                        document.getElementById("BrizBTxtHelp3").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                    }
                    if (BrizBTxtHelp4 == null) {
                        document.getElementById("BrizBTxtHelp4").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                    }

                } catch (err) {
                    alert(err.message);
                }
            });
        }
// Standard Function For Already Dialog
        function BrizBVKStandardProcBootboxAlreadyExists(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4) {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" +
                           " <img src='Images/BrizBVKAlreadyExistsIcon.png'  class='img-thumbnail img-responsive' > " +
                        "</div>" +
                        "<div class=\"col-sm-9 pull-right\"> " +
                            "<div class=\"row\">" +
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;\">" +
                                  " <h4> <span class=\"label label-danger\" >" + BrizBVKStandardVarStrParaMsg + "</span> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" +
                                "<div class=\"col-sm-12\">" +
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:lightgreen;\" aria-hidden=\"true\"> Easy Help ...</i>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" ></div> " +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\"></div>" +
                                   " <br /> " +
                                    " <div class=\"row\" id=\"BrizBRwOk\">" +
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" +
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                    "</div>",
                className: "BrizBVKStandardDlgAlreadyExists BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); BrizBVKStandardVarObjInput.focus() } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); BrizBVKStandardVarObjInput.focus() } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/
                    if (BrizBTxtHelp1 == null) {
                        document.getElementById("BrizBTxtHelp1").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                    }
                    if (BrizBTxtHelp2 == null) {
                        document.getElementById("BrizBTxtHelp2").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                    }
                    if (BrizBTxtHelp3 == null) {
                        document.getElementById("BrizBTxtHelp3").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                    }
                    if (BrizBTxtHelp4 == null) {
                        document.getElementById("BrizBTxtHelp4").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                    }

                } catch (err) {
                    alert(err.message);
                }
            });
        }
// Standard Function For Success Dialog
        function BrizBVKStandardProcBootboxSuccessful(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4) {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" +
                           " <img src='Images/BrizBVKSuccessful.jpg'  class='img-thumbnail img-responsive' > " +
                        "</div>" +
                        "<div class=\"col-sm-9 pull-right\"> " +
                            "<div class=\"row\">" +
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;\">" +
                                  " <h4> <span class=\"label label-danger\" >" + BrizBVKStandardVarStrParaMsg + "</span> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" +
                                "<div class=\"col-sm-12\">" +
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:lightgreen;\" aria-hidden=\"true\"> Easy Help ...</i>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" ></div> " +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\"></div>" +
                                   " <br /> " +
                                    " <div class=\"row\" id=\"BrizBRwOk\">" +
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" +
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                    "</div>",
                className: "BrizBVKStandardDlgSuccess BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/
                    if (BrizBTxtHelp1 == null) {
                        document.getElementById("BrizBTxtHelp1").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                    }
                    if (BrizBTxtHelp2 == null) {
                        document.getElementById("BrizBTxtHelp2").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                    }
                    if (BrizBTxtHelp3 == null) {
                        document.getElementById("BrizBTxtHelp3").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                    }
                    if (BrizBTxtHelp4 == null) {
                        document.getElementById("BrizBTxtHelp4").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                    }

                } catch (err) {
                    alert(err.message);
                }
            });
        }
// Standard Function For Transaction Success Dialog
        function BrizBVKStandardProcBootboxTransactionSuccessful(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4) {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" +
                           " <img src='Images/BrizBVKTransactionRecordSuccessfull.png'  class='img-thumbnail img-responsive' > " +
                        "</div>" +
                        "<div class=\"col-sm-9 pull-right\"> " +
                            "<div class=\"row\">" +
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;\">" +
                                  " <h4> <span class=\"label label-danger\" >" + BrizBVKStandardVarStrParaMsg + "</span> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" +
                                "<div class=\"col-sm-12\">" +
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:lightgreen;\" aria-hidden=\"true\"> Please Consider Following Point's ...</i>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" ></div> " +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\"></div>" +
                                   " <br /> " +
                                    " <div class=\"row\" id=\"BrizBRwOk\">" +
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" +
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                    "</div>",
                className: "BrizBVKStandardDlgSuccess BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/
                    if (BrizBTxtHelp1 == null) {
                        document.getElementById("BrizBTxtHelp1").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                    }
                    if (BrizBTxtHelp2 == null) {
                        document.getElementById("BrizBTxtHelp2").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                    }
                    if (BrizBTxtHelp3 == null) {
                        document.getElementById("BrizBTxtHelp3").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                    }
                    if (BrizBTxtHelp4 == null) {
                        document.getElementById("BrizBTxtHelp4").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                    }

                } catch (err) {
                    alert(err.message);
                }
            });
        }
// Standard Function For Transaction Error Dialog
        function BrizBVKStandardProcBootboxTransactionError(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4) {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" +
                           " <img src='Images/BrizBVKTransactionEroor.jpg'  class='img-thumbnail img-responsive' > " +
                        "</div>" +
                        "<div class=\"col-sm-9 pull-right\"> " +
                            "<div class=\"row\">" +
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;overflow-x: overlay;word-break:break-all;\">" +
                                  " <h4> <div class=\"label label-danger\" style='max-width:100px;min-width:100px;' >" + BrizBVKStandardVarStrParaMsg + "</div> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" +
                                "<div class=\"col-sm-12\" style=\"background-image:url('Images/BrizBVKErrorBackground.jpg');background-size: contain;background-repeat: no-repeat;background-position: right;background-size: 200px 100px;\">" +
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:#B19186;\" aria-hidden=\"true\"> Please Take Following Step's Immediately To Resolve Issue. ...</i>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" style=\"color:red;\" ></div> " +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\" style=\"color:red;\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\" style=\"color:red;\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\" style=\"color:red;\"></div>" +
                                   " <br /> " +
                                    " <div class=\"row\" id=\"BrizBRwOk\">" +
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" +
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                    "</div>",
                className: "BrizBVKStandardDlgSuccess BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/
                    if (BrizBTxtHelp1 == null) {
                        document.getElementById("BrizBTxtHelp1").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                    }
                    if (BrizBTxtHelp2 == null) {
                        document.getElementById("BrizBTxtHelp2").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                    }
                    if (BrizBTxtHelp3 == null) {
                        document.getElementById("BrizBTxtHelp3").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                    }
                    if (BrizBTxtHelp4 == null) {
                        document.getElementById("BrizBTxtHelp4").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                    }

                } catch (err) {
                    alert(err.message);
                }
            });
        }
        // Standard Function For Transaction Error Dialog
        function BrizBVKStandardProcBootboxUnderMaintenance(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4) {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" +
                           " <img src='Images/BrizBVKTransactionEroor.jpg'  class='img-thumbnail img-responsive' > " +
                        "</div>" +
                        "<div class=\"col-sm-9 pull-right\"> " +
                            "<div class=\"row\">" +
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;overflow-x: overlay;word-break:break-all;\">" +
                                  " <h4> <div class=\"label label-danger\" style='max-width:100px;min-width:100px;' >" + BrizBVKStandardVarStrParaMsg + "</div> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" +
                                "<div class=\"col-sm-12\" style=\"background-image:url('Images/BrizBVKErrorBackground.jpg');background-size: contain;background-repeat: no-repeat;background-position: right;background-size: 200px 100px;\">" +
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:#B19186;\" aria-hidden=\"true\"> Please Take Following Step's Immediately To Resolve Issue. ...</i>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" style=\"color:red;\" ></div> " +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\" style=\"color:red;\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\" style=\"color:red;\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\" style=\"color:red;\"></div>" +
                                   " <br /> " +
                                    " <div class=\"row\" id=\"BrizBRwOk\">" +
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" +
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                    "</div>",
                className: "BrizBVKStandardDlgMaintenance BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/
                    if (BrizBTxtHelp1 == null) {
                        document.getElementById("BrizBTxtHelp1").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                    }
                    if (BrizBTxtHelp2 == null) {
                        document.getElementById("BrizBTxtHelp2").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                    }
                    if (BrizBTxtHelp3 == null) {
                        document.getElementById("BrizBTxtHelp3").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                    }
                    if (BrizBTxtHelp4 == null) {
                        document.getElementById("BrizBTxtHelp4").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                    }

                } catch (err) {
                    alert(err.message);
                }
            });
        }
// Standard Function For Registeration Dialog
        function BrizBVKStandardProcBootboxRegisteration(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4) {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" +
                           " <img src='Images/BrizBVKSuccessful.jpg'  class='img-thumbnail img-responsive' > " +
                        "</div>" +
                        "<div class=\"col-sm-9 pull-right\"> " +
                            "<div class=\"row\">" +
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;\">" +
                                  " <h4> <span class=\"label label-danger\" >" + BrizBVKStandardVarStrParaMsg + "</span> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" +
                                "<div class=\"col-sm-12\">" +
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:lightgreen;\" aria-hidden=\"true\"> Easy Help ...</i>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" ></div> " +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\"></div>" +
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\"></div>" +
                                   " <br /> " +
                                    " <div class=\"row\" id=\"BrizBRwOk\">" +
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" +
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</div>" +
                        "</div>" +
                    "</div>",
                className: "BrizBVKStandardDlgRegisteration BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); if (BrizBVKStandardVarObjInput != null) { try { BrizBVKStandardVarObjInput.focus(); } catch (err) { } } } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/
                    if (BrizBTxtHelp1 == null) {
                        document.getElementById("BrizBTxtHelp1").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                    }
                    if (BrizBTxtHelp2 == null) {
                        document.getElementById("BrizBTxtHelp2").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                    }
                    if (BrizBTxtHelp3 == null) {
                        document.getElementById("BrizBTxtHelp3").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                    }
                    if (BrizBTxtHelp4 == null) {
                        document.getElementById("BrizBTxtHelp4").remove();
                    }
                    else {
                        document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                    }

                } catch (err) {
                    alert(err.message);
                }
            });
        }
// Standard Function For Login Failed        
        function BrizBVKStandardProcBootboxLoginFailed(BrizBVKStandardVarStrParaMsg, BrizBVKStandardVarObjInput, BrizBTxtHelp1, BrizBTxtHelp2, BrizBTxtHelp3, BrizBTxtHelp4)
        {
            var BrizBVKStandardObjAlert = bootbox.dialog({
                message: "<div class='BrizBVKStandardDlgAllRightReserved pull-right'> <i class=\"fa fa-unlink\" style=\"font-size:24px;color:red\"></i> " + BrizBVKStandardObjTransaction.BrizBVKStandardVarStrAllRightsReserved + " </div>",
                title: "<div class=\"row\"> " +
                        "<div class=\"col-sm-3\">" + 
                           " <img src='Images/BrizBVKLoginFailed.png'  class='img-thumbnail img-responsive' > " + 
                        "</div>" + 
                        "<div class=\"col-sm-9 pull-right\"> " + 
                            "<div class=\"row\">" + 
                               " <div class=\"col-sm-12\" style=\"border-bottom-style:double;border-bottom-width:2px;border-bottom-color:red;\">" + 
                                  " <h4> <span class=\"label label-danger\" >" + BrizBVKStandardVarStrParaMsg + "</span> <i class=\"fa fa-asterisk\" aria-hidden=\"true\" style=\"color:red;\"></i></h4>" +
                                "</div>" + 
                                "<div class=\"col-sm-12\">" + 
                                    "<i class=\"fa fa-thumbs-down fa-1x\" style=\"color:lightgreen;\" aria-hidden=\"true\"> Easy Help ...</i>" + 
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp1\" ></div> " + 
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp2\"></div>" + 
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp3\"></div>" + 
                                   " <div class=\"row BrizBVKStandardDlgRequiredHelpRow\" id=\"BrizBTxtHelp4\"></div>" + 
                                   " <br /> " + 
                                    " <div class=\"row\" id=\"BrizBRwOk\">" + 
                                        "<div class=\"col-sm-12 col-sm-offset-4\">" + 
                                            "<button data-rippleria id=\"BrizBBtnRequiredOk\" type=\"button\"   class=\"btn btn-default\"   ><span class=\"glyphicon glyphicon-off\"></span> Ok</button>" +
                                        "</div>" + 
                                    "</div>" + 
                                "</div>" + 
                            "</div>" + 
                        "</div>" + 
                    "</div>",
                className: "BrizBVKStandardDlgLoginFailed BrizBVKStandardDlgSettings"
            });
            BrizBVKStandardObjAlert.on("shown.bs.modal", function () {
                try {
                    BrizBVKStandardObjAlert.attr("id", "BrizBVKStandardObjAlertNotNull");
                    /* Style For Content*/
                    var BrizBVKStandardObjModal = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("modal-content")[0];
                    BrizBVKStandardObjModal.className = "modal-content BrizBVKStandardDlgRequiredContent";
                    /* Style For Close Button*/
                    var BrizBVKStandardObjCloseButton = document.getElementById("BrizBVKStandardObjAlertNotNull").getElementsByClassName("bootbox-close-button close")[0];
                    BrizBVKStandardObjCloseButton.innerHTML = "";
                    BrizBVKStandardObjCloseButton.className = "img-rounded BrizBVKStandardDlgCloseButton pull-right";
                    /* Adding Listners*/
                    document.getElementById("BrizBBtnRequiredOk").addEventListener("click", function () { try { bootbox.hideAll(); BrizBVKStandardVarObjInput.focus() } catch (err) { alert(err.message); } });
                    BrizBVKStandardObjCloseButton.addEventListener("click", function () { try { bootbox.hideAll(); BrizBVKStandardVarObjInput.focus() } catch (err) { alert(err.message); } });
                    document.getElementById("BrizBBtnRequiredOk").focus();
                    /*Remove Help Lines If Not Available*/                                                            
                        if (BrizBTxtHelp1 == null) {
                            document.getElementById("BrizBTxtHelp1").remove();
                        }
                        else {
                            document.getElementById("BrizBTxtHelp1").innerHTML = BrizBTxtHelp1;
                        }
                        if (BrizBTxtHelp2 == null) {
                            document.getElementById("BrizBTxtHelp2").remove();
                        }
                        else {
                            document.getElementById("BrizBTxtHelp2").innerHTML = BrizBTxtHelp2;
                        }
                        if (BrizBTxtHelp3 == null) {
                            document.getElementById("BrizBTxtHelp3").remove();
                        }
                        else {
                            document.getElementById("BrizBTxtHelp3").innerHTML = BrizBTxtHelp3;
                        }
                        if (BrizBTxtHelp4 == null) {
                            document.getElementById("BrizBTxtHelp4").remove();
                        }
                        else {
                            document.getElementById("BrizBTxtHelp4").innerHTML = BrizBTxtHelp4;
                        }
                    
                } catch (err) {
                    alert(err.message);
                }
            });
        }
//Lock Keyboard
        function DiStdNumericValidation(event) {
            var keycode = event.which;
            if (!(event.shiftKey == false && (keycode == 46 || keycode == 8 || keycode == 37 || keycode == 39 || (keycode >= 48 && keycode <= 57)))) {
                event.preventDefault();
            }
        }
// Function to get selected element value from combobox
        function DiStdGetComboboxSelectedValue(DiStdCombobox) {
            try{
                return DiStdCombobox.options[DiStdCombobox.selectedIndex].value;
            }
            catch (err)
            {return '' }
        }
// Function to get selected element text from combobox
        function DiStdGetComboboxSelectedText(DiStdCombobox) {
            try{
                return DiStdCombobox.options[DiStdCombobox.selectedIndex].innerHTML;
            }
            catch (err)
            { return '' }
        }
// Function For Validating Email
        function DiStdValidateEmail(DiStdEmailID) {
            var DiStdEmailRegularExpression = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
            return DiStdEmailRegularExpression.test(DiStdEmailID);
        }
// Function to Check If Control Contains Number
        function DiStdContainsNumber(IsNumber) {
            var DiStdValueMatch = IsNumber.value.match(/\d+/g);
            if (DiStdValueMatch != null) {
                return true;
            }
            else {
                return false;
            }
        }
  // Function to Check If Control Contains Upper Case
        function DiStdContainsUpperCase(IsUpperCase) {
            try{
                DiStdCompareString = IsUpperCase.value;
                var DiStdCounter=0;
                var DiStdCurrentCharacter = '';
                var DiStdResult = false;
                while (DiStdCounter <= DiStdCompareString.length) {
                    DiStdCurrentCharacter = DiStdCompareString.charCodeAt(DiStdCounter);
                    if ((DiStdCompareString.charCodeAt(DiStdCounter) >= 65 && (DiStdCompareString.charCodeAt(DiStdCounter) <= 90)))
                    {
                        DiStdResult = true;
                        break;
                    }
                    DiStdCounter++;
                }
                return DiStdResult;
            } catch (err) { alert(err.message); }
        }
// Remove Existing Menus
        function R0001()
        {
            try {
                
                document.getElementById('O4YMnuPromotion').style.display = "none";
                document.getElementById('O4YMnuMaster').style.display = "none";
                document.getElementById('O4YMnuApproval').style.display = "none";
                document.getElementById('O4YMnuProfile').style.display = "none";
                //O4YMnuProfile
            }
            catch (err) { alert(err.message);}
        }
        // Add Menus
        function R0002() {
            try {

                document.getElementById('O4YMnuPromotion').style.display = "block";
                document.getElementById('O4YMnuMaster').style.display = "block";
                document.getElementById('O4YMnuApproval').style.display = "block";
                document.getElementById('O4YMnuProfile').style.display = "block";
                var DiWaitTimer = setTimeout(function () {
                    R0001();
                    clearTimeout(DiWaitTimer);
                }, 25000);
            }
            catch (err) { alert(err.message); }
        }
        function DiStdFunFormatDate(DtFormatDate) {
            try {
                var Day, Month, Year;
                var Result;
                Result = DtFormatDate.split("-");
                if (Result[0].length == 2) {
                    Day = Result[0];
                }
                else if (Result[1].length == 2) {
                    Day = Result[1];
                }
                else {
                    Day = Result[2];
                }
                if (Result[0].length == 3) {
                    Month = Result[0];
                }
                else if (Result[1].length == 3) {
                    Month = Result[1];
                }
                else {
                    Month = Result[2];
                }
                if (Result[0].length == 4) {
                    Year = Result[0];
                }
                else if (Result[1].length == 4) {
                    Year = Result[1];
                }
                else {
                    Year = Result[2];
                }
                return Day + '-' + Month + '-' + Year;
            } catch (err) {
                alert(err.message);
            }
        }
// Function For Load progress
        function BrizBStandardLoadProgressElementCheck(ele) {
            var all = document.getElementsByTagName("*");
            var totalele = all.length;
            var per_inc = 100 / all.length;

            if ($(ele).on()) {
                var prog_width = per_inc + Number(document.getElementById("progress_width").value);
                document.getElementById("progress_width").value = prog_width;
                $("#bar1").animate({ width: prog_width + "%" }, 10, function () {
                    if (document.getElementById("bar1").style.width == "100%") {
                        $(".progress").fadeOut("slow");
                    }
                });
            }

            else {
                BrizBStandardLoadProgressElementSetting(ele);
            }
        }

        function BrizBStandardLoadProgressElementSetting(set_element) {
            BrizBStandardLoadProgressElementCheck(set_element);
        }