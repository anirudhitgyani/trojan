//JASON: http://www.levibotelho.com/development/posting-javascript-objects-with-ajax-and-asp-net-mvc/
// Standard Code
// 1. Document Ready. Fired As Soon Document is Loaded. Contains handler Find - $(document).ready
// 2. Code For Add New Click. Find - FunStdVijayKAddNewListner
// 3. Code For Edit Click. Find - FunStdVijayKEditClick
$(document).ready(function () {
    try {
        // 1. Code To Fill The Dropdown
        $('#BrizBTblDataGrid').DataTable({
                responsive: {
                    details: {
                        display: $.fn.dataTable.Responsive.display.modal({
                            header: function (row) {
                                var data = row.data();
                                return 'Details for ' + data[0] + ' ' + data[1];
                            }
                        }),
                        renderer: $.fn.dataTable.Responsive.renderer.tableAll()
                    }
                },
                scrollY: '50vh',
                scrollCollapse: true
        });
        BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu = document.getElementById('BrizBStandardDivMenuContainer');
        //alert(BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu);
        // 2. Setup Datatable
        try {
            var BrizBObjSelect;
            for (BrizBCtrGridSearch = 0 ; BrizBCtrGridSearch < document.getElementsByTagName('select').length ; BrizBCtrGridSearch++) {
                if (document.getElementsByTagName('select')[BrizBCtrGridSearch].innerHTML == '<option value="10">10</option><option value="25">25</option><option value="50">50</option><option value="100">100</option>') {
                    BrizBObjSelect = document.getElementsByTagName('select')[BrizBCtrGridSearch];
                }
            }
            // Search Button
            var BrizBObjSearch = document.getElementById('BrizBTblDataGrid_filter');
            BrizBObjSearch = BrizBObjSearch.children[0].children[0];

            var element = document.getElementById("BrizBTblDataGrid_filter");
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
            BrizBVKStandardAddSearchImage.src = "\\Images\\Filter.ico";
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
            BrizBVKStandardSelectImg.src = "\\Images\\Nike - Red.ico";
            BrizBVKStandardSelectImg.height = 40;
            BrizBVKStandardSelectImg.width = 50;

            var BrizBVKStandardSelectText = document.createElement('label');
            BrizBVKStandardSelectText.id = 'BrizBVKStandardBtnGidText';
            BrizBVKStandardSelectText.innerHTML = "Select No Of Rows"
            BrizBVKStandardSelectText.setAttribute("class", "BrizBDataGridSelectRowsLabel");
            BrizBVKStandardSelectText.setAttribute("fontfamily", "seirf");


            // Add Div
            var BrizBVKStandardTransaction = document.createElement("div");
            BrizBVKStandardTransaction.id = 'BrizBVKStandardDivDataGridTransaction';
            BrizBVKStandardTransaction.setAttribute("class", "col-sm-1");
            BrizBVKStandardTransaction.setAttribute("align", "center");

            var BrizBVKStandardAddButton = document.createElement("button");
            BrizBVKStandardAddButton.id = 'BrizBBtnStandardAdd';
            BrizBVKStandardAddButton.setAttribute("class", "btn btn-success BrizBButtonFunctionality jdbpopup my_popup_open");
            BrizBVKStandardAddButton.setAttribute("href", "#BrizBVKStandardFrmDataEntry");
            BrizBVKStandardAddButton.setAttribute("type", "button");

            var BrizBVKStandardAddButtonLi = document.createElement("li");
            BrizBVKStandardAddButtonLi.id = 'BrizBBtnStandardAddLi';
            BrizBVKStandardAddButtonLi.setAttribute("class", "fa fa-plus 10px my_popup_open");
            BrizBVKStandardAddButtonLi.setAttribute("href", "#modal-02");
            BrizBVKStandardAddButtonLi.innerHTML = "Add";
            BrizBVKStandardAddButton.onclick = function () {
                try {
                    //$('#BrizBBtnStandardAddLi').click();
                    $('#modal-02').show();
                } catch (err) {
                    alert(err.message);
                }
            }
            BrizBVKStandardAddButton.appendChild(BrizBVKStandardAddButtonLi);
            BrizBVKStandardTransaction.appendChild(BrizBVKStandardAddButton);

            // Import & Report Buttons
            var BrizBVKStandardFeature = document.createElement("div");
            BrizBVKStandardFeature.id = 'BrizBVKStandardDivDataGridFeatures';
            BrizBVKStandardFeature.setAttribute("class", "col-sm-2");
            BrizBVKStandardFeature.setAttribute("align", "center");

            var BrizBVKStandardImportButton = document.createElement("button");
            BrizBVKStandardImportButton.id = 'BrizBBtnStandardImport';
            BrizBVKStandardImportButton.setAttribute("class", "btn btn-warning BrizBButtonFunctionality jdbpopup");
            BrizBVKStandardImportButton.style = "background-color:maroon;margin-right:10px;";
            BrizBVKStandardImportButton.setAttribute("type", "button");

            var BrizBVKStandardImportButtonLi = document.createElement("li");
            BrizBVKStandardImportButtonLi.id = 'BrizBBtnStandardAddLi';
            BrizBVKStandardImportButtonLi.setAttribute("class", "fa fa-file-excel-o 10px");
            BrizBVKStandardImportButtonLi.innerHTML = "Export";

            var BrizBVKStandardPrintButton = document.createElement("button");
            BrizBVKStandardPrintButton.id = 'BrizBBtnStandardPrint';
            BrizBVKStandardPrintButton.setAttribute("class", "btn btn-warning BrizBButtonFunctionality jdbpopup");
            BrizBVKStandardPrintButton.style = "background-color:lightskyblue;";
            BrizBVKStandardPrintButton.setAttribute("type", "button");


            var BrizBVKStandardPrintButtonLi = document.createElement("li");
            BrizBVKStandardPrintButtonLi.id = 'BrizBBtnStandardPrintLi';
            BrizBVKStandardPrintButtonLi.setAttribute("class", "fa fa-sticky-note-o 10px");
            BrizBVKStandardPrintButtonLi.innerHTML = "Report";

            BrizBVKStandardImportButton.appendChild(BrizBVKStandardImportButtonLi);
            BrizBVKStandardPrintButton.appendChild(BrizBVKStandardPrintButtonLi);
            BrizBVKStandardFeature.appendChild(BrizBVKStandardImportButton);
            BrizBVKStandardFeature.appendChild(BrizBVKStandardPrintButton);

            //<button id="BrizBBtnStandardAdd" type="button" class="btn btn-warning BrizBButtonFunctionality jdbpopup" ><li class="fa fa-plus 10px"> Add </li></button>
            //<button id="BrizBBtnStandardExport" type="button" class="btn btn-warning BrizBButtonFunctionality" style="background-color:maroon;" > <li class="fa fa-file-excel-o 10px" > Export </li></button>
            //<button id="BrizBBtnStandardReport" type="button" class="btn btn-warning BrizBButtonFunctionality" style="background-color:lightskyblue;" ><li class="fa fa-sticky-note-o 10px" > Report </li></button>

            document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardSelectText);
            document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBObjSelect);
            document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardSelectImg);
            document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardTransaction);
            document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardFeature);
            document.getElementsByClassName('dataTables_length')[0].appendChild(BrizBVKStandardSearch);

            // 3. Add Button Event
            document.getElementById("BrizBBtnCloseDialogSave").addEventListener("click", BrizBStandardGroupValidateAndSaveData);

            
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
                    document.body.insertBefore(BrizBVKStandardObjTransaction.BrizBVKStandardVarObjMenu, document.body.firstChild);
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
    catch (err) {
        alert(err.message);
    }
});
$(window).load(function () {
    $("#pageloaddiv").fadeOut(500);
});
document.onreadystatechange = function (e) {
    if (document.readyState == "interactive") {
        var all = document.getElementsByTagName("*");
        for (var i = 0, max = all.length; i < max; i++) {
            BrizBStandardLoadProgressElementSetting(all[i]);
        }
    }
}
function BrizBStandardGroupValidateAndSaveData() {
    try {
        if (document.getElementById('BrizBStandardTxtGroupName').value.toString().trim() == '') {
            BrizBVKStandardProcBootboxRequired("Please, Enter Group Name.", document.getElementById('BrizBStandardTxtGroupName'), "Min. 5 Character's, Max. 50 Character's", "Please, Enter Valid Group Name.", "i.e. [Human Resource Management]");
            return;
        }
        if (document.getElementById('BrizBStandardTxtGroupName').value.toString().trim().length < 5) {
            BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Group Name.", document.getElementById('BrizBStandardTxtGroupName'), "Min. 5 Character's, Max. 50 Character's", "Please, Enter Valid Group Name.", "i.e. [Human Resource Management]");
            return;
        }
        if (document.getElementById('BrizBStandardTxtGroupCode').value.toString().trim() == '') {
            BrizBVKStandardProcBootboxRequired("Please, Enter Group Code.", document.getElementById('BrizBStandardTxtGroupCode'), "Min. 5 Character's, Max. 8 Character's", "Please, Enter Valid Group Code Starting With GC@. And Ending With Dash '-'", "i.e. GC@CEO-, GC@DIR-");
            return;
        }
        if (document.getElementById('BrizBStandardTxtGroupCode').value.toString().trim().length < 5) {
            BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Group Code.", document.getElementById('BrizBStandardTxtGroupCode'), "Min. 5 Character's, Max. 50 Character's", "Please, Enter Valid Group Code Starting With GC@. And Ending With Dash '-'", "i.e. GC@CEO-, GC@DIR-");
            return;
        }
        if (document.getElementById('BrizBStandardTxtGroupDescription').value.toString().trim() == '') {
            BrizBVKStandardProcBootboxRequired("Please, Enter Group Description.", document.getElementById('BrizBStandardTxtGroupDescription'), "Min. 5 Character's, Max. 8 Character's", "Please, Enter Valid Group Description.", "i.e. Group To Manage Employees. The Group Can Acccess So & So Menu's  ... etc. ");
            return;
        }
        if (document.getElementById('BrizBStandardTxtGroupDescription').value.toString().trim().length < 10) {
            BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Group Description.", document.getElementById('BrizBStandardTxtGroupDescription'), "Min. 10 Character's, Max. 255 Character's", "Please, Enter Valid Group Description.", "i.e. Group To Manage Employees. The Group Can Acccess So & So Menu's  ... etc. ");
            return;
        }
        $.post("/BrizBVKConStandardGroup/BrizBStandardGroupController0001/", { XX001: document.getElementById('BrizBStandardTxtGroupName').value, XX002: document.getElementById('BrizBStandardTxtGroupCode').value, XX003: document.getElementById('BrizBStandardTxtGroupDescription').value, XX004: "", XX005: "" }, function (data) {
            //alert(data);
            var DiWaitTimer = setTimeout(function () {
                var remove = document.getElementById('DiDivWaitModel');
                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
            }, 500);
            data = JSON.parse(data);
            alert(Number(data[0].ResultID));
            switch (Number(data[0].ResultID)) {
                case 201: // Exists
                    document.getElementById(data[0].TransControl).focus();
                    bootbox.alert(data[0].TransMessage);
                    break;
                case 202: // Add, Update
                    bootbox.alert(data[0].TransMessage);
                    //FunStdVijayKFillDataTable("EXEC [O4YDataPuller].[ExecuteUIControls] @TransType = 120", document.getElementById('TblStdVijayKDataView').id, 'Wait Loading Retailer List ...', 'red', 'Retailer List', null);
                    BrizBVKStandardProcBootboxTransactionSuccessful(data[0].TransMessage, document.getElementById('BrizBStandardTxtGroupName'), "Please Add Right's To Group From Right List.", "Further You Can Add Group To Existing Or New User From User's Screen.", "Please, Allocate User's With Group From Legal Permission Agreed With Higher Authority.", "For Any Clarification, Coordinate With Technical Team.");
                    break;
                case 203: // Failure
                    day = "Tuesday";
                    break;
                case 204: // Upadate 
                    day = "Wednesday";
                    break;
                case 205: // Delete
                    day = "Thursday";
                    break;
                case 206: // Error
                    BrizBVKStandardProcBootboxTransactionError(data[0].TransMessage, document.getElementById('BrizBStandardTxtGroupName'), "Please Take Snapshot Of Screen.", "Inform It To Senior Authority.", "Email Screen Shot And Error Detail's With Data Entry Input To Customer Care.", "Please, Take Early Step's. It's Important For All Of Us.");
                    break;
                case 207: // Maintenance
                    BrizBVKStandardProcBootboxUnderMaintenance(data[0].TransMessage, document.getElementById('BrizBStandardTxtGroupName'), "Please Take Snapshot Of Screen.", "Inform It To Senior Authority.", "Email Screen Shot And Error Detail's With Data Entry Input To Customer Care.", "Please, Take Early Step's. It's Important For All Of Us.");
                    break;
                case 208: // Denied
                    day = "Saturday";
                    break;
            }
        });
    } catch (err) { alert(err.message); }
}