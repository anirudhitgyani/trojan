//JASON: http://www.levibotelho.com/development/posting-javascript-objects-with-ajax-and-asp-net-mvc/
// Standard Code
// 1. Document Ready. Fired As Soon Document is Loaded. Contains handler Find - $(document).ready
// 2. Code For Add New Click. Find - FunStdVijayKAddNewListner
// 3. Code For Edit Click. Find - FunStdVijayKEditClick
var ITGWaitForLoad = setTimeout(function () {
        $(document).ready(function () {
            try {
                try {
                    document.getElementById("EwebBtnLogin").addEventListener("click", BrizBStandardRegistrationValidateAndSaveData);
                    //document.getElementById("EGuruSignIn").setAttribute("visibility", "visible");
                    document.getElementById("EGuruSignIn").style.visibility = "visible";                    
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
            clearTimeout(ITGWaitForLoad);
        });
                            }, 1000);





function BrizBStandardRegistrationValidateAndSaveData() {
    try {
        document.getElementById('EwebTxtUserID').value = "ashish.sharma14@gmail.com";
        document.getElementById('EwebTxtPassword').value = "ITGyani";
        if (document.getElementById('EwebTxtUserID').value.toString().trim() == '') {
                BrizBVKStandardProcBootboxRequired("Please, Enter Email.", document.getElementById('EwebTxtUserID'), "Please, Enter Your Active Email.", "It Should Be In Valid Pattern. i.e. XXX@XXX.com");
                return;
            }
            if (document.getElementById('EwebTxtUserID').value.toString().trim().length > 0) {
                if (DiStdValidateEmail(document.getElementById('EwebTxtUserID').value) == false) {
                    BrizBVKStandardProcBootboxInvalid("Please, Enter Valid Email ID.", document.getElementById('EwebTxtUserID'), "Please, Enter Valid Email.", "It Should Be In Valid Pattern. i.e. XXX@XXX.com");
                    return;
                }
            }
            if (document.getElementById('EwebTxtPassword').value.toString().trim() == '') {
            BrizBVKStandardProcBootboxRequired("Please, Enter Password.", document.getElementById('EwebTxtPassword'), "Enter Valid Password");
                return;
            }            
                    var ObjDBSignIn = BrizBVKStandardObjGetHandler();
                    ObjDBSignIn.onreadystatechange = function ()
                    {
                            if (ObjDBSignIn.readyState == 4 && ObjDBSignIn.status == 200)
                            {
                                    
                
                                    $.each($.parseJSON(ObjDBSignIn.responseText), function (key, TabValue) {
                                        //WHEN 'SignInFailed' THEN 209 
                                        //WHEN 'SignInSuccess' THEN 210
                                        //alert(TabValue.ResultID);
                                        //alert(TabValue.ResultID);
                                        if(TabValue.ResultID == 210)
                                        {
                                            var ObjDBUserInfo = BrizBVKStandardObjGetHandler();
                                                        ObjDBUserInfo.onreadystatechange = function ()
                                                        {
                                                                if (ObjDBUserInfo.readyState == 4 && ObjDBUserInfo.status == 200)
                                                                {
                                                                        var DiWaitTimer = setTimeout(function () {
                                                                            var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                                            if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                                                        }, 500);
                                                                            
                                                                        $.each($.parseJSON(ObjDBUserInfo.responseText), function (key, TabValue) {
                                                                            
                                                                        });
                                                                            window.location="ITGPhpPageDesktop.php"; 
                                                                }
                                                                else
                                                                {
                                                                    return false;
                                                                }
                                                        }
                                                ObjDBUserInfo.open("GET", "ITGCoreAPI.php?CallID=ExecuteUI-UserRecord&XXX01=101&XXX02=0&XXX03=" + document.getElementById('EwebTxtUserID').value + "&XXX04=0");
                                                ObjDBUserInfo.setRequestHeader("Content-Type", "'application/json'");
                                                ObjDBUserInfo.send();   
                                           
                                        }
                                        else if (TabValue.ResultID == 209)
                                        {
                                            var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                                            BrizBVKStandardProcBootboxLoginFailed("Login Failed.", document.getElementById('EwebTxtUserID'), TabValue.TransMessage);
                                        }
                                        else if (TabValue.ResultID == 207)
                                        {
                                            var DiWaitTimer = setTimeout(function () {
                                                var remove = document.getElementById('BrizBVKStandardDivMainContainer');
                                                if (remove) remove.parentNode.removeChild(remove); clearTimeout(DiWaitTimer);
                                            }, 500);
                                            BrizBVKStandardProcBootboxUnderMaintenance("OPPP'S. Site Is Under Maintinance.", document.getElementById('EwebTxtUserID'), TabValue.TransMessage);                                            
                                        }
                                        //ArrDownload.push(TabValue.downloads);
                                    });
                
                            }
                            else
                            {
                                return false;
                            }
                    }

                ObjDBSignIn.open("GET", "API/ITGStandardPHPPageLogin.php?CallID=SignIn&XXX01=" + document.getElementById('EwebTxtUserID').value + "&XXX02="+document.getElementById('EwebTxtPassword').value);
                ObjDBSignIn.setRequestHeader("Content-Type", "'application/json'");
                ObjDBSignIn.send();    
        
            BrizBVKStandardProcShowStaticModel('Wait ... Connecting... !!! ...', 'red', false);
    }
    catch (err) {
        alert(err.message);
    }
}