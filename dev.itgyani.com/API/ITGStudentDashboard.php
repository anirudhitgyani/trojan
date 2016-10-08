<?php
include_once('../config/ITGStandardPHPPageDBConfig.php'); 
include_once('../config/ez_sql_core.php'); 
include_once('../config/ez_sql_mysql.php');
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
session_start();
//echo print_r($_SESSION['profile']);
 
$Profile = $_SESSION['profile'];
$ID = $Profile[0]['ProfileID'];
//echo print_r( $Profile);
if($_GET['CallID']=='TreeView')
    {            
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $Courses = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '102' , '' , '' , '" . $ID . "' );");
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
        $Courses = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '103' , '' , '" . $_GET['XXX01']. "' , '" . $ID . "' );");
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
        $Courses = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '104' ,  '" . $_GET['XXX01']. "' ,'' , '" . $ID . "' );");
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
    
    if($_GET['CallID']=='TopicList')
    {            
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $Topics = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '109' , '" . $_GET['XXX01']. "' , '' , '" . $ID . "' );");
        $results = array();
        foreach ( $Topics as $Topic ) {
            $results[] = array(
                  'TopicID' => $Topic->TopicID,
                  'TopicName' => $Topic->TopicName
               );
        }
        $json = json_encode($results);
    echo $json;

    }
    if($_GET['CallID']=='TopicPanel')
    {            
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $Topics = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '110' , '" . $_GET['XXX01']. "' , '' , '" . $ID . "' );");
        $results = array();
        foreach ( $Topics as $Topic ) {
            $results[] = array(
                  'TopicID' => $Topic->TopicID,
                  'TopicSRNO' => $Topic->TopicSRNO,
                  'TopicName' => $Topic->TopicName,
                  'TopicDesc' => $Topic->TopicDesc,
                  'URL01' => $Topic->URL01,
                  'URL01Locked' => $Topic->URL01Locked,
                  'URL02' => $Topic->URL02,
                  'URL02Locked' => $Topic->URL02Locked,
                  'URL03' => $Topic->URL03,
                  'URL03Locked' => $Topic->URL03Locked,
                  'URL04' => $Topic->URL04,
                  'URL04Locked' => $Topic->URL04Locked,
                  'DOC01' => $Topic->DOC01,
                  'DOC01Locked' => $Topic->DOC01Locked,
                  'DOC02' => $Topic->DOC02,
                  'DOC02Locked' => $Topic->DOC02Locked,
                  'DOC03' => $Topic->DOC03,
                  'DOC03Locked' => $Topic->DOC03Locked,
                  'DOC04' => $Topic->DOC04,
                  'DOC04Locked' => $Topic->DOC04Locked,
                  'IsPaid' => $Topic->IsPaid
               );
        }
        $json = json_encode($results);
    echo $json;

    }
    if($_GET['CallID']=='DocList')
    {            
        $ITGObjStandardDB = new ezSQL_mysql(dbuser,dbpassword,mdb,mdbserver);
        $Topics = $ITGObjStandardDB->get_results("CALL ExecuteUIControls( '111' , '" . $_GET['XXX01']. "' , '' , '" . $ID . "' );");
        $results = array();
        foreach ( $Topics as $Topic ) {
            $results[] = array(
                  'DOC' => $Topic->DOC
               );
        }
        $json = json_encode($results);
    echo $json;

    }