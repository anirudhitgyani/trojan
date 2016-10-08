//JASON: http://www.levibotelho.com/development/posting-javascript-objects-with-ajax-and-asp-net-mvc/
// Standard Code
// 1. Document Ready. Fired As Soon Document is Loaded. Contains handler Find - $(document).ready
// 2. Code For Add New Click. Find - FunStdVijayKAddNewListner
// 3. Code For Edit Click. Find - FunStdVijayKEditClick

$(document).ready(function () {
    try {
        try {
            //1. Redirect If Required
            $.post("/BrizBVKConStandardLogin/BrizBVKFnStandardIfLoggedIn/", function (data) {
                if (data == '1') {
                    $.post("/BrizBVKConStandardLogin/BrizBVKFunToOrigin/", function (data) {
                        if ( location.href.indexOf("/") <2) {
                            location.href = data + '/BrizBVKConStandardDashboard/BrizBVKViwStandardDashboardView';
                        }
                        return;
                    });
                }
                else {
                    document.getElementById("ProjBody").style.display = "block";
                    document.getElementById('BrizBStandardTxtCompanyMobile1').addEventListener("keypress", DiStdNumericValidation, false);
                    document.getElementById('BrizBStandardTxtCompanyMobile2').addEventListener("keypress", DiStdNumericValidation, false);
                    BrizBVKStandardProcFillDropdown( 'Exec [BrizBVKStandardDataPuller].[ExecuteUIControls] \'101\'', document.getElementById('BrizBStandardDrpCompanyCity').id, 0, 'true');
                    setInterval(function () {
                        switch (BrizBVKStandardObjTransaction.BrizBVKStandardVarIntRC) {
                            case 0:
                                $(".tagline").letterfx({ "fx": "fall", "words": true, "timing": 200 });
                                BrizBVKStandardObjTransaction.BrizBVKStandardVarIntRC = 1;
                                break;
                            case 1:
                                $(".tagline").letterfx({ "fx": "swirl" });
                                BrizBVKStandardObjTransaction.BrizBVKStandardVarIntRC = 2;
                                break;
                            case 2:
                                $(".tagline").letterfx({ "fx": "wave", "letter_end": "rewind", "fx_duration": "300ms" });
                                BrizBVKStandardObjTransaction.BrizBVKStandardVarIntRC = 3;
                                break;
                            case 3:
                                $(".tagline").letterfx({ "fx": "smear", "letter_end": "rewind" });
                                BrizBVKStandardObjTransaction.BrizBVKStandardVarIntRC = 4;
                            case 4:
                                $(".tagline").letterfx({ "fx": "fly-right fly-bottom spin" });
                                BrizBVKStandardObjTransaction.BrizBVKStandardVarIntRC = 5;
                                break;
                            case 5:
                                $(".tagline").letterfx({ "fx": "fly-right fly-bottom spin" });
                                BrizBVKStandardObjTransaction.BrizBVKStandardVarIntRC = 6;
                                break;
                            case 6:
                                $(".tagline").letterfx({ "fx": "fly-right fly-bottom spin", "backwards": true, "letter_end": "stay" });
                                BrizBVKStandardObjTransaction.BrizBVKStandardVarIntRC = 0;
                                break;
                            default:
                                break;
                        }
                    }, 5000);


                    var DiWaitTimer = setTimeout(function () {
                        var remove = document.getElementById('BrizBVKStdWaitModel');
                        if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                    }, 500);
                    $('.dropdown').hover(function () {
                        $('.dropdown-toggle', this).trigger('click');
                    });
                    //2. Add Add New Listner To  DOM //
                    document.getElementById("BrizBBtnRegisterCompany").addEventListener("click", BrizBStandardRegistrationValidateAndSaveData);
                    document.getElementById("BrizBStandardBtnCancel").addEventListener("click", BrizBStandardCancelRegistration);
                    document.getElementById("BrizBBtnLogin").addEventListener("click", BrizBStandardFunLoginValidateAndSaveData);
                    //For Home Menus
                    document.getElementById("BrizBVKStandardBtnMenuAboutUS").onclick = function () {
                        BrizBStandardExecuteMenu(1);
                    }
                    document.getElementById("BrizBVKStandardBtnMenuCRMPurpose").onclick = function () {
                        BrizBStandardExecuteMenu(2);
                    }
                    document.getElementById("BrizBVKStandardBtnMenuTermsAndCon").onclick = function () {
                        BrizBStandardExecuteMenu(3);
                    }
                    document.getElementById("BrizBVKStandardBtnMenuCustomerCare").onclick = function () {
                        BrizBStandardExecuteMenu(4);
                    }
                    document.getElementById("BrizBVKStandardBtnMenuContactUs").onclick = function () {
                        BrizBStandardExecuteMenu(5);
                    }

                    if (BrizBVKStandardObjTransaction.BrizBVKStandardVarBoolProjectUnderDevelopment == true) {
                        document.getElementById('BrizBTxtLoginID').value = 'PN@outlook.com';
                        document.getElementById('BrizBTxtPassword').value = 'Password';
                    }
                    //3. Add Social Icons            
                    $("body").floatingSocialShare({
                        buttons: ["facebook", "twitter", "google-plus", "linkedin", "pinterest"],
                        twitter_counter: true,
                        text: "share with: ",
                        url: "http://google.com"
                    });
                    //4. Inner Fade For Home Slider  
                    $('#BrizBVKStandardHomeSlider').innerfade({
                        speed: 'slow',
                        timeout: 4000,
                        type: 'sequence'
                    });

                    $('.fade').innerfade({
                        speed: 'slow',
                        timeout: 1000,
                        type: 'sequence',
                        containerheight: '1.5em'
                    });
                    // Animation Effect's
                    $(".BrizBVKStandardBtnMenu").hover(function () {
                        $(this).removeClass('BrizBVKStandardBtnMenu').addClass('BrizBVKStandardBtnMenuHover');
                        //$(this).attr("src", "button-hover.png");
                    }, function () {
                        $(this).removeClass('BrizBVKStandardBtnMenuHover').addClass('BrizBVKStandardBtnMenu');
                        //$(this).attr("src", "button.png");
                    });
                    $('#BrizBVKStandardHomeSlider').fadeThis({
                        speed: 1000,
                    });
                    $('#BrizBVKStandardFrmDataEntry').insertAfter('#BrizBVKStandardMenuContent');
                    $('body').loadie();
                    $(".trigger").click(function () {
                        $(".menu").toggleClass("active");
                    });
                }
                
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


function BrizBStandardFunLoginValidateAndSaveData() {
    var BrizBLoginID, BrizBPassword;
    if (document.getElementById('BrizBTxtLoginID').value.toString().trim() == '') {
        document.getElementById('BrizBTxtLoginID').focus();
        bootbox.alert("Please, Enter Login ID.");
        return;
    }
    else {
        BrizBLoginID = document.getElementById('BrizBTxtLoginID').value.toString().trim();
    }
    if (document.getElementById('BrizBTxtPassword').value.toString().trim() == '') {
        document.getElementById('BrizBTxtPassword').focus();
        bootbox.alert("Please, Enter Password.");
        return;
    }
    else {
        BrizBPassword = document.getElementById('BrizBTxtPassword').value.toString().trim();
    }
    //alert('test');
    //http://robvolk.com/using-jquery-to-read-json-returned-from-an-mvc-controller-method/    
    $.post("/BrizBVKConStandardLogin/BrizBVKFnStandardLoginUser/", { BrizBVKParaUserID: BrizBLoginID, BrizBVKParaPassword: BrizBPassword }, function (data) {
        //alert(data);
        var DiWaitTimer = setTimeout(function () {
            var remove = document.getElementById('BrizBVKStdWaitModel');
            if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
        }, 500);
        
        if (data == 'No') {
            BrizBVKStandardFunRemoveWait();
            bootbox.alert("Login Failed.");
        }
        else {
            //alert(data);
            data = JSON.parse(data);
            //alert(data);
            location.href = 'BrizBVKConStandardDashboard/BrizBVKViwStandardDashboardView';
        }
    });
    BrizBVKStandardProcShowStaticModel('Wait ... Connecting ...', 'red', false);
    
}
function BrizBStandardRegistrationValidateAndSaveData() {
    try {
        //alert(BrizBVKStandardObjTransaction.BrizBVKStandardVarBoolProjectUnderDevelopment);
        if (BrizBVKStandardObjTransaction.BrizBVKStandardVarBoolProjectUnderDevelopment == true) {
            document.getElementById('BrizBStandardTxtCompanyName').value = 'Godwa Publication Pvt. Ltd.';
            document.getElementById('BrizBStandardTxtCompanyShortName').value = 'GODW';
            document.getElementById('BrizBStandardTxtCompanyEmail').value = 'vijay.katake@outlook.com';
            document.getElementById('BrizBStandardTxtCompanyMobile1').value = '9850977088';
            document.getElementById('BrizBStandardTxtCompanyMobile2').value = '9850977081';
            document.getElementById('BrizBStandardTxtCompanyTelephone1').value = '9850977088';
            document.getElementById('BrizBStandardTxtCompanyTelephone2').value = '9850977081';
            document.getElementById('BrizBStandardTxtCompanyHeadquarterAddress').value = 'Headquarter';
            document.getElementById('BrizBStandardTxtCompanyBranchAddress').value = 'Branch';
            document.getElementById('BrizBStandardTxtCompanyLocation').value = 'Location';

        }
        if (document.getElementById('BrizBStandardTxtCompanyName').value.toString().trim() == '') {
            BrizBVKStandardProcBootboxRequired("Please, Enter Company Name.", document.getElementById('BrizBStandardTxtCompanyName'), "Min. 10 Character's, Max. 50 Character's", "Please, Enter Leagal Registered Name.", "i.e. [Hindustan Unilever Limited.]");
                return;
            }
            
        if (document.getElementById('BrizBStandardTxtCompanyName').value.toString().trim().length < 11) {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Company Name.", document.getElementById('BrizBStandardTxtCompanyName'), "Min. 10 Character's, Max. 50 Character's", "Please, Enter Leagal Registered Name.", "i.e. [Hindustan Unilever Limited.]");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyShortName').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxRequired("Please, Enter Company Short Name.", document.getElementById('BrizBStandardTxtCompanyShortName'), "Min. 2 Character's, Max. 10 Character's",  "i.e. For [Hindustan Unilever Limited.] --> HCL etc.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyShortName').value.toString().trim().length < 3) {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Company Short Name.", document.getElementById('BrizBStandardTxtCompanyShortName'), "Min. 2 Character's, Max. 10 Character's", "i.e. For [Hindustan Unilever Limited.] --> HCL etc.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyEmail').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxRequired("Please, Enter Company Email.", document.getElementById('BrizBStandardTxtCompanyEmail'), "Please, Enter Your Active Business Email.", "It Should Be In Valid Pattern. i.e. vijay.katake@outlook.com");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyEmail').value.toString().trim().length > 0) {
                if (DiStdValidateEmail(document.getElementById('BrizBStandardTxtCompanyEmail').value) == false) {
                    BrizBVKStandardProcBootboxRequired("Please, Enter Valid Email ID.", document.getElementById('BrizBStandardTxtCompanyEmail'), "Please, Enter Valid Email.", "It Should Be In Valid Pattern. i.e. vijay.katake@outlook.com");
                    return;
                }
            }
            if (document.getElementById('BrizBStandardTxtCompanyMobile1').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Mobile 1.", document.getElementById('BrizBStandardTxtCompanyMobile1'), "Min. 10 Digit's.", "Must Be Valid Active Number.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyMobile1').value.toString().trim().length < 10) {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Mobile 1.", document.getElementById('BrizBStandardTxtCompanyMobile1'), "Min. 10 Digit's.", "Must Be Valid Active Number.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyMobile2').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Mobile 2.", document.getElementById('BrizBStandardTxtCompanyMobile2'), "Min. 10 Digit's.", "Must Be Valid Active Number And Not Same As Mobiel1.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyMobile2').value.toString().trim().length < 10) {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Mobile 2.", document.getElementById('BrizBStandardTxtCompanyMobile2'), "Min. 10 Digit's.", "Must Be Valid Active Number And Not Same As Mobiel1.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyMobile1').value.toString().trim() == document.getElementById('BrizBStandardTxtCompanyMobile2').value.toString().trim()) {
                BrizBVKStandardProcBootboxInvalid("Mobile 1 And Mobile 2 Can't Be Same, Please Enter Two Diffrent And Valid Mobiles.", document.getElementById('BrizBStandardTxtCompanyMobile1'), "Min. 10 Digit's.", "Conuntry Code Not Required.");
                return;
            }

            if (document.getElementById('BrizBStandardTxtCompanyTelephone1').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Telephone 1.", document.getElementById('BrizBStandardTxtCompanyTelephone1'), "Enter City Code + Telephone Number.", "Must Be Valid Active Number And Not Same As Telephone.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyTelephone2').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Telephone 2.", document.getElementById('BrizBStandardTxtCompanyTelephone2'), "Enter City Code + Telephone Number.", "Must Be Valid Active Number And Not Same As Telephone.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyTelephone1').value.toString().trim() == document.getElementById('BrizBStandardTxtCompanyTelephone2').value.toString().trim()) {
                BrizBVKStandardProcBootboxInvalid("Telephone 1 And Telephone 2 Can't Be Same, Please Enter Two Diffrent And Valid Telephone Number's.", document.getElementById('BrizBStandardTxtCompanyTelephone2'), "Enter City Code + Telephone Number.", "Must Be Valid Active Number And Not Same As Telephone.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyHeadquarterAddress').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Company Headquarter Address.", document.getElementById('BrizBStandardTxtCompanyHeadquarterAddress'), "Enter Valid Headquarter Address.", "Must Be Existing And Legal Address.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyBranchAddress').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Working Branch Address.", document.getElementById('BrizBStandardTxtCompanyBranchAddress'), "Enter Valid Company Branch Address.", "Must Be Existing And Legal Address.");
                return;
            }
            if (document.getElementById('BrizBStandardDrpCompanyCity').selectedIndex == "0") {
                BrizBVKStandardProcBootboxInvalid("Please, Select Company City.", document.getElementById('BrizBStandardDrpCompanyCity'), "Select From List.", "User Search To Filter.");
                return;
            }
            if (document.getElementById('BrizBStandardTxtCompanyLocation').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxInvalid("Please, Enter Operational Location.", document.getElementById('BrizBStandardTxtCompanyLocation'), "Type Company Branch Location.", "Working Location Required.");
                return;
            }
            //alert(document.getElementById('BrizBStandardTxtCompanyBranchAddress').value);
            $.post("/BrizBVKConStandardLogin/IILoginTransaction00001/", { CompanyName: document.getElementById('BrizBStandardTxtCompanyName').value, CompanyShortName: document.getElementById('BrizBStandardTxtCompanyShortName').value, CompanyEmail: document.getElementById('BrizBStandardTxtCompanyEmail').value, CompanyMobile1: document.getElementById('BrizBStandardTxtCompanyMobile1').value, CompanyMobile2: document.getElementById('BrizBStandardTxtCompanyMobile2').value, CompanyTelephone1: document.getElementById('BrizBStandardTxtCompanyTelephone1').value, CompanyTelephone2: document.getElementById('BrizBStandardTxtCompanyTelephone2').value, CompanyHeadquarterAddress: document.getElementById('BrizBStandardTxtCompanyHeadquarterAddress').value, CompanyOfficeAddress: document.getElementById('BrizBStandardTxtCompanyBranchAddress').value, CompanyStatus: 'Approval', CompanyStatusReason: 'Approval', CompanyCityID: DiStdGetComboboxSelectedValue(document.getElementById('BrizBStandardDrpCompanyCity')), CompanyOperationalLocation: document.getElementById('BrizBStandardTxtCompanyLocation').value, RecordMode: '101', RecordID: '01' }, function (data) {
                var DiWaitTimer = setTimeout(function () {
                    var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                    if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);

                }, 500);
                data = JSON.parse(data);
                switch (Number(data[0].ResultID)) {
                    case 201: // Exists
                        BrizBVKStandardProcBootboxAlreadyExists(data[0].TransMessage, document.getElementById('BrizBStandardTxtCompanyName'), "Might You Are Regestering Already Registered Company, By Mistake", "Please, Confirm With Us Connecting To Helpline For Resolving Issue.", "Do Confirm Spelling Mistake.", "After All, We Apologize For Any Technical Issue You Faced. Please Contact To Customer Care For Exact Help.");
                        break;
                    case 202: // Add
                        $.post("/BrizBVKConStandardLogin/IILoginTransaction00002/", { CompanyName: document.getElementById('BrizBStandardTxtCompanyName').value, CompanyShortName: document.getElementById('BrizBStandardTxtCompanyShortName').value, CompanyEmail: document.getElementById('BrizBStandardTxtCompanyEmail').value, CompanyMobile1: document.getElementById('BrizBStandardTxtCompanyMobile1').value, CompanyMobile2: document.getElementById('BrizBStandardTxtCompanyMobile2').value, CompanyTelephone1: document.getElementById('BrizBStandardTxtCompanyTelephone1').value, CompanyTelephone2: document.getElementById('BrizBStandardTxtCompanyTelephone2').value, CompanyHeadquarterAddress: document.getElementById('BrizBStandardTxtCompanyHeadquarterAddress').value, CompanyOfficeAddress: document.getElementById('BrizBStandardTxtCompanyBranchAddress').value, CompanyStatus: 'Approval', CompanyStatusReason: 'Approval', CompanyCityID: DiStdGetComboboxSelectedText(document.getElementById('BrizBStandardDrpCompanyCity')), CompanyOperationalLocation: document.getElementById('BrizBStandardTxtCompanyLocation').value, RecordMode: '101', RecordID: '01' }, function (data) {
                            var DiWaitTimer = setTimeout(function () {
                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);

                            }, 500);

                        });
                        var BrizBStandardTxtEmail  = document.getElementById('BrizBStandardTxtCompanyEmail').value.toString().trim(); 
                        BrizBStandardCancelRegistration();
                        BrizBVKStandardProcBootboxRegisteration(data[0].TransMessage, null, "Please, Chek Registeration Email At Registered Email Box : " + BrizBStandardTxtEmail, "Please, Verify Registered Information And Contact Us If Any Change Required.", "If You Doesn't Receive Feedback By Call In 48 Hour's, Please Contact Us.", "If You Haven't Received Email Then Contact Customer Care.");
                        
                        break;
                    case 203: // Failure
                        day = "Tuesday";
                        break;
                    case 204: // Upate 
                        day = "Wednesday";
                        break;
                    case 205: // Delete
                        day = "Thursday";
                        break;
                    case 206: // Error
                        day = "Friday";
                        break;
                    case 207: // Maintenance
                        day = "Saturday";
                        break;
                }
            });
            BrizBVKStandardProcShowStaticModel('Wait ... Registering !!! ...', 'red', false);
    }
    catch (err) {
        alert(err.message);
    }
}
function BrizBStandardCancelRegistration() {
    try {
        var l = Ladda.create(this);
        l.start();
        l.toggle();
        l.isLoading();
        $('body').loadie(10);
        document.getElementById('BrizBStandardTxtCompanyName').value = '';
        $('body').loadie(20);
        document.getElementById('BrizBStandardTxtCompanyShortName').value = '';
        document.getElementById('BrizBStandardTxtCompanyEmail').value = '';
        $('body').loadie(30);
        document.getElementById('BrizBStandardTxtCompanyMobile1').value = '';
        document.getElementById('BrizBStandardTxtCompanyMobile2').value = '';
        $('body').loadie(60);
        document.getElementById('BrizBStandardTxtCompanyTelephone1').value = '';
        document.getElementById('BrizBStandardTxtCompanyTelephone2').value = '';
        document.getElementById('BrizBStandardTxtCompanyHeadquarterAddress').value = '';
        $('body').loadie(80);
        document.getElementById('BrizBStandardTxtCompanyBranchAddress').value = '';
        document.getElementById('BrizBStandardTxtCompanyLocation').value = '';
        $('body').loadie(100);
        BrizBVKStandardProcFillDropdown('Exec [BrizBVKStandardDataPuller].[ExecuteUIControls] \'101\'', document.getElementById('BrizBStandardDrpCompanyCity').id, 0, 'true');
       // $('body').loadie(0);
    } catch (err) {
        alert(err.message);
    }
}
function BrizBStandardExecuteMenu(BrizBVarIntEffect) {
    try {
        $("#BrizBVKStandardHomeSlider").hide();
        $("#BrizBVKStandardBtnMenuAboutUSConetnt").hide();
        $("#BrizBVKStandardBtnMenuCRMPurposeContent").hide();
        $("#BrizBVKStandardBtnMenuTermsAndConContent").hide();
        $("#BrizBVKStandardBtnMenuCustomerCareContent").hide();
        $("#BrizBVKStandardBtnMenuContactUsContent").hide();
        
        switch  (BrizBVarIntEffect)
        {
            case 1:
                //document.getElementById('BrizBVKStandardBtnMenuAboutUSConetnt').style.display = "block";
                $("#BrizBVKStandardBtnMenuAboutUSConetnt").show();
                $('#BrizBVKStandardBtnMenuAboutUSConetnt').transition({ rotate: '45deg' });
                $('#BrizBVKStandardBtnMenuAboutUSConetnt').transition({ rotate: '0deg' });
                
                break;
            case 2:
                $("#BrizBVKStandardBtnMenuCRMPurposeContent").show();
                $('#BrizBVKStandardBtnMenuCRMPurposeContent').transition({ rotate: '45deg' });
                $('#BrizBVKStandardBtnMenuCRMPurposeContent').transition({ rotate: '0deg' });
                break;
            case 3:
                break;
            case 4:
                break;
            case 5:
                break;
            default:
                document.getElementById('BrizBVKStandardHomeSlider').style.display = "block";
                document.getElementById('BrizBVKStandardHomeMenu').style.display = "none";
                break;
        }
        $('#BrizBVKStandardFrmDataEntry').insertBefore('#BrizBVKStandardMenuContent');
        document.getElementById('BrizBVKStandardFrmDataEntry').style.marginTop = "1.5%";
    } catch (err) { alert(err.message); }
}