/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


// Standard methods to be executed for filling up dropdown.
        function BrizBVKStandardProcFillDropdown(BrizBVKStandardVarStrParaSQL, BrizBVKStandardObjControlName, BrizBVKStandardVarIntSelectedIndex, BrizBVKStandardVarBoolAllowSelect) {

            try {                
                var BrizBVKStandardTmrLoad = setTimeout(function () {
                    $('#' + BrizBVKStandardObjControlName).css("display", "none");
                    $('#' + BrizBVKStandardObjControlName + 'TempImg').remove();
                    $('#' + BrizBVKStandardObjControlName + '_chzn').remove();
                    $('#' + BrizBVKStandardObjControlName).closest("div").append('<img id="' + BrizBVKStandardObjControlName + 'TempImg' + '" class="img-circle img-responsive center-block" style="height:50;width:50;"  src="Images/waitloading02.gif" />');
                    
                    //alert(document.getElementById(BrizBVKStandardObjControlName + 'TempImg').id);
                    //clearTimeout(BrizBVKStandardTmrLoad);
                }, 100);
                //alert(BrizBVKStandardVarStrParaSQL)
                $.ajax({
                            url : "API/ITGCore.php?CallID=BrizBVKStandardFunFillDropDown&DSAPI=" + BrizBVKStandardVarStrParaSQL,
                            success: function (data) {
                                    $('#' + BrizBVKStandardObjControlName).empty();    
                                    if (data) {
                                        //alert(data);
                                            data = JSON.parse(data);
                                            if (BrizBVKStandardVarBoolAllowSelect) {
                                                        var DiStdOptionSelect = document.createElement("option");
                                                        DiStdOptionSelect.text = "Select";
                                                        document.getElementById(BrizBVKStandardObjControlName).add(DiStdOptionSelect, 0);
                                                        //DiStdOptionSelect.chosen();
                                                    }
                                                   // alert(data);
                                            $.each(data, function(idx, DiStdJSONColumns) {
                                                //alert(DiStdJSONColumns.Value);
                                                var DiStdDropDown = document.getElementById(BrizBVKStandardObjControlName);
                                                //alert(DiStdJSONColumns.Value);
                                                DiStdDropDown.options[DiStdDropDown.options.length] = new Option(DiStdJSONColumns.Value.replace("&", "&amp").replace("<", "&lt;").replace(">", "&gt;"), DiStdJSONColumns.ID);
                                                //$('#' + BrizBVKStandardObjControlName + '_chzn').append('<option value="' + DiStdJSONColumns.ID + '">' + DiStdJSONColumns.Value.replace("&", "&amp").replace("<", "&lt;").replace(">", "&gt;") + '</option>');
                                                //$('#' + BrizBVKStandardObjControlName + '_chzn').trigger("liszt:updated");
                                                if (BrizBVKStandardVarIntSelectedIndex != null) {
                                                    if (BrizBVKStandardVarIntSelectedIndex == DiStdJSONColumns.ID || BrizBVKStandardVarIntSelectedIndex == DiStdJSONColumns.Value) {
                                                        DiStdDropDown.selectedIndex = DiStdDropDown.options.length - 1;
                                                    }
                                                }
                                                
                                                
                                        });
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
                                                    jQuery('#' + BrizBVKStandardObjControlName).trigger("liszt:updated");
                                                    jQuery('#' + BrizBVKStandardObjControlName).chosen();
                                                    clearTimeout(BrizBVKStandardTmrDisplay);
                                                }, 1000);
                                    }else {
                                        var BrizBVKStandardTmrDisplay = setTimeout(function () {
                                            $('#' + BrizBVKStandardObjControlName).css("display", "block");
                                            $('#' + BrizBVKStandardObjControlName + 'TempImg').remove();
                                            clearTimeout(BrizBVKStandardTmrDisplay);
                                        }, 1000);
                                    }
                                                                     
                            }    
            });

        }
            catch (err) {
                alert(err.message);
                return false;
            }
        }