
<?php

include_once('../config/ITGStandardPHPPageDBConfig.php'); 
include_once('../config/ez_sql_core.php'); 
include_once('../config/ez_sql_mysql.php');
require('../Classes/PHPExcel/IOFactory.php');

if(isset($_GET['CallID']))
 {
        if($_GET['CallID']=='CourseList')
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
        if($_GET['CallID']=='ManageCareerPath')
            {            
                $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
                $Courses = $ITGObjStandardDB->get_results("CALL ManageAdminCareerPath('" . $_GET['XXX01']. "','" . $_GET['XXX02']. "','" . $_GET['XXX03']. "','" . $_GET['XXX04']. "','" . $_GET['XXX05']. "','" . $_GET['XXX06']. "')" );
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
 }