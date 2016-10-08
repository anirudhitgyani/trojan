/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
try
{
    // Loading JS
        // Load JS File
    ITGFunStandardLoadExternalJS("js/jquery.js", function(){
    ITGFunStandardLoadExternalJS("js/bootstrap.min.js", function(){    
    ITGFunStandardLoadExternalJS("js/jquery.appear.js", function(){
    ITGFunStandardLoadExternalJS("js/bxslider.js", function(){
    ITGFunStandardLoadExternalJS("js/owl.js", function(){                            
    ITGFunStandardLoadExternalJS("js/jquery.easing.1.3.js", function(){                            
    ITGFunStandardLoadExternalJS("js/script.js", function(){                            
    ITGFunStandardLoadExternalJS("js/jquery.cycle2.js", function(){                            
    ITGFunStandardLoadExternalJS("js/jquery.cycle2.carousel.js", function(){                            
    ITGFunStandardLoadExternalJS("js/page_switch/PageScroll.js", function(){                            
    
    }) ;
    }) ;
    }) ;
    }) ;
    }) ;
    }) ;
    }) ;
    }) ;
    }) ;
    }) ;    
    // Loading CSS
        ITGFunStandardLoadExternalCSS("css/bootstrap.css", "css") ;
        ITGFunStandardLoadExternalCSS("css/animate.css", "css") ;
        ITGFunStandardLoadExternalCSS("css/owl.css", "css") ;
        ITGFunStandardLoadExternalCSS("css/style.css", "css") ;
        ITGFunStandardLoadExternalCSS("css/demo-slideshow.css", "css") ;
        ITGFunStandardLoadExternalCSS("css/custom.css", "css") ;
        ITGFunStandardLoadExternalCSS("css/responsive.css", "css") ;                
}catch(err){alert(err.message)}
function ITGFunStandardLoadExternalJS(url, callback){
//https://www.nczonline.net/blog/2009/07/28/the-best-way-to-load-external-javascript/
    var ObjStandardExtJS = document.createElement("script")
    ObjStandardExtJS.type = "text/javascript";

    if (ObjStandardExtJS.readyState){  //IE
        ObjStandardExtJS.onreadystatechange = function(){
            if (ObjStandardExtJS.readyState == "loaded" ||
                    ObjStandardExtJS.readyState == "complete"){
                ObjStandardExtJS.onreadystatechange = null;
                callback();
            }
        };
    } else {  //Others
        ObjStandardExtJS.onload = function(){
            callback();
        };
    }

    ObjStandardExtJS.src = url;
    document.getElementsByTagName("head")[0].appendChild(ObjStandardExtJS);
}
function ITGFunStandardLoadExternalCSS(filename, filetype){
    try{
        if (filetype=="js"){ //if filename is a external JavaScript file
            var fileref=document.createElement('ObjStandardExtJS')
            fileref.setAttribute("type","text/javaObjStandardExtJS")
            fileref.setAttribute("src", filename)
        }
        else if (filetype=="css"){ //if filename is an external CSS file
            var fileref=document.createElement("link")
            fileref.setAttribute("rel", "stylesheet")
            fileref.setAttribute("type", "text/css")
            fileref.setAttribute("href", filename)
        }
        if (typeof fileref!="undefined")
            document.getElementsByTagName("head")[0].appendChild(fileref)
    }catch(err){alert(err.message);}
}