//JASON: http://www.levibotelho.com/development/posting-javascript-objects-with-ajax-and-asp-net-mvc/
// Standard Code
// 1. Document Ready. Fired As Soon Document is Loaded. Contains handler Find - $(document).ready
// 2. Code For Add New Click. Find - FunStdVijayKAddNewListner
// 3. Code For Edit Click. Find - FunStdVijayKEditClick
$(document).ready(function () {
    try {
        $("#DrpCompanyList").on("change", function (event) {
            BrizBStandardFunCompanyChangeListner();
        });
        // Check If Logged In Already
        BrizBStandardFunVerifyLogin();
        // Stick The Menu
       // $('.header').headtacular({ scrollPoint: 32 });
       // $('.header').headtacular({ scrollPoint: 200 });
        // Menu Code
        //http://www.jqueryrain.com/?cxSWPj0j
        $('.cd-dropdown-trigger').on('click', function (event) {
            event.preventDefault();
            toggleNav($(this).parent());
        });
        $('.cd-dropdown .cd-close').on('click', function (event) {
            event.preventDefault();
            toggleNav($(this).parent());
        });
        //Setting Menu's
        $.post("/BrizBVKConStandardLogin/BrizBVKFunToOrigin/", function (data) {
            var BrizBStandardSiteURL = data;
            $.post("/BrizBVKConStandardCore/BrizBStandardOperationsGetMenuList/", {}, function (data) {
                BrizBStandardMenuList = $.parseJSON(data);
                $.each(BrizBStandardMenuList, function (index, BrizBStandardMenu) {
                    if (Number(BrizBStandardMenu.Level1) == 0 && Number(BrizBStandardMenu.Level2) == 0 && Number(BrizBStandardMenu.Level3) == 0 && Number(BrizBStandardMenu.Level4) == 0 && Number(BrizBStandardMenu.Sequence) == 1 && Number(BrizBStandardMenu.AccessCount) == 0 && BrizBStandardMenu.IsMIS == 'No') {
                        $("#" + BrizBStandardMenu.MenuId).remove();
                    }
                    else if (BrizBStandardMenu.IsMIS == 'No' && BrizBStandardMenu.Read == 'No' && BrizBStandardMenu.Add == 'No' && BrizBStandardMenu.Edit == 'No' && BrizBStandardMenu.Delete == 'No')
                    {
                        $("#" + BrizBStandardMenu.MenuId).remove();
                    }
                    else if (BrizBStandardMenu.IsMIS == 'Yes' && !(BrizBStandardMenu.Read == 'No' && BrizBStandardMenu.Add == 'No' && BrizBStandardMenu.Edit == 'No' && BrizBStandardMenu.Delete == 'No')) {
                            $("#" + BrizBStandardMenu.MenuId).remove();
                            switch( BrizBStandardMenu.MenuName )
                            {
                                case "Group's":
                                    $("#BrizBMenuMIS").append("<a id='" + BrizBStandardMenu.MenuId + "' " + "' href=\"" + BrizBStandardSiteURL + "/" + BrizBStandardMenu.Route + "/" + BrizBStandardMenu.View + "\"  type=\"button\" data-rippleria class=\"btn btn-success\" > <i id='BrizBImgGroups' style='disply:inline-block;color:yellow;' class=\"fa fa-users fa-1x\"  aria-hidden=\"true\"></i> <span style='color:yellow;'> " + BrizBStandardMenu.MenuName + " </span> </a>");
                                    $("#" + BrizBStandardMenu.MenuId).click(function () {
                                        if (document.activeElement = this.id) {
                                            $.blockUI({ css: { 
                                                border: 'none',
                                                width: '80%',
                                                margin: '15px 0px 0px -300px'
                                            } ,message: '<div id="BrizBDivStandardBlockUI" > <img src="../Images/waitloading02.gif" style="padding-right:20px;" />  Please ... Wait Loading Group Screen</div>' });
                                        }
                                    });
                                    break;
                                case "Profile":
                                    $("#BrizBMenuMIS").append("<a id='" + BrizBStandardMenu.MenuId + "' href=\"" + BrizBStandardSiteURL + "/" + BrizBStandardMenu.Route + "/" + BrizBStandardMenu.View + "\" type=\"button\" data-rippleria class=\"btn btn-danger\" style='margin-left:1%;'> <i id='BrizBImgSettings' style='disply:inline-block;color:red;' class=\"fa fa-rebel fa-1x\"  aria-hidden=\"true\"></i> <span style='color:yellow;'> " + BrizBStandardMenu.MenuName + " </span> </a>");
                                    $("#" + BrizBStandardMenu.MenuId).click(function () {
                                        if (document.activeElement = this.id) {
                                            $.blockUI({
                                                css: {
                                                    border: 'none',
                                                    width: '80%',
                                                    margin: '15px 0px 0px -300px'
                                                }, message: '<div id="BrizBDivStandardBlockUI" > <img src="../Images/waitloading02.gif" style="padding-right:20px;" />  Please ... Wait Loading Profile Screen</div>'
                                            });
                                        }
                                    });
                                    break;
                                case "User's":
                                    $("#BrizBMenuMIS").append("<a data-rippleria id='" + BrizBStandardMenu.MenuId + "' href=\"" + BrizBStandardSiteURL + "/" + BrizBStandardMenu.Route + "/" + BrizBStandardMenu.View + "\" type=\"button\" data-rippleria class=\"btn btn-success\" style='margin-left:1%;'> <i id='BrizBImgUsers' style='disply:inline-block;color:yellow;' class=\"fa fa-user fa-1x\"  aria-hidden=\"true\"></i> <span style='color:yellow;'> " + BrizBStandardMenu.MenuName + " </span> </a>");
                                    $("#" + BrizBStandardMenu.MenuId).click(function () {
                                        if (document.activeElement = this.id) {
                                            $.blockUI({
                                                css: {
                                                    border: 'none',
                                                    width: '80%',
                                                    margin: '15px 0px 0px -300px'
                                                }, message: '<div id="BrizBDivStandardBlockUI" > <img src="../Images/waitloading02.gif" style="padding-right:20px;" />  Please ... Wait Loading User Screen</div>'
                                            });
                                        }
                                    });
                                    break;
                                case "Dashboard":
                                    $("#BrizBMenuMIS").append("<a data-rippleria id='" + BrizBStandardMenu.MenuId + "' href=\"" + BrizBStandardSiteURL + "/" + BrizBStandardMenu.Route + "/" + BrizBStandardMenu.View + "\" type=\"button\" data-rippleria class=\"btn btn-warning\" style='margin-left:1%;'> <i id='BrizBImgUsers' style='disply:inline-block;color:green;' class=\"fa fa-tachometer fa-1x\"  aria-hidden=\"true\"></i> <span style='color:yellow;'> " + BrizBStandardMenu.MenuName + " </span> </a>");
                                    $("#" + BrizBStandardMenu.MenuId).click(function () {
                                        if (document.activeElement = this.id) {
                                            $.blockUI({
                                                css: {
                                                    border: 'none',
                                                    width: '80%',
                                                    margin: '15px 0px 0px -300px'
                                                }, message: '<div id="BrizBDivStandardBlockUI" > <img src="../Images/waitloading02.gif" style="padding-right:20px;" />  Please ... Wait Loading Dashboard Screen</div>'
                                            });
                                        }
                                    });
                                    break;

                                default:
                                    break;
                            }
                    }
                });
                // Delete Locations If No Menu Available
                if ($("#BrizBLocations  a").length == 0) {
                   $("#BrizBLocationMain" ).remove();
                }
                // Binding Lada
                Ladda.bind('#BrizBStandardBtnCancel]');
            });
        });
    }
    catch (err) {
        alert(err.message);
    }
});
$(window).load(function () {
    $("#pageloaddiv").fadeOut(2000);
});
document.onreadystatechange = function (e) {
    if (document.readyState == "interactive") {
        var all = document.getElementsByTagName("*");
        for (var i = 0, max = all.length; i < max; i++) {
            BrizBStandardLoadProgressElementSetting(all[i]);
        }
    }
}
function BrizBStandardFunVerifyLogin() {
    
    $.post("/BrizBVKConStandardLogin/BrizBVKFnStandardIfLoggedIn/", function (data) {
        //alert(data);
        var DiWaitTimer = setTimeout(function () {
            var remove = document.getElementById('BrizBVKStdWaitModel');
            if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
        }, 500);
        if (data == '0') {
            $.post("/BrizBVKConStandardLogin/BrizBVKFunToOrigin/", function (data) {
                //location.href = 'http://localhost:1401/';
                location.href = data;
                
            });
        }
        else {
            $.post("/BrizBVKConStandardLogin/BrizBVKFnStandardLogin/", function (data) {
                document.getElementById('SpnProfileName').innerHTML = data;
                $.post("/BrizBVKConStandardDashboard/BrizBVKConStandardReverse/", function (data) {
                    
                    var DiWaitTimer = setTimeout(function () {
                        var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                        if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                    }, 500);
                    data = JSON.parse(data);
                    try {
                        //alert(data.Access[0].Value1);
                        //alert(data.Access[0].Value2);
                        var Value1
                        var Value2
                        Value1 = data.Access[0].Value1
                        Value2 = data.Access[0].Value2
                        //BrizBVKStandardProcFillDropdown('Exec [BrizBVKStandardUserManagement].[ManageCompanyAccess] \'' + data.Access[0].Value1 + '\',\'' + data.Access[0].Value2 + '\'', document.getElementById('DrpCompanyList').id, data, 'false');
                        $.post("/BrizBVKConStandardLogin/BrizBVKFnGetCurrentCompany/", {}, function (data) {
                            BrizBVKStandardProcFillDropdown('Exec [BrizBVKStandardUserManagement].[ManageCompanyAccess] \'' + Value1 + '\',\'' + Value2 + '\'', document.getElementById('DrpCompanyList').id, data.trim(), 'false');
                            var DiWaitTimerForSelectingCompany = setTimeout(function () {
                                if (document.getElementById("DrpCompanyList").length > 0) {
                                    for (var i = 0; i < document.getElementById("DrpCompanyList").length; i++) {
                                        var SelValue = document.getElementById("DrpCompanyList").options[i].value;
                                        var SelText = document.getElementById("DrpCompanyList").options[i].text;
                                        if (data.trim() == SelText.trim()) {
                                            document.getElementById("DrpCompanyList").selectedIndex = document.getElementById("DrpCompanyList").options[i].index;
                                        }
                                    }
                                     clearTimeout(DiWaitTimerForSelectingCompany);
                                }
                            }, 500);
                        });
                        
                        
                        if (Number(data.Access[0].Value1) > 1) {
                            elem = document.getElementById('O4YLnkApporval')
                            document.getElementById('O4YLnkApporval').parentElement.removeChild(document.getElementById('O4YLnkApporval'));
                            document.getElementById('O4YSepApporval').parentElement.removeChild(document.getElementById('O4YSepApporval'));
                            document.getElementById('O4YLnkDistributor').parentElement.removeChild(document.getElementById('O4YLnkDistributor'));
                            document.getElementById('O4YSepDistributor').parentElement.removeChild(document.getElementById('O4YSepDistributor'));
                            document.getElementById('O4YLnkRetailer').parentElement.removeChild(document.getElementById('O4YLnkRetailer'));
                            document.getElementById('O4YSepRetailer').parentElement.removeChild(document.getElementById('O4YSepRetailer'));
                            document.getElementById('O4YLnkSKU').parentElement.removeChild(document.getElementById('O4YLnkSKU'));
                            document.getElementById('O4YSepSKU').parentElement.removeChild(document.getElementById('O4YSepSKU'));
                            // Menu Settings
                            
                        }
                }
            catch (err) {
                alert(err.message);
            }
                    //alert(data.Access[0].Value1);
                });
            });
            BrizBVKStandardProcShowStaticModel('Wait ... Preparing ...', 'red', false);
        }

    });

}
function BrizBStandardFunCompanyChangeListner() {
    bootbox.dialog({
        message: "Are You Sure To Change Company To : '" + DiStdGetComboboxSelectedText(document.getElementById('DrpCompanyList')) + "'?",
        title: "Change Company",
        buttons: {
            success: {
                label: "Yes",
                className: "btn-danger",
                callback: function () {
                    try {
                        $.post("/BrizBVKConStandardLogin/BrizBVKFnSetCurrentCompany/", { O4YCurrentCompany: DiStdGetComboboxSelectedText(document.getElementById('DrpCompanyList')) }, function (data) {
                            $.post("/BrizBVKConStandardLogin/BrizBVKFunToOrigin/", {}, function (data) {
                                window.location = data + "/BrizBVKConStandardDashboard/BrizBVKViwStandardDashboardView";
                            });
                        });
                    } catch (err) { alert(err.message); }
                }
            },
            danger: {
                label: "No",
                className: "btn-success",
                callback: function () {
                    $.post("/BrizBVKConStandardLogin/BrizBVKFnGetCurrentCompany/", {}, function (data) {
                        var DiWaitTimerForSelectingCompany = setTimeout(function () {                            
                            if (document.getElementById("DrpCompanyList").length > 0) {
                                for (var i = 0; i < document.getElementById("DrpCompanyList").length; i++) {
                                    var SelValue = document.getElementById("DrpCompanyList").options[i].value;
                                    var SelText = document.getElementById("DrpCompanyList").options[i].text;
                                    alert(SelText);
                                    if (data == SelText) {
                                        document.getElementById("DrpCompanyList").selectedIndex = document.getElementById("DrpCompanyList").options[i].index;
                                    }
                                }
                                clearTimeout(DiWaitTimerForSelectingCompany);
                            }
                        }, 500);
                    });
                    bootbox.hideAll();
                }
            },
            main: {
                label: "Cancel",
                className: "btn-primary",
                callback: function () {
                    $.post("/BrizBVKConStandardLogin/BrizBVKFnGetCurrentCompany/", {}, function (data) {
                        var DiWaitTimerForSelectingCompany = setTimeout(function () {
                            if (document.getElementById("DrpCompanyList").length > 0) {
                                for (var i = 0; i < document.getElementById("DrpCompanyList").length; i++) {
                                    var SelValue = document.getElementById("DrpCompanyList").options[i].value;
                                    var SelText = document.getElementById("DrpCompanyList").options[i].text;
                                    if (data == SelText) {
                                        document.getElementById("DrpCompanyList").selectedIndex = document.getElementById("DrpCompanyList").options[i].index;
                                    }
                                }
                                clearTimeout(DiWaitTimerForSelectingCompany);
                            }
                        }, 500);
                    });
                    bootbox.hideAll();
                }
            }
        }
    });
    
}