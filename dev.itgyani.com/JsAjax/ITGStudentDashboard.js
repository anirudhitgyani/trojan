/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
            try {    
                    $('#ITGTrvCourse').jstree();
                    $('#ITGTrvCourse').jstree();
                    // 7 bind to events triggered on the tree
                    $('#ITGTrvCourse').on("changed.jstree", function (e, data) {
                      console.log(data.selected);
                    });
                    // 8 interact with the tree - either way is OK
                    $('button').on('click', function () {
                      $('#ITGTrvCourse').jstree(true).select_node('child_node_1');
                      $('#ITGTrvCourse').jstree('select_node', 'child_node_1');
                      $.jstree.reference('#ITGTrvCourse').select_node('child_node_1');
                    });
                    // Build Tree
                    ITGyaniBuildTree();  
                    //document.getElementById("ITGOptVideo").addEventListener("click", ITGOptVideo);
                    //document.getElementById("ITGOptDocuement").addEventListener("click", ITGOptDocuement);
                    //var video = videojs('ITGVideo');
                    //    video.src({"type":"video", "src":"https://www.youtube.com/watch?v=kQmfd_bCegU"});
                    //    video.play()
                      $("div.bhoechie-tab-menu>ul.list-group>a").click(function(e) {
                         // alert('called');
                            e.preventDefault();
                            $(this).siblings('a.active').removeClass("active");
                            $(this).addClass("active");
                            var index = $(this).index();                            
                            $("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
                            $("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
                        });
                        //$('.panel-heading span.clickable').click();
                        //$('.panel div.clickable').click();
                        $('#video1').videoExtend({
            logo: 'img/example_logo.png',
            logoLink: 'http://example.com/',
            logoSize: [ 60, 40 ],
            markers: [
                {
                    time: 39.32,// seconds
                    text: 'Chapter 1'
                },
                {
                    time: 350.23,
                    text: 'Chapter 2'
                },
                {
                    time: 470.88,
                    text: 'Chapter 3'
                },
                {
                    time: 677.82,
                    text: 'Chapter 4'
                }
            ]
        });
            }
            catch (err) {
                alert(err.message);
            }
            
        
        });
        function changeVideo(){
                        
                      }
        function ITGOptVideo()
        {
            try{
                    if(this.checked)
                    {
                        $('#ITGSelTopic').empty();
                        $.ajax({
                            url : "API/ITGStudentDashboard.php?CallID=VieoList&XXX01=" + $('#ITGTrvCourse').jstree(true).get_selected(),
                            success: function (data) {
                                //alert(data);
                                $.each($.parseJSON(data), function (key, TabValue)  {                                                        
                                        $('#ITGSelTopic').append($('<option>', {value:TabValue.URL, text:TabValue.URL}));                                                                                                                   
                                });
                            }
                        });   
                    }
            }catch(err){alert(err.message)}
        }
        function ITGOptDocuement()
        {
            try{
                    if(this.checked)
                    {                        
                        $('#ITGSelTopic').empty();
                        $.ajax({
                            url : "API/ITGStudentDashboard.php?CallID=DocList&XXX01=" + $('#ITGTrvCourse').jstree(true).get_selected(),
                            success: function (data) {
                                //alert(data);
                                $.each($.parseJSON(data), function (key, TabValue)  {                                                        
                                        $('#ITGSelTopic').append($('<option>', {value:TabValue.DOC, text:TabValue.DOC}));                                                                                                                   
                                });
                            }
                        });
                    }
            }catch(err){alert(err.message)}
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
                                
                                    $('#ITGTrvCourse').jstree({ 'core' : {
                                            'data' : $.parseJSON(ObjDBCourseTree.responseText)
                                    } });
                                                                     
                                       $("#ITGTrvCourse").bind(
                                                "select_node.jstree", function(evt, data){
                                                    //selected node object: data.inst.get_json()[0];
                                                    //selected node text: data.inst.get_json()[0].data
                                                    try{                                                                                                                
                                                        var id = $('#ITGTrvCourse').jstree(true).get_selected();
                                                        BrizBVKStandardObjTransaction.BrizBVKStandardVarStr01 = $("#ITGTrvCourse").jstree().get_selected(true)[0].text ;                                                        
                                                        BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID = id;
                                                        ITGyaniSelectNode(null , BrizBVKStandardObjTransaction.BrizBVKStandardVarIntCurrentMasterRecordID);                                                       
                                                }catch(err){alert(err.message);}
                                                }
                                        );
                                   
                
                            }
                            else
                            {
                                return false;
                            }
                    }
                    
                
                        ObjDBCourseTree.open("GET", "API/ITGStudentDashboard.php?CallID=TreeView");
                        ObjDBCourseTree.setRequestHeader("Content-Type", "'application/json'");
                        ObjDBCourseTree.send();  

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
                                    $('#ITGDivTopics').empty();                
                                    $.each($.parseJSON(ObjDBCurrentNode.responseText), function (key, TabValue) {                                        
                                      try{
                                            $('#ITGTrvCourse').jstree('select_node', TabValue.ID);                                               
                                           // alert(TabValue.CourseName);
                                            $.ajax({
                                                url : "API/ITGStudentDashboard.php?CallID=TopicPanel&XXX01=" + TabValue.ID,
                                                success: function (data) {
                                                    //alert(data);
                                                    var RowStatus = 0 ;
                                                    var ITGPanelRow;
                                                    var ITGPanelColumn;
                                                    var ITGPanelPanel;
                                                    var ITGPanelPanelHead;
                                                    var ITGPanelPanelHeadTitle;
                                                    var ITGPanelPanelHeadTitleSpan;
                                                    var ITGPanelPanelHeadTitleSpanLi;
                                                    var ITGPanelPanelBody;
                                                    
                                                    $.each($.parseJSON(data), function (keyIn, TabValueIn)  {                                                        
                                                            //$('#ITGSelTopic').append($('<option>', {value:TabValue.DOC, text:TabValue.DOC}));                                                                                                                   
                                                      try{
                                                            if(RowStatus == 0)
                                                            {
                                                                // Main Row
                                                                    ITGPanelRow =  document.createElement("div"); 
                                                                    ITGPanelRow.className = "class";
                                                                    $( "#ITGDivTopics" ).append( ITGPanelRow); 
                                                                    ITGPanelRow.id = "ITGTopicRow$" + TabValueIn.TopicID + '$'+ TabValueIn.TopicSRNO  ;
                                                            }
                                                    // Main Column
                                                        ITGPanelColumn = document.createElement("div"); 
                                                        ITGPanelColumn.className = "col-md-6";
                                                        ITGPanelColumn.id = "ITGTopicCol$" + TabValueIn.TopicID + '$'+ TabValueIn.TopicSRNO ;
                                                        ITGPanelRow.appendChild( ITGPanelColumn); 
                                                    // Panel Insertion
                                                        ITGPanelPanel  = document.createElement("div"); 
                                                        if(RowStatus == 0 )
                                                        {
                                                            ITGPanelPanel.className = "panel panel-info";
                                                        }
                                                        else
                                                        {
                                                            ITGPanelPanel.className = "panel panel-warning";
                                                            
                                                        }
                                                        ITGPanelPanel.style = "border-width:2px;border-style: solid;"
                                                        ITGPanelPanel.id = "ITGTopicInfo$" + TabValueIn.TopicID + '$'+ TabValueIn.TopicSRNO ;
                                                        ITGPanelColumn.appendChild(ITGPanelPanel);
                                                    // Panel Header
                                                        ITGPanelPanelHead   = document.createElement("div"); 
                                                        ITGPanelPanelHead.className = "panel-heading";
                                                        ITGPanelPanelHead.id = "ITGTopicheading$" + TabValueIn.TopicID + '$'+ TabValueIn.TopicSRNO ;
                                                        ITGPanelPanel.appendChild(ITGPanelPanelHead);
                                                    // Panel Header Title
                                                        ITGPanelPanelHeadTitle = document.createElement("h3"); 
                                                        ITGPanelPanelHeadTitle.innerHTML = TabValueIn.TopicName;
                                                        ITGPanelPanelHead.id = "ITGTopicheadingh3$" + TabValueIn.TopicID + '$'+ TabValueIn.TopicSRNO ;
                                                        ITGPanelPanelHead.appendChild(ITGPanelPanelHeadTitle);
                                                    // Panel Header Pin
                                                        ITGPanelPanelHeadTitleSpan  = document.createElement("span"); 
                                                        ITGPanelPanelHeadTitleSpan.id = "ITGTopicheadinghspan$" + TabValueIn.TopicID + '$'+ TabValueIn.TopicSRNO ;
                                                        ITGPanelPanelHeadTitleSpan.className = "pull-right clickable";                                                                    
                                                        ITGPanelPanelHead.appendChild(ITGPanelPanelHeadTitleSpan);
                                                    // Panel Header Li
                                                        ITGPanelPanelHeadTitleSpanLi = document.createElement("i"); 
                                                        ITGPanelPanelHeadTitleSpanLi.className = "glyphicon glyphicon-minus";
                                                        ITGPanelPanelHeadTitleSpan.id = "ITGTopicheadinghspani$" + TabValueIn.TopicID + '$'+ TabValueIn.TopicSRNO ;
                                                        ITGPanelPanelHeadTitleSpan.appendChild(ITGPanelPanelHeadTitleSpanLi);
                                                    // Panel Body
                                                        ITGPanelPanelBody   = document.createElement("div"); 
                                                        ITGPanelPanelBody.className = "panel-body";
                                                        ITGPanelPanelBody.id = "ITGTopicPanelBody$" + TabValueIn.TopicID + '$'+ TabValueIn.TopicSRNO ;
                                                        ITGPanelPanel.appendChild(ITGPanelPanelBody);
                                                        // Add Body
                                                        var ContentBody;
                                                        ContentBody = document.createElement("div"); 
                                                        ITGPanelPanelBody.appendChild(ContentBody);
                                                        var ContentBodySpan;
                                                        ContentBodySpan= document.createElement("span"); 
                                                        ContentBody.appendChild(ContentBodySpan);
                                                        ContentBodySpan.innerHTML = TabValueIn.TopicDesc ;
                                                        var ContentBodyVideo01;
                                                        ContentBodyVideo01 = document.createElement("span"); 
                                                        
                                                        var VideoDiv = document.createElement("div"); 
                                                        VideoDiv.innerHTML = "   <span style='margin-left:20%;font-family: fantasy;word-spacing: 2px;' > Video 01 </span>"
                                                        VideoDiv.className = "VideoDivider"
                                                        ContentBody.appendChild(VideoDiv);
                                                        
                                                        if(TabValueIn.IsPaid == 0)
                                                        {
                                                           // alert('called');
                                                            var Payment01 = document.createElement("span"); 
                                                            Payment01.style="margin-right:10px;padding-right:12px;"
                                                            //Payment01.className= "label label-success";
                                                            Payment01.innerHTML='<p class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"><span class="label label-success"> Upgrade Plan </span></a></p>';
                                                            VideoDiv.appendChild(Payment01);
                                                        }
                                                        
                                                        var DivSpan = document.createElement("div"); 
                                                        VideoDiv.appendChild(DivSpan);
                                                        DivSpan.className = "label label-danger pull-right";
                                                        
                                                        //alert(TabValueIn.URL01 );
                                                        if(TabValueIn.URL01 != '...' )
                                                        {                                                           
                                                            ContentBodyVideo01.innerHTML = '<video id="' + "TV" + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  +'" width="1000" height="100" controls><source src="' + TabValueIn.URL01 + '" type="video/youtube"></video>' ;
                                                            ContentBody.appendChild(ContentBodyVideo01);                                                           
                                                            $('#' + 'TV' + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  ).videoExtend({
                                                                logo: 'images/CompanyLogo.jpg',
                                                                logoLink: 'http://example.com/',
                                                                logoSize: [ 60, 40 ],
                                                                logoPosition: [ 'auto', 10, 50, 'auto' ] // top, right, bottom, left
                                                            });
                                                            DivSpan.innerHTML = "Free Video";
                                                        }
                                                        else
                                                        {
                                                            if( TabValueIn.IsPaid == "0")
                                                            {
                                                                DivSpan.innerHTML = "Paid Video";
                                                            }
                                                            else
                                                            {
                                                                DivSpan.innerHTML = "Not Available";
                                                            }
                                                        }  
                                                        
                                                        // Video 02
                                                        var ContentBodyVideo02;
                                                        ContentBodyVideo02 = document.createElement("span"); 
                                                        
                                                        var VideoDiv02 = document.createElement("div"); 
                                                        VideoDiv02.innerHTML = "   <span style='margin-left:20%;font-family: fantasy;word-spacing: 2px;' > Video 02 </span>";
                                                        VideoDiv02.className = "VideoDivider"
                                                        ContentBody.appendChild(VideoDiv02);
                                                        
                                                        if(TabValueIn.IsPaid == 0)
                                                        {
                                                           // alert('called');
                                                            var Payment02 = document.createElement("span"); 
                                                            Payment02.style="margin-right:10px;padding-right:12px;"
                                                            //Payment01.className= "label label-success";
                                                            Payment02.innerHTML='<p  class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"> <span class="label label-success"> Upgrade Plan </span></a></p>';
                                                            VideoDiv02.appendChild(Payment02);
                                                        }
                                                        
                                                        
                                                        var DivSpan = document.createElement("div"); 
                                                        VideoDiv02.appendChild(DivSpan);
                                                        DivSpan.className = "label label-danger pull-right";
                                                        
                                                        //alert(TabValueIn.URL01 );
                                                        //alert(TabValueIn.URL02);
                                                        if(TabValueIn.URL02 != '...' && TabValueIn.URL02.trim() != ''  )
                                                        {                                                           
                                                            ContentBodyVideo02.innerHTML = '<video id="' + "TV02" + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  +'" width="640" height="360" controls><source src="' + TabValueIn.URL02 + '" type="video/youtube"></video>' ;
                                                            ContentBody.appendChild(ContentBodyVideo02);                                                           
                                                            $('#' + 'TV02' + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  ).videoExtend({
                                                                logo: 'images/CompanyLogo.jpg',
                                                                logoLink: 'http://example.com/',
                                                                logoSize: [ 60, 40 ],
                                                                logoPosition: [ 'auto', 10, 50, 'auto' ] // top, right, bottom, left
                                                            });
                                                            DivSpan.innerHTML = "Free Video";
                                                        }
                                                        else
                                                        {
                                                            if( TabValueIn.IsPaid == "0")
                                                            {
                                                                DivSpan.innerHTML = "Paid Video";
                                                            }
                                                            else
                                                            {
                                                                DivSpan.innerHTML = "Not Available";
                                                            }
                                                        }
                                                        // Video 03
                                                        var ContentBodyVideo03;
                                                        ContentBodyVideo03 = document.createElement("span"); 
                                                        
                                                        var VideoDiv03 = document.createElement("div"); 
                                                        VideoDiv03.innerHTML = "   <span style='margin-left:20%;font-family: fantasy;word-spacing: 2px;' > Video 03 </span>";
                                                        VideoDiv03.className = "VideoDivider"
                                                        ContentBody.appendChild(VideoDiv03);
                                                        
                                                        if(TabValueIn.IsPaid == 0)
                                                        {
                                                           // alert('called');
                                                            var Payment03 = document.createElement("span"); 
                                                            Payment03.style="margin-right:10px;padding-right:12px;"
                                                            //Payment01.className= "label label-success";
                                                            Payment03.innerHTML='<p  class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"> <span class="label label-success"> Upgrade Plan </span></a></p>';
                                                            VideoDiv03.appendChild(Payment03);
                                                        }
                                                        
                                                        
                                                        var DivSpan = document.createElement("div"); 
                                                        VideoDiv03.appendChild(DivSpan);
                                                        DivSpan.className = "label label-danger pull-right";
                                                        
                                                        //alert(TabValueIn.URL01 );
                                                        //alert(TabValueIn.URL02);
                                                        if(TabValueIn.URL03 != '...' && TabValueIn.URL03.trim() != ''  )
                                                        {                                                           
                                                            ContentBodyVideo03.innerHTML = '<video id="' + "TV03" + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  +'" width="640" height="360" controls><source src="' + TabValueIn.URL03 + '" type="video/youtube"></video>' ;
                                                            ContentBody.appendChild(ContentBodyVideo03);                                                           
                                                            $('#' + 'TV03' + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  ).videoExtend({
                                                                logo: 'images/CompanyLogo.jpg',
                                                                logoLink: 'http://example.com/',
                                                                logoSize: [ 60, 40 ],
                                                                logoPosition: [ 'auto', 10, 50, 'auto' ] // top, right, bottom, left
                                                            });
                                                            DivSpan.innerHTML = "Free Video";
                                                        }
                                                        else
                                                        {
                                                            if( TabValueIn.IsPaid == "0")
                                                            {
                                                                DivSpan.innerHTML = "Paid Video";
                                                            }
                                                            else
                                                            {
                                                                DivSpan.innerHTML = "Not Available";
                                                            }
                                                        }
                                                        // Video 04
                                                        var ContentBodyVideo04;
                                                        ContentBodyVideo04 = document.createElement("span"); 
                                                        
                                                        var VideoDiv04 = document.createElement("div"); 
                                                        VideoDiv04.innerHTML = "   <span style='margin-left:20%;font-family: fantasy;word-spacing: 2px;' > Video 04 </span>";
                                                        VideoDiv04.className = "VideoDivider"
                                                        ContentBody.appendChild(VideoDiv04);
                                                        
                                                        if(TabValueIn.IsPaid == 0)
                                                        {
                                                           // alert('called');
                                                            var Payment04 = document.createElement("span"); 
                                                            Payment04.style="margin-right:10px;padding-right:12px;"
                                                            //Payment01.className= "label label-success";
                                                            Payment04.innerHTML='<p  class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"> <span class="label label-success"> Upgrade Plan </span></a></p>';
                                                            VideoDiv04.appendChild(Payment04);
                                                        }
                                                        
                                                        
                                                        var DivSpan = document.createElement("div"); 
                                                        VideoDiv04.appendChild(DivSpan);
                                                        DivSpan.className = "label label-danger pull-right";
                                                        
                                                        //alert(TabValueIn.URL01 );
                                                        //alert(TabValueIn.URL02);
                                                        if(TabValueIn.URL04 != '...' && TabValueIn.URL04.trim() != ''  )
                                                        {                                                           
                                                            ContentBodyVideo04.innerHTML = '<video id="' + "TV04" + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  +'" width="640" height="360" controls><source src="' + TabValueIn.URL03 + '" type="video/youtube"></video>' ;
                                                            ContentBody.appendChild(ContentBodyVideo04);                                                           
                                                            $('#' + 'TV04' + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  ).videoExtend({
                                                                logo: 'images/CompanyLogo.jpg',
                                                                logoLink: 'http://example.com/',
                                                                logoSize: [ 60, 40 ],
                                                                logoPosition: [ 'auto', 10, 50, 'auto' ] // top, right, bottom, left
                                                            });
                                                            DivSpan.innerHTML = "Free Video";
                                                        }
                                                        else
                                                        {
                                                            if( TabValueIn.IsPaid == "0")
                                                            {
                                                                DivSpan.innerHTML = "Paid Video";
                                                            }
                                                            else
                                                            {
                                                                DivSpan.innerHTML = "Not Available";
                                                            }
                                                        }
                                                        // Document 01
                                                        var ContentBodyDoc01;
                                                        ContentBodyDoc01 = document.createElement("span"); 
                                                        
                                                        var DocDiv01 = document.createElement("div"); 
                                                        DocDiv01.innerHTML = "   <span style='margin-left:20%;font-family: fantasy;word-spacing: 2px;' > Document 01 </span>";
                                                        DocDiv01.className = "VideoDivider"
                                                        ContentBody.appendChild(DocDiv01);
                                                        
                                                        if(TabValueIn.IsPaid == 0)
                                                        {
                                                           // alert('called');
                                                            var Payment05 = document.createElement("span"); 
                                                            Payment05.style="margin-right:10px;padding-right:12px;"
                                                            //Payment01.className= "label label-success";
                                                            Payment05.innerHTML='<p  class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"> <span class="label label-success"> Upgrade Plan </span></a></p>';
                                                            DocDiv01.appendChild(Payment05);
                                                        }
                                                        
                                                        
                                                        var DivSpan = document.createElement("div"); 
                                                        ContentBodyDoc01.appendChild(DivSpan);
                                                        DivSpan.className = "label label-danger pull-right";
                                                        DocDiv01.appendChild(DivSpan);
                                                        //alert(TabValueIn.URL01 );
                                                        //alert(TabValueIn.URL02);
                                                        if(TabValueIn.DOC01 != '...' && TabValueIn.DOC01.trim() != ''  )
                                                        {   
                                                            DivSpan.innerHTML = "Free Document";
                                                            ContentBodyDoc01.innerHTML = '<a target="_blank" id="Doc01"' +  TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  + ' href="' + TabValueIn.DOC01 + '">Click To View Document 01</span>' ;
                                                            ContentBody.appendChild(ContentBodyDoc01); 
                                                            /*
                                                            $('#' + 'Doc01' + TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  ).videoExtend({
                                                                logo: 'images/CompanyLogo.jpg',
                                                                logoLink: 'http://example.com/',
                                                                logoSize: [ 60, 40 ],
                                                                logoPosition: [ 'auto', 10, 50, 'auto' ] // top, right, bottom, left
                                                            });
                                                            */
                                                        }
                                                        else
                                                        {
                                                            if( TabValueIn.IsPaid == "0")
                                                            {
                                                                DivSpan.innerHTML = "Paid Document";
                                                                //alert('called01')
                                                            }
                                                            else
                                                            {
                                                                DivSpan.innerHTML = "Not Available";
                                                               // alert('called02')
                                                            }
                                                            
                                                        }
                                                        // Document 02
                                                        var ContentBodyDoc02;
                                                        ContentBodyDoc02 = document.createElement("span"); 
                                                        
                                                        var DocDiv02 = document.createElement("div"); 
                                                        DocDiv02.innerHTML = "   <span style='margin-left:20%;font-family: fantasy;word-spacing: 2px;' > Document 02 </span>";
                                                        DocDiv02.className = "VideoDivider"
                                                        ContentBody.appendChild(DocDiv02);
                                                        
                                                        if(TabValueIn.IsPaid == 0)
                                                        {
                                                           // alert('called');
                                                            var Payment06 = document.createElement("span"); 
                                                            Payment06.style="margin-right:10px;padding-right:12px;"
                                                            //Payment01.className= "label label-success";
                                                            Payment06.innerHTML='<p  class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"> <span class="label label-success"> Upgrade Plan </span></a></p>';
                                                            DocDiv02.appendChild(Payment06);
                                                        }
                                                        
                                                        
                                                        var DivSpan = document.createElement("div"); 
                                                        ContentBodyDoc02.appendChild(DivSpan);
                                                        DivSpan.className = "label label-danger pull-right";
                                                        DocDiv02.appendChild(DivSpan);
                                                        //alert(TabValueIn.URL01 );
                                                        //alert(TabValueIn.URL02);
                                                        if(TabValueIn.DOC02 != '...' && TabValueIn.DOC02.trim() != ''  )
                                                        {   
                                                            DivSpan.innerHTML = "Free Document";
                                                            ContentBodyDoc02.innerHTML = '<a target="_blank" id="Doc02"' +  TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  + ' href="' + TabValueIn.DOC02 + '">Click To View Document 02</span>' ;
                                                            ContentBody.appendChild(ContentBodyDoc02);                                                             
                                                        }
                                                        else
                                                        {
                                                            if( TabValueIn.IsPaid == "0")
                                                            {
                                                                DivSpan.innerHTML = "Paid Document";
                                                                //alert('called01')
                                                            }
                                                            else
                                                            {
                                                                DivSpan.innerHTML = "Not Available";
                                                               // alert('called02')
                                                            }
                                                            
                                                        }
                                                        // Document 03
                                                        var ContentBodyDoc03;
                                                        ContentBodyDoc03 = document.createElement("span"); 
                                                        
                                                        var DocDiv03 = document.createElement("div"); 
                                                        DocDiv03.innerHTML = "   <span style='margin-left:20%;font-family: fantasy;word-spacing: 2px;' > Document 03 </span>";
                                                        DocDiv03.className = "VideoDivider"
                                                        ContentBody.appendChild(DocDiv03);
                                                        
                                                        if(TabValueIn.IsPaid == 0)
                                                        {
                                                           // alert('called');
                                                            var Payment07 = document.createElement("span"); 
                                                            Payment07.style="margin-right:10px;padding-right:12px;"
                                                            //Payment01.className= "label label-success";
                                                            Payment07.innerHTML='<p  class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"> <span class="label label-success"> Upgrade Plan </span></a></p>';
                                                            DocDiv03.appendChild(Payment07);
                                                        }
                                                        
                                                        
                                                        var DivSpan = document.createElement("div"); 
                                                        ContentBodyDoc03.appendChild(DivSpan);
                                                        DivSpan.className = "label label-danger pull-right";
                                                        DocDiv03.appendChild(DivSpan);
                                                        //alert(TabValueIn.URL01 );
                                                        //alert(TabValueIn.URL02);
                                                        if(TabValueIn.DOC03 != '...' && TabValueIn.DOC03.trim() != ''  )
                                                        {   
                                                            DivSpan.innerHTML = "Free Document";
                                                            ContentBodyDoc03.innerHTML = '<a target="_blank" id="Doc02"' +  TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  + ' href="' + TabValueIn.DOC03 + '">Click To View Document 03</span>' ;
                                                            ContentBody.appendChild(ContentBodyDoc03);                                                             
                                                        }
                                                        else
                                                        {
                                                            if( TabValueIn.IsPaid == "0")
                                                            {
                                                                DivSpan.innerHTML = "Paid Document";
                                                                //alert('called01')
                                                            }
                                                            else
                                                            {
                                                                DivSpan.innerHTML = "Not Available";
                                                               // alert('called02')
                                                            }
                                                            
                                                        }
                                                        // Document 04
                                                        var ContentBodyDoc04;
                                                        ContentBodyDoc04 = document.createElement("span"); 
                                                        
                                                        var DocDiv04 = document.createElement("div"); 
                                                        DocDiv04.innerHTML = "   <span style='margin-left:20%;font-family: fantasy;word-spacing: 2px;' > Document 04 </span>";
                                                        DocDiv04.className = "VideoDivider"
                                                        ContentBody.appendChild(DocDiv04);
                                                        
                                                        if(TabValueIn.IsPaid == 0)
                                                        {
                                                           // alert('called');
                                                            var Payment08 = document.createElement("span"); 
                                                            Payment08.style="margin-right:10px;padding-right:12px;"
                                                            //Payment01.className= "label label-success";
                                                            Payment08.innerHTML='<p  class="text-center pull-left"><a href="" data-toggle="modal" data-target="#myModal1"> <span class="label label-success"> Upgrade Plan </span></a></p>';
                                                            DocDiv04.appendChild(Payment08);
                                                        }
                                                        
                                                        
                                                        var DivSpan = document.createElement("div"); 
                                                        ContentBodyDoc04.appendChild(DivSpan);
                                                        DivSpan.className = "label label-danger pull-right";
                                                        DocDiv04.appendChild(DivSpan);
                                                        //alert(TabValueIn.URL01 );
                                                        //alert(TabValueIn.URL02);
                                                        if(TabValueIn.DOC04 != '...' && TabValueIn.DOC04.trim() != ''  )
                                                        {   
                                                            DivSpan.innerHTML = "Free Document";
                                                            ContentBodyDoc04.innerHTML = '<a target="_blank" id="Doc02"' +  TabValueIn.TopicID + '-'+ TabValueIn.TopicSRNO  + ' href="' + TabValueIn.DOC04 + '">Click To View Document 04</span>' ;
                                                            ContentBody.appendChild(ContentBodyDoc04);                                                             
                                                        }
                                                        else
                                                        {
                                                            if( TabValueIn.IsPaid == "0")
                                                            {
                                                                DivSpan.innerHTML = "Paid Document";
                                                                //alert('called01')
                                                            }
                                                            else
                                                            {
                                                                DivSpan.innerHTML = "Not Available";
                                                               // alert('called02')
                                                            }
                                                            
                                                        }                                                        
                                                            RowStatus = RowStatus + 1;
                                                            if(RowStatus == 2)
                                                            {
                                                                RowStatus = 0;
                                                            }                                                   
                                                        }catch(err){alert(err.message);}    
                                                    });
                                                    
                                                }
                                            });
                                            //BrizBVKStandardProcShowStaticModel('Wait ... Preparing Course For You ... !!! ...', 'red', false);
                                        }catch(err){alert(err.message);}
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
                            ObjDBCurrentNode.open("GET", "API/ITGStudentDashboard.php?CallID=CurrentNodeID&XXX01=" + encodeURIComponent( ParaITGCurrentNodeID.toString())  );
                        }
                        else
                        {
                            ObjDBCurrentNode.open("GET", "API/ITGStudentDashboard.php?CallID=CurrentNode&XXX01=" + encodeURIComponent( ParaITGCurrentNode.toLocaleString()) );
                        }
                        ObjDBCurrentNode.setRequestHeader("Content-Type", "'application/json'");
                        ObjDBCurrentNode.send();              
    }catch(err)
    {alert(err.message)}
}

    function toggleChevron(e) {
                    if(this.className =="glyphicon-chevron-down glyphicon-chevron-up" )
                    {
                        this.className ="glyphicon-chevron-down glyphicon-chevron-down";
                    }
                    else
                    {
                        this.className ="glyphicon-chevron-down glyphicon-chevron-up";
                    }      
        }
$(document).on('click', '.panel-heading span.clickable', function (e) {
    var $this = $(this);
    if (!$this.hasClass('panel-collapsed')) {
        $this.parents('.panel').find('.panel-body').slideUp();
        $this.addClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
    } else {
        $this.parents('.panel').find('.panel-body').slideDown();
        $this.removeClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
    }
});
$(document).on('click', '.panel div.clickable', function (e) {
    var $this = $(this);
    if (!$this.hasClass('panel-collapsed')) {
        $this.parents('.panel').find('.panel-body').slideUp();
        $this.addClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
    } else {
        $this.parents('.panel').find('.panel-body').slideDown();
        $this.removeClass('panel-collapsed');
        $this.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
    }
});