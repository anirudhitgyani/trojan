
<?php

include_once('../config/ITGStandardPHPPageDBConfig.php'); 
include_once('../config/ez_sql_core.php'); 
include_once('../config/ez_sql_mysql.php');
require('../Classes/PHPExcel/IOFactory.php');
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
if(isset($_GET['CallID']))
 {
    if($_GET['CallID']=='Save')
    {            
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $user = $ITGObjStandardDB->get_row("CALL ManageAdminCourse( '" . $_GET['XXX01'] . "' , '" . $_GET['XXX02'] . "' , '" . $_GET['XXX03']. "' , '" . $_GET['XXX04']. "' , '" . $_GET['XXX05']. "' , '" . $_GET['XXX06']. "' , '0', '" . $_GET['XXX07']  . "');");
        $results = array();
        $results[] = array(
              'ResultID' => $user->ResultID,
              'TransMessage' => $user->TransMessage,
              'TransMessageId' => $user->TransMessageId,
              'TransControl' => $user->TransControl
           );
        $json = json_encode($results);
        echo $json;

    }
    if($_GET['CallID']=='TreeView')
    {            
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $Courses = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '102' , '' , '' , '0' );");
        $results = array();
        foreach ( $Courses as $Course ) {
            $results[] = array(
                  'id' => $Course->id,
                  'Parent' => $Course->Parent,
                  'text' => $Course->text
               );
        }
        $json = json_encode($results);
    echo $json;

    }
    if($_GET['CallID']=='CurrentNode')
    {            
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $Courses = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '103' , '' , '" . $_GET['XXX01']. "' , '0' );");
        $results = array();
        foreach ( $Courses as $Course ) {
            $results[] = array(
                  'ID' => $Course->ID,
                  'CourseName' => $Course->CourseName,
                  'CourseDesc' => $Course->CourseDesc,
                  'ImageName' => $Course->ImageName,
                  'ImageData' => $Course->ImageData
               );
        }
        $json = json_encode($results);
        echo $json;

    }
    if($_GET['CallID']=='CurrentNodeID')
    {          
        // validations
        
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $Courses = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '104' ,  '" . $_GET['XXX01']. "' ,'' , '0' );");
        $results = array();
        foreach ( $Courses as $Course ) {
            $results[] = array(
                  'ID' => $Course->ID,
                  'CourseName' => $Course->CourseName,
                  'CourseDesc' => $Course->CourseDesc,
                  'ImageName' => $Course->ImageName,
                  'ImageData' => $Course->ImageData,
                  'IsActive' => $Course->IsActive
               );
        }
        $json = json_encode($results);
        echo $json;

    }
    
    if($_GET['CallID']=='ReadTopic')
    {   
        $objXLS = PHPExcel_IOFactory::load('../Upload/' . $_GET['XXX01']);
        $results = array();
        if($_GET['XXX01'] != $_GET['XXX02'])
        {
            $results[] = array(
                      'TopSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Error: Invalid Course File Selected. Course File Name Must Match With Selected Course File Name From Drop Down."
                   );           
        }
        //$Reader->setReadDataOnly(true); // set this, to not read all excel properties, just data
        //$objXLS = $Reader->load($file);
       else
       {
            $ObjCurrentSheet = $objXLS->setActiveSheetIndex(0);
            //$ObjCurrentSheet->$objXLS->getSheet(0);
            $highestRow = $ObjCurrentSheet->getHighestRow();
            $highestColumn = $ObjCurrentSheet->getHighestColumn();
            $Error = 0;
            
                $Currow = $ObjCurrentSheet->getRowIterator(1)->current();
                $cellIterator = $Currow->getCellIterator();
                $cellIterator->setIterateOnlyExistingCells(false);
                $TopicID = $ObjCurrentSheet->getCellByColumnAndRow(0, 1)->getValue();
                $TopicName =  $ObjCurrentSheet->getCellByColumnAndRow(1, 1)->getValue();
                $TopicDesc =  $ObjCurrentSheet->getCellByColumnAndRow(2, 1)->getValue();
                $URL01 = $ObjCurrentSheet->getCellByColumnAndRow(3, 1)->getValue();
                $URL01Locked = $ObjCurrentSheet->getCellByColumnAndRow(4, 1)->getValue();
                $URL02 = $ObjCurrentSheet->getCellByColumnAndRow(5, 1)->getValue();
                $URL02Locked = $ObjCurrentSheet->getCellByColumnAndRow(6, 1)->getValue();
                $URL03 = $ObjCurrentSheet->getCellByColumnAndRow(7, 1)->getValue();
                $URL03Locked = $ObjCurrentSheet->getCellByColumnAndRow(8, 1)->getValue();
                $URL04 = $ObjCurrentSheet->getCellByColumnAndRow(9, 1)->getValue();
                $URL04Locked = $ObjCurrentSheet->getCellByColumnAndRow(10, 1)->getValue();
                $Doc01 = $ObjCurrentSheet->getCellByColumnAndRow(11, 1)->getValue();
                $Doc01Locked = $ObjCurrentSheet->getCellByColumnAndRow(12, 1)->getValue();
                $Doc02 = $ObjCurrentSheet->getCellByColumnAndRow(13, 1)->getValue();
                $Doc02Locked = $ObjCurrentSheet->getCellByColumnAndRow(14, 1)->getValue();
                $Doc03 = $ObjCurrentSheet->getCellByColumnAndRow(15, 1)->getValue();
                $Doc03Locked = $ObjCurrentSheet->getCellByColumnAndRow(16, 1)->getValue();
                $Doc04 = $ObjCurrentSheet->getCellByColumnAndRow(17, 1)->getValue();
                $Doc04Locked = $ObjCurrentSheet->getCellByColumnAndRow(18, 1)->getValue();
                $Active = $ObjCurrentSheet->getCellByColumnAndRow(19, 1)->getValue();
                $Deleted = $ObjCurrentSheet->getCellByColumnAndRow(20, 1)->getValue();
                $ChangeLog = $ObjCurrentSheet->getCellByColumnAndRow(21, 1)->getValue();
                if( ($TopicID != "Topic ID" 
                        || $TopicName != "Topic Name"
                        || $TopicDesc != "Topic Desc"
                        || $URL01 != "URL 01" 
                        || $URL01Locked != "URL_01_Locked" 
                        || $URL02 != "URL 02" 
                        || $URL02Locked != "URL_02_Locked" 
                        || $URL03 != "URL 03" 
                        || $URL03Locked != "URL_03_Locked" 
                        || $URL04 != "URL 04" 
                        || $URL04Locked != "URL_04_Locked"
                        || $Doc01 != "Doc 01" 
                        || $Doc01Locked != "Doc_01_Locked" 
                        || $Doc02 != "Doc 02" 
                        || $Doc02Locked != "Doc_02_Locked" 
                        || $Doc03 != "Doc 03" 
                        || $Doc03Locked != "Doc_03_Locked" 
                        || $Doc04 != "Doc 04" 
                        || $Doc04Locked != "Doc_04_Locked"
                        || $Active != "Active"
                        || $Deleted != "Deleted"
                        || $ChangeLog != "ChangeLog")    )
                {
                    $Error = 1;   
                    $results[] = array(
                      'TopSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Error: Invalid File Format. The Colun Order Missing.Please check below line for file format."
                   ); 
                     $results[] = array(
                      'TopSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Topic ID|Topic Name|Topic Desc|URL 01|URL_01_Locked|URL 02|URL_02_Locked|URL 03|URL_03_Locked|URL 04|URL_04_Locked|Doc 01|Doc_01_Locked|Doc 02|Doc_02_Locked|Doc 03|Doc_03_Locked|Doc 04|Doc_04_Locked|Active|Deleted|ChangeLog"
                   ); 
                }                                
            
            if($Error == 0)
            {
                for ($row = 2; $row <= $highestRow; ++ $row) {
                    $Currow = $ObjCurrentSheet->getRowIterator($row)->current();
                    $cellIterator = $Currow->getCellIterator();
                    $cellIterator->setIterateOnlyExistingCells(false);
                    $TopicID = $ObjCurrentSheet->getCellByColumnAndRow(0, $row)->getValue();
                    $TopicName =  $ObjCurrentSheet->getCellByColumnAndRow(1, $row)->getValue();
                    $TopicDesc =  $ObjCurrentSheet->getCellByColumnAndRow(2, $row)->getValue();
                    $URL01 = $ObjCurrentSheet->getCellByColumnAndRow(3, $row)->getValue();
                    $URL01Locked = $ObjCurrentSheet->getCellByColumnAndRow(4, $row)->getValue();
                    $URL02 = $ObjCurrentSheet->getCellByColumnAndRow(5, $row)->getValue();
                    $URL02Locked = $ObjCurrentSheet->getCellByColumnAndRow(6, $row)->getValue();
                    $URL03 = $ObjCurrentSheet->getCellByColumnAndRow(7, $row)->getValue();
                    $URL03Locked = $ObjCurrentSheet->getCellByColumnAndRow(8, $row)->getValue();
                    $URL04 = $ObjCurrentSheet->getCellByColumnAndRow(9, $row)->getValue();
                    $URL04Locked = $ObjCurrentSheet->getCellByColumnAndRow(10, $row)->getValue();
                    $Doc01 = $ObjCurrentSheet->getCellByColumnAndRow(11, $row)->getValue();
                    $Doc01Locked = $ObjCurrentSheet->getCellByColumnAndRow(12, $row)->getValue();
                    $Doc02 = $ObjCurrentSheet->getCellByColumnAndRow(13, $row)->getValue();
                    $Doc02Locked = $ObjCurrentSheet->getCellByColumnAndRow(14, $row)->getValue();
                    $Doc03 = $ObjCurrentSheet->getCellByColumnAndRow(15, $row)->getValue();
                    $Doc03Locked = $ObjCurrentSheet->getCellByColumnAndRow(16, $row)->getValue();
                    $Doc04 = $ObjCurrentSheet->getCellByColumnAndRow(17, $row)->getValue();
                    $Doc04Locked = $ObjCurrentSheet->getCellByColumnAndRow(18, $row)->getValue();
                    $Active = $ObjCurrentSheet->getCellByColumnAndRow(19, $row)->getValue();
                    $Deleted = $ObjCurrentSheet->getCellByColumnAndRow(20, $row)->getValue();
                    $ChangeLog = $ObjCurrentSheet->getCellByColumnAndRow(21, $row)->getValue();
                    if(!($TopicID) || $TopicID == "null" )
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Topic ID Missing At Row : " . $row
                         );
                        break;
                    }
                    
                    if( $TopicID != $row - 1 )
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Topic Serial Number Missing At Row : " . ($row - 1) . " For Topic - >" . $TopicName
                         );
                        break;
                    }
                    if(!($TopicName) || $TopicName == "null" || strlen(trim($TopicName)) == 0 )
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Topic Name Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!($TopicDesc) || $TopicDesc == "null" || strlen(trim($TopicDesc)) == 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Topic Description Missing At Row : " . $row
                         );
                        break;
                    }
                    if(($URL01) && (! $URL01Locked) && strlen(trim($URL01))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 01 Locked Status [Yes Or No] At Row : " . $row
                         );
                        break;
                    }
                    if(($URL01) && (! ($URL01Locked == "Yes" || $URL01Locked == "No"))&& strlen(trim($URL01))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 01 Locked Status [Yes Or No] Required At Row : " . $row
                         );
                        break;
                    }
                    
                    if(($URL02) && (! $URL02Locked) && strlen(trim($URL02))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 02 Locked Status [Yes Or No] At Row : " . $row
                         );
                        break;
                    }
                    if(($URL02) && (! ($URL02Locked == "Yes" || $URL02Locked == "No")) && strlen(trim($URL02))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 02 Locked Status [Yes Or No] Required At Row : " . $row
                         );
                        break;
                    }
                    
                    if(($URL03) && (! $URL03Locked) && strlen(trim($URL03))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 03 Locked Status [Yes Or No] At Row : " . $row
                         );
                        break;
                    }
                    if(($URL03) && (! ($URL03Locked == "Yes" || $URL03Locked == "No")) && strlen(trim($URL03))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 03 Locked Status [Yes Or No] Required At Row : " . $row
                         );
                        break;
                    }
                    if(($URL04) && (! $URL04Locked) && strlen(trim($URL04))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 04 Locked Status [Yes Or No] At Row : " . $row
                         );
                        break;
                    }
                    if(($URL04) && (! ($URL04Locked == "Yes" || $URL04Locked == "No")) && strlen(trim($URL04))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 04 Locked Status [Yes Or No] Required At Row : " . $row
                         );
                        break;
                    }
                    // Document Code
                    if(($Doc01) && (! $Doc01Locked) && strlen(trim($Doc01))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown URL 04 Locked Status [Yes Or No] At Row : " . $row
                         );
                        break;
                    }
                    if(($Doc01) && (! ($Doc01Locked == "Yes" || $Doc01Locked == "No")) && strlen(trim($Doc01))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown Document 01 Locked Status [Yes Or No] Required At Row : " . $row
                         );
                        break;
                    }
                    if(($Doc02) && (! $Doc02Locked) && strlen(trim($Doc02))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown Document 02 Locked Status [Yes Or No] At Row : " . $row
                         );
                        break;
                    }
                    if(($Doc02) && (! ($Doc02Locked == "Yes" || $Doc02Locked == "No")) && strlen(trim($Doc02))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown Document 02 Locked Status [Yes Or No] Required At Row : " . $row
                         );
                        break;
                    }
                    
                    if(($Doc03) && (! $Doc03Locked) && strlen(trim($Doc03))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown Document 03 Locked Status [Yes Or No] At Row : " . $row
                         );
                        break;
                    }
                    if(($Doc03) && (! ($Doc03Locked == "Yes" || $Doc03Locked == "No")) && strlen(trim($Doc03))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown Document 03 Locked Status [Yes Or No] Required At Row : " . $row
                         );
                        break;
                    }
                    if(($Doc04) && (! $Doc04Locked) && strlen(trim($Doc04))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown Document 04 Locked Status [Yes Or No] At Row : " . $row
                         );
                        break;
                    }
                    if(($Doc04) && (! ($Doc04Locked == "Yes" || $Doc04Locked == "No")) && strlen(trim($Doc04))> 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Unknown Document 04 Locked Status [Yes Or No] Required At Row : " . $row
                         );
                        break;
                    }
                    if(strlen(trim($URL01))== 0 && strlen(trim($URL02))== 0 && strlen(trim($URL03))== 0 && strlen(trim($URL04))== 0 && strlen(trim($Doc01))== 0 && strlen(trim($Doc02))== 0 && strlen(trim($Doc03))== 0 && strlen(trim($Doc04))== 0)
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "At Least One URL Or Document Required At Row : " . $row
                         );
                        break;
                    }
                    if(!(trim($Active)== "Yes" || trim($Active)== "No" ))
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Active Status [Either Yes Or No Required] At Row : " . $row
                         );
                        break;
                    }
                    if(!(trim($Deleted)== "Yes" || trim($Deleted)== "No") )
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Delete Status [Either Yes Or No Required] At Row : " . $row
                         );
                        break;
                    }
                    if(trim($ChangeLog)== "" )
                    {
                        unset($results);
                        $results[] = array(
                            'TopSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid ChangeLog. [Must Enter Log For Entry] At Row : " . $row
                         );
                        break;
                    }
                    $results[] = array(
                          'SrNo' => $TopicID,
                          'Name' => $TopicName,
                          'Desc' => $TopicDesc,
                          'URL01' => $URL01,
                          'URL01Locked' => $URL01Locked,
                          'URL02' => $URL02,
                          'URL02Locked' => $URL02Locked,
                          'URL03' => $URL03,
                          'URL03Locked' => $URL03Locked,
                          'URL04' => $URL04,
                          'URL04Locked' => $URL04Locked,
                          'Doc01' => $Doc01,
                          'Doc01Locked' => $Doc01Locked,
                          'Doc02' => $Doc02,
                          'Doc02Locked' => $Doc02Locked,
                          'Doc03' => $Doc03,
                          'Doc03Locked' => $Doc03Locked,
                          'Doc04' => $Doc04,
                          'Doc04Locked' => $Doc04Locked,
                          'Active' => $Active,
                          'Deleted' => $Deleted,
                          'ChangeLog' => $ChangeLog
                       );

                }
            }
            $objXLS->disconnectWorksheets();
                unset($objXLS);
       }
       $json = json_encode($results);
       echo $json;
    }
    if($_GET['CallID']=='ReadFAQ')
    {   
        $objXLS = PHPExcel_IOFactory::load('../Upload/' . $_GET['XXX01']);
        $results = array();
        if($_GET['XXX01'] != $_GET['XXX02'])
        {
            $results[] = array(
                      'FAQSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Error: Invalid Course File Selected. Course File Name Must Match With Selected Course File Name From Drop Down."
                   );           
        }
        //$Reader->setReadDataOnly(true); // set this, to not read all excel properties, just data
        //$objXLS = $Reader->load($file);
       else
       {
            $ObjCurrentSheet = $objXLS->setActiveSheetIndex(0);
            
            //$ObjCurrentSheet->$objXLS->getSheet(0);
            $highestRow = $ObjCurrentSheet->getHighestRow();
            $highestColumn = $ObjCurrentSheet->getHighestColumn();
            $Error = 0;
            
                $Currow = $ObjCurrentSheet->getRowIterator(1)->current();
                $cellIterator = $Currow->getCellIterator();
                $cellIterator->setIterateOnlyExistingCells(false);
                $FAQID = $ObjCurrentSheet->getCellByColumnAndRow(0, 1)->getValue();
                $FAQ =  $ObjCurrentSheet->getCellByColumnAndRow(1, 1)->getValue();
                $Answer =  $ObjCurrentSheet->getCellByColumnAndRow(2, 1)->getValue();                
                $Active =  $ObjCurrentSheet->getCellByColumnAndRow(3, 1)->getValue();                
                $Deleted =  $ObjCurrentSheet->getCellByColumnAndRow(4, 1)->getValue();                
                $ChangeLog = $ObjCurrentSheet->getCellByColumnAndRow(5, 1)->getValue();
                if( ($FAQID != "Sr. No." 
                        || $FAQ != "FAQ"
                        || $Answer != "Answer"  
                        || $Active != "Active"  
                        || $Deleted != "Deleted"                    
                        || $ChangeLog != "ChangeLog")    )
                {
                    $Error = 1;   
                    $results[] = array(
                      'FAQSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Error: Invalid File Format. The Column Order Missing.Please check below line for file format."
                   ); 
                     $results[] = array(
                      'FAQSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Sr. No.|FAQ|Answer|Active|Deleted|ChangeLog"
                   ); 
                }                                
            
            if($Error == 0)
            {
                for ($row = 2; $row <= $highestRow; ++ $row) {
                    $Currow = $ObjCurrentSheet->getRowIterator($row)->current();
                    $cellIterator = $Currow->getCellIterator();
                    $cellIterator->setIterateOnlyExistingCells(false);
                    $FAQID = $ObjCurrentSheet->getCellByColumnAndRow(0, $row)->getValue();
                    $FAQ =  $ObjCurrentSheet->getCellByColumnAndRow(1, $row)->getValue();
                    $Answer =  $ObjCurrentSheet->getCellByColumnAndRow(2, $row)->getValue();
                    
                    $Active =  $ObjCurrentSheet->getCellByColumnAndRow(3, $row)->getValue();
                    $Deleted =  $ObjCurrentSheet->getCellByColumnAndRow(4, $row)->getValue();
                    $ChangeLog = $ObjCurrentSheet->getCellByColumnAndRow(5, $row)->getValue();
                    if(!($FAQID) || $FAQID == "null" )
                    {
                        unset($results);
                        $results[] = array(
                            'FAQSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "FAQ ID Missing At Row : " . $row
                         );
                        break;
                    }
                    
                    if( $FAQID != $row - 1 )
                    {
                        unset($results);
                        $results[] = array(
                            'FAQSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "FAQ Serial Number Missing At Row : " . ($row - 1) . " For Topic - >" . $TopicName
                         );
                        break;
                    }
                    if(!($FAQ) || $FAQ == "null" || strlen(trim($FAQ)) == 0 )
                    {
                        unset($results);
                        $results[] = array(
                            'FAQSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "FAQ Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!($Answer) || $Answer == "null" || strlen(trim($Answer)) == 0)
                    {
                        unset($results);
                        $results[] = array(
                            'FAQSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Answer Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!(trim($Active)== "Yes" || trim($Active)== "No" ))
                    {
                        unset($results);
                        $results[] = array(
                            'FAQSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Active Status [Either Yes Or No Required] At Row : " . $row
                         );
                        break;
                    }
                    if(!(trim($Deleted)== "Yes" || trim($Deleted)== "No") )
                    {
                        unset($results);
                        $results[] = array(
                            'FAQSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Delete Status [Either Yes Or No Required] At Row : " . $row
                         );
                        break;
                    }
                    if(trim($ChangeLog)== "" )
                    {
                        unset($results);
                        $results[] = array(
                            'FAQSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid ChangeLog. [Must Enter Log For Entry] At Row : " . $row
                         );
                        break;
                    }
                    $results[] = array(
                          'FAQNo' => $FAQID,
                          'FAQ' => $FAQ,
                          'Answer' => $Answer,
                          'Active' => $Active,
                          'Deleted' => $Deleted,
                          'ChangeLog' => $ChangeLog
                       );

                }
            }
            $objXLS->disconnectWorksheets();
                unset($objXLS);
       }
       $json = json_encode($results);
       echo $json;
    }
    if($_GET['CallID']=='ReadSQSet')
    {   
        $objXLS = PHPExcel_IOFactory::load('../Upload/' . $_GET['XXX01']);
        $results = array();
        if($_GET['XXX01'] != $_GET['XXX02'])
        {
            $results[] = array(
                      'QSetSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Error: Invalid Course File Selected. QuestionSet File Name Must Match With Selected Course File Name From Drop Down."
                   );           
        }
        //$Reader->setReadDataOnly(true); // set this, to not read all excel properties, just data
        //$objXLS = $Reader->load($file);
       else
       {
            $ObjCurrentSheet = $objXLS->setActiveSheetIndex(0);
            
            //$ObjCurrentSheet->$objXLS->getSheet(0);
            $highestRow = $ObjCurrentSheet->getHighestRow();
            $highestColumn = $ObjCurrentSheet->getHighestColumn();
            $Error = 0;
            
                $Currow = $ObjCurrentSheet->getRowIterator(1)->current();
                $cellIterator = $Currow->getCellIterator();
                $cellIterator->setIterateOnlyExistingCells(false);
                $TopicID = $ObjCurrentSheet->getCellByColumnAndRow(0, 1)->getValue();
                $QuestionID =  $ObjCurrentSheet->getCellByColumnAndRow(1, 1)->getValue();
                $Question =  $ObjCurrentSheet->getCellByColumnAndRow(2, 1)->getValue();                
                $Answer01 =  $ObjCurrentSheet->getCellByColumnAndRow(3, 1)->getValue();                
                $Answer01Correct =  $ObjCurrentSheet->getCellByColumnAndRow(4, 1)->getValue();                
                $Answer02 =  $ObjCurrentSheet->getCellByColumnAndRow(5, 1)->getValue();                
                $Answer02Correct =  $ObjCurrentSheet->getCellByColumnAndRow(6, 1)->getValue();                
                $Answer03 =  $ObjCurrentSheet->getCellByColumnAndRow(7, 1)->getValue();                
                $Answer03Correct =  $ObjCurrentSheet->getCellByColumnAndRow(8, 1)->getValue();                
                $Answer04 =  $ObjCurrentSheet->getCellByColumnAndRow(9, 1)->getValue();                
                $Answer04Correct =  $ObjCurrentSheet->getCellByColumnAndRow(10, 1)->getValue();
                $AnswerInTime =  $ObjCurrentSheet->getCellByColumnAndRow(11, 1)->getValue();
                $ControlType =  $ObjCurrentSheet->getCellByColumnAndRow(12, 1)->getValue();
                $Active =  $ObjCurrentSheet->getCellByColumnAndRow(13, 1)->getValue();
                $Deleted =  $ObjCurrentSheet->getCellByColumnAndRow(14, 1)->getValue();
                $ChangeLog = $ObjCurrentSheet->getCellByColumnAndRow(15, 1)->getValue();
                
                if( (trim($TopicID) != "Topic ID" 
                        || trim($QuestionID) != "Question ID"
                        || trim($Question) != "Question"  
                        || trim($Answer01) != "Answer01"  
                        || trim($Answer01Correct) != "Answer01Correct[Yes/No]"                    
                        || trim($Answer02) != "Answer02"  
                        || trim($Answer02Correct) != "Answer02Correct[Yes/No]" 
                        || trim($Answer03) != "Answer03"  
                        || trim($Answer03Correct) != "Answer03Correct[Yes/No]" 
                        || trim($Answer04) != "Answer04"  
                        || trim($Answer04Correct) != "Answer04Correct[Yes/No]"
                        ||trim($AnswerInTime) != "Answer Time in Sec"
                        ||trim($ControlType) != "Control Type[Option Or Checkbox]"
                        ||trim($Active) != "Active"
                        ||trim($Deleted) != "Deleted"
                        || trim($ChangeLog) != "ChangeLog")    )
                {
                    $Error = 1;   
                    $results[] = array(
                      'QSetSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Error: Invalid File Format. The Column Order Missing.Please check below line for file format."
                   ); 
                     $results[] = array(
                      'QSetSrNo' => "-1",
                      'Error' => "Error",
                      'ErrorDesc' => "Topic ID|Question ID|Question|Answer01|Answer01Correct[Yes/No]|Answer02|Answer02Correct[Yes/No]|Answer03|Answer03Correct[Yes/No]|Answer04|Answer04Correct[Yes/No]|Answer Time in Sec|Control Type[Option Or Checkbox]|Active|Deleted|ChangeLog"
                   ); 
                }                                
            
            if($Error == 0)
            {
                for ($row = 2; $row <= $highestRow; ++ $row) {
                    $Currow = $ObjCurrentSheet->getRowIterator($row)->current();
                    $cellIterator = $Currow->getCellIterator();
                    $cellIterator->setIterateOnlyExistingCells(false);
                $TopicID = $ObjCurrentSheet->getCellByColumnAndRow(0, $row)->getValue();
                $QuestionID =  $ObjCurrentSheet->getCellByColumnAndRow(1, $row)->getValue();
                $Question =  $ObjCurrentSheet->getCellByColumnAndRow(2, $row)->getValue();                
                $Answer01 =  $ObjCurrentSheet->getCellByColumnAndRow(3, $row)->getValue();                
                $Answer01Correct =  $ObjCurrentSheet->getCellByColumnAndRow(4, $row)->getValue();                
                $Answer02 =  $ObjCurrentSheet->getCellByColumnAndRow(5, $row)->getValue();                
                $Answer02Correct =  $ObjCurrentSheet->getCellByColumnAndRow(6, $row)->getValue();                
                $Answer03 =  $ObjCurrentSheet->getCellByColumnAndRow(7, $row)->getValue();                
                $Answer03Correct =  $ObjCurrentSheet->getCellByColumnAndRow(8, $row)->getValue();                
                $Answer04 =  $ObjCurrentSheet->getCellByColumnAndRow(9, $row)->getValue();                
                $Answer04Correct =  $ObjCurrentSheet->getCellByColumnAndRow(10, $row)->getValue();
                $AnswerInTime =  $ObjCurrentSheet->getCellByColumnAndRow(11, $row)->getValue();
                $ControlType =  $ObjCurrentSheet->getCellByColumnAndRow(12, $row)->getValue();
                $Active =  $ObjCurrentSheet->getCellByColumnAndRow(13, $row)->getValue();
                $Deleted =  $ObjCurrentSheet->getCellByColumnAndRow(14, $row)->getValue();
                $ChangeLog = $ObjCurrentSheet->getCellByColumnAndRow(15, $row)->getValue();
                    if(!($TopicID) || $TopicID == "null" )
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Topic ID Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!($QuestionID) || $QuestionID == "null" )
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Question ID Missing At Row : " . $row
                         );
                        break;
                    }
                    
                    if(!($Question) || $Question == "null" || strlen(trim($Question)) == 0 )
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Question Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!($Answer01) || $Answer01 == "null" || strlen(trim($Answer01)) == 0)
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Answer01 Missing At Row : " . $row . " | " . $Question
                         );
                        break;
                    }
                    if(!($Answer01Correct) || $Answer01Correct == "null" || strlen(trim($Answer01Correct)) == 0)
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Answer01Correct Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!(strtoupper( trim($Answer01Correct))== "YES" || strtoupper(trim($Answer01Correct))== "NO" ))
                    {
                        unset($results);
                        $results[] = array(
                            'FAQSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Answer01Correct Status [Either True Or False Required] At Row : " . $row
                         );
                        break;
                    }
                    if(!($Answer02) || $Answer02 == "null" || strlen(trim($Answer02)) == 0)
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Answer02 Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!($Answer02Correct) || $Answer02Correct == "null" || strlen(trim($Answer02Correct)) == 0)
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Answer02Correct Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!(strtoupper( trim($Answer02Correct))== "TRUE" || strtoupper(trim($Answer02Correct))== "NO" ))
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Answer02Correct Status [Either True Or False Required] At Row : " . $row
                         );
                        break;
                    }
                    if(!($Answer03) || $Answer03 == "null" || strlen(trim($Answer03)) == 0)
                    {
                      $Answer03 = "";
                    }
                    if(!($Answer03Correct) || $Answer03Correct == "null" || strlen(trim($Answer03Correct)) == 0)
                    {
                        $Answer03Correct = "";
                    }
                    
                    if(!($Answer04) || $Answer04 == "null" || strlen(trim($Answer04)) == 0)
                    {
                         $Answer04 = "";
                    }
                    if(!($Answer04Correct) || $Answer04Correct == "null" || strlen(trim($Answer04Correct)) == 0)
                    {
                        $Answer04Correct = "";
                    }
                    
                    if(!($AnswerInTime) || $AnswerInTime == "null" || strlen(trim($AnswerInTime)) == 0)
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Answer in Time Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!($ControlType) || $ControlType == "null" || strlen(trim($ControlType)) == 0)
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Control Type Missing At Row : " . $row
                         );
                        break;
                    }
                    if(!($ControlType) || strtoupper( $ControlType) == "Option" || strtoupper( $ControlType) == "Checkbox")
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Control Type [Either Option Or Checkbox Required] Missing At Row : " . $row
                         );
                        break;
                    }
                    if(strtoupper($ControlType) == "OPTION" )
                    {
                        $Counter = 0;
                        if( strtoupper( $Answer01Correct) == "TRUE")
                        {
                            $Counter = $Counter + 1;
                        }
                        if( strtoupper( $Answer02Correct) == "TRUE")
                        {
                            $Counter = $Counter + 1;
                        }
                        if( strtoupper( $Answer03Correct) == "TRUE")
                        {
                            $Counter = $Counter + 1;
                        }
                        if( strtoupper( $Answer04Correct) == "TRUE")
                        {
                            $Counter = $Counter + 1;
                        }
                        if($Counter > 1)
                        {
                            unset($results);
                            $results[] = array(
                                'QSetSrNo' => "-1",
                                'Error' => "Error",
                                'ErrorDesc' => "Invalid Answer There are more than 2 answars for option button question Missing At Row : " . $row
                             );
                            break;
                        }
                        
                    }
                    if(!(trim($Active)== "Yes" || trim($Active)== "No" ))
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Active Status [Either Yes Or No Required] At Row : " . $row
                         );
                        break;
                    }
                    if(!(trim($Deleted)== "Yes" || trim($Deleted)== "No") )
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid Delete Status [Either Yes Or No Required] At Row : " . $row
                         );
                        break;
                    }
                    if(trim($ChangeLog)== "" )
                    {
                        unset($results);
                        $results[] = array(
                            'QSetSrNo' => "-1",
                            'Error' => "Error",
                            'ErrorDesc' => "Invalid ChangeLog. [Must Enter Log For Entry] At Row : " . $row
                         );
                        break;
                    }
                    $results[] = array(
                          'QTopID' => $TopicID ,
                          'QSetSrNo' => $QuestionID,
                          'Question' => $Question,
                          'Answer01' => $Answer01,
                          'Answer01Correct' => $Answer01Correct,
                          'Answer02' => $Answer02,
                          'Answer02Correct' => $Answer02Correct,
                          'Answer03' => $Answer03,
                          'Answer03Correct' => $Answer03Correct,
                          'Answer04' => $Answer04,
                          'Answer04Correct' => $Answer04Correct,
                          'AnswerInTime' => $AnswerInTime ,
                          'ControlType' => $ControlType ,                          
                          'Active' => $Active,
                          'Deleted' => $Deleted,
                          'ChangeLog' => $ChangeLog
                       );

                }
            }
            $objXLS->disconnectWorksheets();
                unset($objXLS);
       }
       $json = json_encode($results);
       echo $json;
    }
    if($_GET['CallID']=='UploadTopic')
    {
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        //ManageAdminCourseUpload(IN ParaCourseID SMALLINT, IN ParaTopicSRNO SMALLINT, IN ParaTopicName  varchar(50), IN ParaTopicDesc  varchar(50), IN ParaURL01  varchar(500), IN ParaURL01Locked  varchar(3), IN ParaURL02  varchar(500), IN ParaURL02Locked  varchar(3), IN ParaURL03  varchar(500), IN ParaURL03Locked  varchar(3), IN ParaURL04  varchar(500), IN ParaURL04Locked  varchar(3),IN ParaDoc01  varchar(500),IN ParaDoc01Locked  varchar(3), IN ParaDoc02  varchar(500), IN ParaDoc02Locked  varchar(3), IN ParaDoc03  varchar(500), IN ParaDoc03Locked  varchar(3), IN ParaDoc04  varchar(500), IN ParaDoc04Locked  varchar(3), IN ParaChangeLog  varchar(1000),IN ParaIsActive TINYINT,IN ParaIsDeleted TINYINT, ParaUserID SMALLINT , ParaRecordID SMALLINT )
        $Uploads = $ITGObjStandardDB->get_results("CALL ManageAdminCourseUpload( " . "'" . $_GET['XXX01']  . "'," . "'" . $_GET['XXX02'] . "'," . "'" .  $_GET['XXX03']. "',". "'" .  $_GET['XXX04']. "',". "'" .  $_GET['XXX05'] . "',". "'" . $_GET['XXX06']. "',". "'" . $_GET['XXX07']. "',". "'" .  $_GET['XXX08']. "',". "'" . $_GET['XXX09']. "',". "'" .  $_GET['XXX10']. "',". "'" . $_GET['XXX11']. "',". "'" . $_GET['XXX12']. "',". "'" . $_GET['XXX13']. "'," . "'" . $_GET['XXX14']. "',". "'" . $_GET['XXX15']. "',". "'" . $_GET['XXX16']. "',". "'" . $_GET['XXX17']. "',". "'" . $_GET['XXX18']. "',". "'" . $_GET['XXX19']. "',". "'" . $_GET['XXX20']. "',". "'" . $_GET['XXX21']. "'," . "'" . $_GET['XXX22']. "'," . "'" . $_GET['XXX23']. "'," . "'" . $_GET['XXX24']. "'," . "'" . $_GET['XXX25']. "')" );
        $results = array();
        foreach ( $Uploads as $Status ) {
            $results[] = array(
                  'ResultID' => $Status->ResultID,
                  'TransMessageId' => $Status->TransMessageId,
                  'TransMessage' => $Status->TransMessage,                  
                  'TransControl' => $Status->TransControl
               );
        }
        $json = json_encode($results);
        echo $json;

    }
 }
