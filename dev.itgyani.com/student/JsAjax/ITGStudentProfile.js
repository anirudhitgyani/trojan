/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function () {
            try {       //BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'University' , '1')" , document.getElementById('ITGGraduation').id, "0" , 'false');
                            
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , '10ThBoard' , '1')" , document.getElementById('ITG10Board').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'Year' , '1')" , document.getElementById('ITG10SchoolYear').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , '12ThBoard' , '1')" , document.getElementById('ITG12Board').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'Year' , '1')" , document.getElementById('ITG12SchoolYear').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'University' , '1')" , document.getElementById('ITGGraduation').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'Graduation Degree' , '1')" , document.getElementById('ITGDegree').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'Year' , '1')" , document.getElementById('ITGYear01PassingYear').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'Year' , '1')" , document.getElementById('ITGYear02PassingYear').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'Year' , '1')" , document.getElementById('ITGYear03PassingYear').id, "0" , 'false');
                        BrizBVKStandardProcFillDropdown("CALL ExecuteUIControls('112' , '' , 'Year' , '1')" , document.getElementById('ITGYear04PassingYear').id, "0" , 'false');
                        document.getElementById('ITGSchoolPer').addEventListener("keypress", DiStdNumericValidation, false);                        
                        document.getElementById('ITGColPer').addEventListener("keypress", DiStdNumericValidation, false);
                        
                        document.getElementById('ITGYear01PassingYearPer').addEventListener("keypress", DiStdNumericValidation, false);                        
                        document.getElementById('ITGYear02PassingYearPer').addEventListener("keypress", DiStdNumericValidation, false);
                        document.getElementById('ITGYear03PassingYearPer').addEventListener("keypress", DiStdNumericValidation, false);
                        document.getElementById('ITGYear04PassingYearPer').addEventListener("keypress", DiStdNumericValidation, false);
                        $("#ITGDBO").keydown(false);
                          
                        document.getElementById('ITGSchoolPer').addEventListener("blur",PercentageValidation, false);
                        document.getElementById('ITGColPer').addEventListener("blur", PercentageValidation, false);
                        document.getElementById('ITGYear01PassingYearPer').addEventListener("blur",PercentageValidation, false);
                        document.getElementById('ITGYear02PassingYearPer').addEventListener("blur", PercentageValidation, false);
                        document.getElementById('ITGYear03PassingYearPer').addEventListener("blur", PercentageValidation, false);
                        document.getElementById('ITGYear04PassingYearPer').addEventListener("blur", PercentageValidation, false);
                        
                        document.getElementById('ITGBtnSaveAcademic').addEventListener("click", SaveAcademic, false);                        
                        document.getElementById('ITGBtnClearAcademic').addEventListener("click", ClearAcademic, false);
                        
                        $(".chzn-select").chosen();
            }
            catch (err) {
                alert(err.message);
            }
            
        
        });
        function SaveAcademic()
        {
         alert('save');   
        }
        function ClearAcademic()
        {
         alert('clear');   
        }
        function PercentageValidation()
        {
            if(Number(this.value) > 100)
                            {
                                this.value = "0";                                
                                this.focus();
                                bootbox.alert("Percentage Can't Be Greater Than Hunderd!!!");
                            }    
        }
        