if($_GET['CallID']=='GetTopicForGrid')
    {
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        //ManageAdminCourseUpload(IN ParaCourseID SMALLINT, IN ParaTopicSRNO SMALLINT, IN ParaTopicName  varchar(50), IN ParaTopicDesc  varchar(50), IN ParaURL01  varchar(500), IN ParaURL01Locked  varchar(3), IN ParaURL02  varchar(500), IN ParaURL02Locked  varchar(3), IN ParaURL03  varchar(500), IN ParaURL03Locked  varchar(3), IN ParaURL04  varchar(500), IN ParaURL04Locked  varchar(3),IN ParaDoc01  varchar(500),IN ParaDoc01Locked  varchar(3), IN ParaDoc02  varchar(500), IN ParaDoc02Locked  varchar(3), IN ParaDoc03  varchar(500), IN ParaDoc03Locked  varchar(3), IN ParaDoc04  varchar(500), IN ParaDoc04Locked  varchar(3), IN ParaChangeLog  varchar(1000),IN ParaIsActive TINYINT,IN ParaIsDeleted TINYINT, ParaUserID SMALLINT , ParaRecordID SMALLINT )
        $Topics = $ITGObjStandardDB->get_results("CALL ExecuteUIControls(105, " . "'" . $_GET['XXX01']. "',0,0)" );
        $results = array();
        foreach ( $Topics as $TopicRef ) {
            $results[] = array(
                  'SrNo' => $TopicRef->SrNo,
                  'TopicName' => $TopicRef->TopicName,
                  'TopicDesc' => $TopicRef->TopicDesc,                  
                  'URL01' => $TopicRef->URL01,
                  'URL01Locked' => $TopicRef->URL01Locked,
                  'URL02' => $TopicRef->URL02,
                  'URL02Locked' => $TopicRef->URL02Locked,
                  'URL03' => $TopicRef->URL03,
                  'URL03Locked' => $TopicRef->URL03Locked,
                  'URL04' => $TopicRef->URL04,
                  'URL04Locked' => $TopicRef->URL04Locked,
                  'Doc01' => $TopicRef->Doc01,
                  'Doc01Locked' => $TopicRef->Doc01Locked,
                  'Doc02' => $TopicRef->Doc02,
                  'Doc02Locked' => $TopicRef->Doc02Locked,
                  'Doc03' => $TopicRef->Doc03,
                  'Doc03Locked' => $TopicRef->Doc03Locked,
                  'Doc04' => $TopicRef->Doc04,
                  'Doc04Locked' => $TopicRef->Doc04Locked,
                  'ChangeLog' => $TopicRef->ChangeLog,
                  'IsActive' => $TopicRef->IsActive,
                  'IsDeleted' => $TopicRef->IsDeleted
               );
        }
        $json = json_encode($results);
        echo $json;

    }
    if($_GET['CallID']=='GetFAQForGrid')
    {
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        //ManageAdminCourseUpload(IN ParaCourseID SMALLINT, IN ParaTopicSRNO SMALLINT, IN ParaTopicName  varchar(50), IN ParaTopicDesc  varchar(50), IN ParaURL01  varchar(500), IN ParaURL01Locked  varchar(3), IN ParaURL02  varchar(500), IN ParaURL02Locked  varchar(3), IN ParaURL03  varchar(500), IN ParaURL03Locked  varchar(3), IN ParaURL04  varchar(500), IN ParaURL04Locked  varchar(3),IN ParaDoc01  varchar(500),IN ParaDoc01Locked  varchar(3), IN ParaDoc02  varchar(500), IN ParaDoc02Locked  varchar(3), IN ParaDoc03  varchar(500), IN ParaDoc03Locked  varchar(3), IN ParaDoc04  varchar(500), IN ParaDoc04Locked  varchar(3), IN ParaChangeLog  varchar(1000),IN ParaIsActive TINYINT,IN ParaIsDeleted TINYINT, ParaUserID SMALLINT , ParaRecordID SMALLINT )
        $FAQ = $ITGObjStandardDB->get_results("CALL ExecuteUIControls(106, " . "'" . $_GET['XXX01']. "',0,0)" );
        $results = array();
        foreach ( $FAQ as $FAQRef ) {
            $results[] = array(
                  'SrNo' => $FAQRef->SrNo,
                  'FAQ' => $FAQRef->FAQ,
                  'FAQAnswer' => $FAQRef->FAQAnswer,                                    
                  'ChangeLog' => $FAQRef->ChangeLog,
                  'IsActive' => $FAQRef->IsActive,
                  'IsDeleted' => $FAQRef->IsDeleted
               );
        }
        $json = json_encode($results);
        echo $json;

    }
    if($_GET['CallID']=='GetQSetForGrid')
    {
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        //ManageAdminCourseUpload(IN ParaCourseID SMALLINT, IN ParaTopicSRNO SMALLINT, IN ParaTopicName  varchar(50), IN ParaTopicDesc  varchar(50), IN ParaURL01  varchar(500), IN ParaURL01Locked  varchar(3), IN ParaURL02  varchar(500), IN ParaURL02Locked  varchar(3), IN ParaURL03  varchar(500), IN ParaURL03Locked  varchar(3), IN ParaURL04  varchar(500), IN ParaURL04Locked  varchar(3),IN ParaDoc01  varchar(500),IN ParaDoc01Locked  varchar(3), IN ParaDoc02  varchar(500), IN ParaDoc02Locked  varchar(3), IN ParaDoc03  varchar(500), IN ParaDoc03Locked  varchar(3), IN ParaDoc04  varchar(500), IN ParaDoc04Locked  varchar(3), IN ParaChangeLog  varchar(1000),IN ParaIsActive TINYINT,IN ParaIsDeleted TINYINT, ParaUserID SMALLINT , ParaRecordID SMALLINT )
        $QSet = $ITGObjStandardDB->get_results("CALL ExecuteUIControls(107, " . "'" . $_GET['XXX01']. "',0,0)" );
        $results = array();
        foreach ( $QSet as $QSetRef ) {
            $results[] = array(
                  'TopicName' => $QSetRef->TopicName,
                  'TopicID' => $QSetRef->TopicID,                                                      
                  'QuestionSetSrNo' => $QSetRef->QuestionSetSrNo,
                  'Question' => $QSetRef->Question,
                  'Answer01' => $QSetRef->Answer01,
                  'IsAnswer01Ok' => $QSetRef->IsAnswer01Ok,
                  'Answer02' => $QSetRef->Answer02,
                  'IsAnswer02Ok' => $QSetRef->IsAnswer02Ok,
                  'Answer03' => $QSetRef->Answer03,
                  'IsAnswer03Ok' => $QSetRef->IsAnswer03Ok,
                  'Answer04' => $QSetRef->Answer04,
                  'IsAnswer04Ok' => $QSetRef->IsAnswer04Ok,
                  'AnswerTimeInSec' => $QSetRef->AnswerTimeInSec,
                  'ControlType' => $QSetRef->ControlType,
                  'ChangeLog' => $QSetRef->ChangeLog,
                  'IsActive' => $QSetRef->IsActive,
                  'IsDeleted' => $QSetRef->IsDeleted
               );
        }
        $json = json_encode($results);
        echo $json;

    }
 if($_GET['CallID']=='UploadFAQ')
    {
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        //ManageAdminCourseUpload(IN ParaCourseID SMALLINT, IN ParaTopicSRNO SMALLINT, IN ParaTopicName  varchar(50), IN ParaTopicDesc  varchar(50), IN ParaURL01  varchar(500), IN ParaURL01Locked  varchar(3), IN ParaURL02  varchar(500), IN ParaURL02Locked  varchar(3), IN ParaURL03  varchar(500), IN ParaURL03Locked  varchar(3), IN ParaURL04  varchar(500), IN ParaURL04Locked  varchar(3),IN ParaDoc01  varchar(500),IN ParaDoc01Locked  varchar(3), IN ParaDoc02  varchar(500), IN ParaDoc02Locked  varchar(3), IN ParaDoc03  varchar(500), IN ParaDoc03Locked  varchar(3), IN ParaDoc04  varchar(500), IN ParaDoc04Locked  varchar(3), IN ParaChangeLog  varchar(1000),IN ParaIsActive TINYINT,IN ParaIsDeleted TINYINT, ParaUserID SMALLINT , ParaRecordID SMALLINT )
        $UploadFAQ = $ITGObjStandardDB->get_results("CALL ManageAdminFAQUpload( " . "'" . $_GET['XXX01']  . "'," . "'" . $_GET['XXX02'] . "'," . "'" .  $_GET['XXX03']. "',". "'" .  $_GET['XXX04']. "',". "'" .  $_GET['XXX05'] . "',". "'" . $_GET['XXX06']. "',". "'" . $_GET['XXX07']. "',". "'" .  $_GET['XXX08']. "',". "'" . $_GET['XXX09'].  "')" );
        $results = array();
        foreach ( $UploadFAQ as $Status ) {
            $results[] = array(
                  'ResultID' => $Status->ResultID,
                  'TransMessageId' => $Status->TransMessageId,
                  'TransMessage' => $Status->TransMessage,                  
                  'TransControl' => $Status->TransControl
               );
        }
        $json = json_encode($results);
        echo $json;

    }
    if($_GET['CallID']=='UploadQSet')
    {
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        //ManageAdminCourseUpload(IN ParaCourseID SMALLINT, IN ParaTopicSRNO SMALLINT, IN ParaTopicName  varchar(50), IN ParaTopicDesc  varchar(50), IN ParaURL01  varchar(500), IN ParaURL01Locked  varchar(3), IN ParaURL02  varchar(500), IN ParaURL02Locked  varchar(3), IN ParaURL03  varchar(500), IN ParaURL03Locked  varchar(3), IN ParaURL04  varchar(500), IN ParaURL04Locked  varchar(3),IN ParaDoc01  varchar(500),IN ParaDoc01Locked  varchar(3), IN ParaDoc02  varchar(500), IN ParaDoc02Locked  varchar(3), IN ParaDoc03  varchar(500), IN ParaDoc03Locked  varchar(3), IN ParaDoc04  varchar(500), IN ParaDoc04Locked  varchar(3), IN ParaChangeLog  varchar(1000),IN ParaIsActive TINYINT,IN ParaIsDeleted TINYINT, ParaUserID SMALLINT , ParaRecordID SMALLINT )
        $UploadFAQ = $ITGObjStandardDB->get_results("CALL ManageAdminQSetUpload( " . "'" . $_GET['XXX01']  . "'," . "'" . $_GET['XXX02'] . "'," . "'" .  $_GET['XXX03']. "',". "'" .  $_GET['XXX04']. "',". "'" .  $_GET['XXX05'] . "',". "'" . $_GET['XXX06']. "',". "'" . $_GET['XXX07']. "',". "'" .  $_GET['XXX08']. "',". "'" . $_GET['XXX09']. "',". "'" . $_GET['XXX10']. "',". "'" . $_GET['XXX11']. "',". "'" . $_GET['XXX12']. "',". "'" . $_GET['XXX13']. "',". "'" . $_GET['XXX14']. "',". "'" . $_GET['XXX15']. "',". "'" . $_GET['XXX16']. "',". "'" . $_GET['XXX17']. "',". "'" . $_GET['XXX18']. "',". "'" . $_GET['XXX19'].  "')" );
        $results = array();
        foreach ( $UploadFAQ as $Status ) {
            $results[] = array(
                  'ResultID' => $Status->ResultID,
                  'TransMessageId' => $Status->TransMessageId,
                  'TransMessage' => $Status->TransMessage,                  
                  'TransControl' => $Status->TransControl
               );
        }
        $json = json_encode($results);
        echo $json;

    }