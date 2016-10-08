<?php include('../connection.php'); 
    
	$action = $_REQUEST['action'];
	$CourseID = $_REQUEST['CourseID'];
	//$CourseCategoryID = $_REQUEST['CourseCategoryID'];
    $CourseName = $_REQUEST['CourseName'];
    $CourseDesc = $_REQUEST['CourseDesc'];
    $ImageName = $_FILES['ImageName']['name'];
        
	if($action=="insert") {
            $sql = mysql_query("insert into `course` set CourseName = '".$CourseName."' , CourseDesc = '".$CourseDesc."'  ");
            $lastid = mysql_insert_id();
            if($ImageName != ''){
		
			$Image = "CourseImage_".$lastid.strrchr(basename($ImageName),'.');
			copy($_FILES["ImageName"]["tmp_name"],"../upload_images/course_images/".$Image);
			
			$sql = mysql_query("update `course` set ImageName = '".$Image."' where CourseID = '".$lastid."' ");
		
            }
            $_SESSION['success'] = "Your Course Successfully Added!!!";
            header("location:".$AdminPath."pages/course/");
            exit();
	}
	
	if($action=="update") {
            
            $sql = mysql_query("update `course` set  CourseName = '".$CourseName."' , CourseDesc = '".$CourseDesc."'  where CourseID = '".$CourseID."' ");
            if($ImageName != ''){
		
			$Image = "CourseImage_".$CourseID.strrchr(basename($ImageName),'.');
			copy($_FILES["ImageName"]["tmp_name"],"../upload_images/course_images/".$Image);
			
			$sql = mysql_query("update `course` set ImageName = '".$Image."' where CourseID = '".$CourseID."' ");
		
            }
            $_SESSION['success'] = "Your Course Successfully Updated!!!";
            header("location:".$AdminPath."pages/course/");
            exit();
		
	}
	
	if($action=="delete") {
		
            $sql1 = mysql_query("select * from `course` where CourseID = '".$CourseID."' ") or die(mysql_error());
            $row1 = mysql_fetch_array($sql1);
            $filename = $AdminPath."upload_images/course_images/".$row1['ImageName']; 
            unlink($filename);
           
			$sql_topic = mysql_query("select * from `topic` where CourseID = '".$CourseID."' ");
			while($row_topic = mysql_fetch_array($sql_topic)){
				$sql_question = mysql_query("delete from QuestionSet where TopicID = '".$row_topic['TopicID']."' ");
			}
			
			$sql = mysql_query("delete from `faq` where CourseID = '".$CourseID."' ") or die(mysql_error());
			
			$sql = mysql_query("delete from `topic` where CourseID = '".$CourseID."' ") or die(mysql_error());
			
			$sql = mysql_query("delete from `course` where CourseID = '".$CourseID."' ") or die(mysql_error());
			
			
            exit();
	}
        
        if($action=="add_topic"){
            
            $sql1 = mysql_query("select * from `course` where CourseID = '".$CourseID."' ") or die(mysql_error());
            $row1 = mysql_fetch_array($sql1);
            
            $topic_file = $_FILES['topic_file']['name'];
            if($topic_file != ''){
        
                $NewFilename = $row1['CourseName'].strrchr(basename($topic_file),'.');
                copy($_FILES["topic_file"]["tmp_name"],"../upload_images/course_files/".$NewFilename);

                //echo "update course set Filename = '".$NewFilename."' where CourseID = '".$LastID."' ";
                $sql = mysql_query("update course set FileName = '".$NewFilename."' where CourseID = '".$CourseID."' ") or die(mysql_error());

                //exit();
            }
            
            $sql2 = mysql_query("select * from course where CourseID = '".$CourseID."' ") or die(mysql_error());
            $row2 = mysql_fetch_array($sql2);
    
            require('spreadsheet-reader-master/php-excel-reader/excel_reader2.php');
            require('spreadsheet-reader-master/SpreadsheetReader.php');
            $Reader = new SpreadsheetReader("../upload_images/course_files/".$row2['FileName']);
            $Sheets = $Reader->Sheets();
            $Reader->ChangeSheet($Sheets);
            foreach ($Reader as $Row) {
                $num = count($Row);
                for ($c = 0; $c < $num; $c++) {
                    $col[$c] = $Row[$c];
                }
				$TopicName = $col[1];
				$TopicDesc = $col[2];
				$URL01 = $col[3];
				if($col[4]=='Yes') {
					$URL01Locked ='1';
				} else {
					$URL01Locked ='0';
				}
				$URL02 = $col[5];
				if($col[6]=='Yes') {
					$URL02Locked ='1';
				} else {
					$URL02Locked ='0';
				}
				$URL03 = $col[7];
				if($col[8]=='Yes') {
					$URL03Locked ='1';
				} else {
					$URL03Locked ='0';
				}
				$URL04 = $col[9];
				if($col[10]=='Yes') {
					$URL04Locked ='1';
				} else {
					$URL04Locked ='0';
				}
				$Doc01 = $col[11];
				if($col[12]=='Yes') {
					$Doc01Locked ='1';
				} else {
					$Doc01Locked ='0';
				}
				$Doc02 = $col[13];
				if($col[14]=='Yes') {
					$Doc02Locked ='1';
				} else {
					$Doc02Locked ='0';
				}
				$Doc03 = $col[15];
				if($col[16]=='Yes') {
					$Doc03Locked ='1';
				} else {
					$Doc03Locked ='0';
				}
				$Doc04 = $col[17];
				if($col[18]=='Yes') {
					$Doc04Locked ='1';
				} else {
					$Doc04Locked ='0';
				}
				
				if($col[19]=='Yes') {
					$IsActive ='1';
				} else {
					$IsActive ='0';
				}
				
				if($col[20]=='Yes') {
					$IsDeleted ='1';
				} else {
					$IsDeleted ='0';
				}
				
				$ChangeLog = $col[21];
				
				if ($CourseID != 'CourseID' && $TopicName != 'TopicName' && $TopicDesc!='TopicDesc' 		&& $URL01 != 'URL01' && $URL01Locked != 'URL_01_Locked' && $URL02 != 'URL02' && $URL02Locked != 'URL_02_Locked' && $URL03 != 'URL03' && $URL03Locked != 'URL_03_Locked' && $URL04 != 'URL04' && $URL04Locked != 'URL_04_Locked' && $Doc01 != 'Doc 01' && $Doc01Locked != 'Doc_01_Locked' && $Doc02 != 'Doc 02' && $Doc02Locked != 'Doc_02_Locked' && $Doc03 != 'Doc 03' && $Doc03Locked != 'Doc_03_Locked' && $Doc04 != 'Doc 04' && $Doc04Locked != 'Doc_04_Locked' && $IsActive != 'Active' && $IsDeleted != 'Deleted' && $ChangeLog != 'ChangeLog' ) {
				
				$sql_check = mysql_query("select * from `topic` where CourseID = '".$CourseID."' AND TopicName = '".$TopicName."' ");
				$total_check = mysql_num_rows($sql_check);
				
					if($total_check=='0') { 
					
                    	$sql2 = mysql_query("insert into topic set CourseID = '".$CourseID."' , TopicName = '".$TopicName."' , TopicDesc = '".$TopicDesc."' , URL01 = '".$URL01."' , URL01Locked = '".$URL01Locked."' , URL02 = '".$URL02."' , URL02Locked = '".$URL02Locked."' , URL03 = '".$URL03."' , URL03Locked = '".$URL03Locked."' , URL04 = '".$URL04."' , URL04Locked = '".$URL04Locked."' , Doc01 = '".$Doc01."' , Doc01Locked = '".$Doc01Locked."' , Doc02 = '".$Doc02."' , Doc02Locked = '".$Doc02Locked."' , Doc03 = '".$Doc03."' , Doc03Locked = '".$Doc03Locked."' , Doc04 = '".$Doc04."' , Doc04Locked = '".$Doc04Locked."' ,  IsActive = '".$IsActive."' , IsDeleted = '".$IsDeleted."'  ");
					}
                }
            }   
            
        header("location:".$AdminPath."pages/topic/");
		exit();
		
		}
		
		if($action=='add_faqs'){
		
			$CourseID = $_REQUEST['CourseID'];
			$faqs_file = $_FILES['faqs_file']['name'];
            if($faqs_file != ''){
        
               $NewFilename = "faqs_".$CourseID.strrchr(basename($faqs_file),'.');
               copy($_FILES["faqs_file"]["tmp_name"],"../upload_images/faqs_file/".$NewFilename);
			}
			
			
			require('spreadsheet-reader-master/php-excel-reader/excel_reader2.php');
            require('spreadsheet-reader-master/SpreadsheetReader.php');
            $Reader = new SpreadsheetReader("../upload_images/faqs_file/faqs_".$CourseID.".xlsx");
            $Sheets = $Reader->Sheets();
            $Reader->ChangeSheet($Sheets);
            foreach ($Reader as $Row) {
                $num = count($Row);
                for ($c = 0; $c < $num; $c++) {
                    $col[$c] = $Row[$c];
                }
				
				$FAQSRNO = $col[0];
				$FAQ = $col[1];
				$FAQAnswer = $col[2];
				if($col[3]=='Yes'){
					$IsActive = '1';
				} else {
					$IsActive = '0';
				}
				if($col[4]=='Yes'){
					$IsDeleted = '1';
				} else {
					$IsDeleted = '0';
				}
				$ChangeLog = $col[5];
				
				if($FAQSRNO != 'Sr. No.' && $FAQ != 'FAQ' && $FAQAnswer != 'Answer' && $IsActive != 'Active' && $IsDeleted != 'Deleted' && $ChangeLog != 'ChangeLog' ) {
				
				
				$sql_check = mysql_query("select * from `faq` where CourseID = '".$CourseID."' AND FAQ = '".$FAQ."' ");
				$total_check = mysql_num_rows($sql_check);
				
					if($total_check=='0') { 
				
						$sql = mysql_query("insert into `faq` set CourseID = '".$CourseID."' , FAQSRNO = '".$FAQSRNO."' , FAQ = '".$FAQ."' , FAQAnswer = '".$FAQAnswer."' , IsActive = '".$IsActive."' , IsDeleted = '".$IsDeleted."' ");
					
					}
				
				}
				
			}
            
			
			
			
			header("location:".$AdminPath."pages/faqs/");
			exit();
			
			
		}
		
		
		
		if($action=='add_qa'){
		
			$CourseID = $_REQUEST['CourseID'];
			
			//$sql_delete = mysql_query("delete from `QuestionSet` where CourseID = '".$CourseID."' ");
			
			$qa_file = $_FILES['qa_file']['name'];
            if($qa_file != ''){
        
               $NewFilename = "qa_".$CourseID.strrchr(basename($qa_file),'.');
               copy($_FILES["qa_file"]["tmp_name"],"../upload_images/qa_files/".$NewFilename);
			
			}
			
			$sql_topic = mysql_query("select * from `topic` where CourseID = '".$CourseID."' order by TopicID asc limit 0,1 ");
			$row_topic = mysql_fetch_array($sql_topic);
			
			
			
			require('spreadsheet-reader-master/php-excel-reader/excel_reader2.php');
            require('spreadsheet-reader-master/SpreadsheetReader.php');
            $Reader = new SpreadsheetReader("../upload_images/qa_files/qa_".$CourseID.".xlsx");
            $Sheets = $Reader->Sheets();
            $Reader->ChangeSheet($Sheets);
            foreach ($Reader as $Row) {
                $num = count($Row);
                for ($c = 0; $c < $num; $c++) {
                    $col[$c] = $Row[$c];
                }
				
				//$TopicID = $col[0];
				$QuestionSetSrNo = $col[1];
				$Question = $col[2];
				$Answer01 = $col[3];
				if($col[4]=='Yes'){
					$IsAnswer01Ok = '1';
				} else {
					$IsAnswer01Ok = '0';
				}
				$Answer02 = $col[5];
				if($col[6]=='Yes'){
					$IsAnswer02Ok = '1';
				} else {
					$IsAnswer02Ok = '0';
				}
				$Answer03 = $col[7];
				if($col[8]=='Yes'){
					$IsAnswer03Ok = '1';
				} else {
					$IsAnswer03Ok = '0';
				}
				$Answer04 = $col[9];
				if($col[10]=='Yes'){
					$IsAnswer04Ok = '1';
				} else {
					$IsAnswer04Ok = '0';
				}
				$AnswerTimeInSec = $col[11];
				$ControlType = $col[12];
				if($col[13]=='Yes'){
					$IsActive = '1';
				} else {
					$IsActive = '0';
				}
				if($col[14]=='Yes'){
					$IsDeleted = '1';
				} else {
					$IsDeleted = '0';
				}
				$ChangeLog = $col[15];
				
				
				
				
				if($TopicID != 'TopicID' && $QuestionSetSrNo != 'Question ID' && $Question != 'Question'  && $Answer01 != 'Answer01' && $IsAnswer01Ok != 'Answer01Correct[Yes/No]' &&  $Answer02 != 'Answer02' && $IsAnswer02Ok != 'Answer02Correct[Yes/No]' &&  $Answer03 != 'Answer03' && $IsAnswer03Ok != 'Answer03Correct[Yes/No]' &&  $Answer04 != 'Answer04' && $IsAnswer04Ok != 'Answer04Correct[Yes/No]' && $AnswerTimeInSec != 'Answer Time in Sec' && $ControlType != 'Control Type[Option Or Checkbox]' && $IsActive != 'Active' && $IsDeleted != 'Deleted' && $ChangeLog != 'ChangeLog' ){
					
					if($col[0]=='1'){
						$TopicID = $row_topic['TopicID'];
					} else if($col[0]=='2'){
						$TopicID = $row_topic['TopicID'] + 1;
					} else if($col[0]=='3'){
						$TopicID = $row_topic['TopicID'] + 2;
					} else if($col[0]=='4'){
						$TopicID = $row_topic['TopicID'] + 3;
					} else if($col[0]=='5'){
						$TopicID = $row_topic['TopicID'] + 4;
					} else if($col[0]=='6'){
						$TopicID = $row_topic['TopicID'] + 5;
					} else if($col[0]=='7'){
						$TopicID = $row_topic['TopicID'] + 6;
					} else if($col[0]=='8'){
						$TopicID = $row_topic['TopicID'] + 7;
					} else if($col[0]=='9'){
						$TopicID = $row_topic['TopicID'] + 8;
					} else if($col[0]=='10'){
						$TopicID = $row_topic['TopicID'] + 9;
					} else if($col[0]=='11'){
						$TopicID = $row_topic['TopicID'] + 10;
					} else if($col[0]=='12'){
						$TopicID = $row_topic['TopicID'] + 11;
					} else if($col[0]=='13'){
						$TopicID = $row_topic['TopicID'] + 12;
					} else if($col[0]=='14'){
						$TopicID = $row_topic['TopicID'] + 13;
					} else if($col[0]=='15'){
						$TopicID = $row_topic['TopicID'] + 14;
					} else if($col[0]=='16'){
						$TopicID = $row_topic['TopicID'] + 15;
					} else if($col[0]=='17'){
						$TopicID = $row_topic['TopicID'] + 16;
					} else if($col[0]=='18'){
						$TopicID = $row_topic['TopicID'] + 17;
					} else if($col[0]=='19'){
						$TopicID = $row_topic['TopicID'] + 18;
					} else if($col[0]=='20'){
						$TopicID = $row_topic['TopicID'] + 19;
					} else if($col[0]=='21'){
						$TopicID = $row_topic['TopicID'] + 20;
					} else if($col[0]=='22'){
						$TopicID = $row_topic['TopicID'] + 21;
					} else if($col[0]=='23'){
						$TopicID = $row_topic['TopicID'] + 22;
					} else if($col[0]=='24'){
						$TopicID = $row_topic['TopicID'] + 23;
					} else if($col[0]=='25'){
						$TopicID = $row_topic['TopicID'] + 24;
					} else if($col[0]=='26'){
						$TopicID = $row_topic['TopicID'] + 25;
					} else if($col[0]=='27'){
						$TopicID = $row_topic['TopicID'] + 26;
					} else if($col[0]=='28'){
						$TopicID = $row_topic['TopicID'] + 27;
					} else if($col[0]=='29'){
						$TopicID = $row_topic['TopicID'] + 28;
					} else if($col[0]=='30'){
						$TopicID = $row_topic['TopicID'] + 29;
					} else if($col[0]=='31'){
						$TopicID = $row_topic['TopicID'] + 30;
					} else if($col[0]=='32'){
						$TopicID = $row_topic['TopicID'] + 31;
					} else if($col[0]=='33'){
						$TopicID = $row_topic['TopicID'] + 32;
					} else if($col[0]=='34'){
						$TopicID = $row_topic['TopicID'] + 33;
					} else if($col[0]=='35'){
						$TopicID = $row_topic['TopicID'] + 34;
					} else if($col[0]=='36'){
						$TopicID = $row_topic['TopicID'] + 35;
					}
				
						$sql = mysql_query("insert into `QuestionSet` set TopicID = '".$TopicID."' , QuestionSetSrNo = '".$QuestionSetSrNo."' , Question = '".$Question."' , Answer01 = '".$Answer01."' , IsAnswer01Ok = '".$IsAnswer01Ok."' , Answer02 = '".$Answer02."' , IsAnswer02Ok = '".$IsAnswer02Ok."' , Answer03 = '".$Answer03."' , IsAnswer03Ok = '".$IsAnswer03Ok."' , Answer04 = '".$Answer04."' , IsAnswer04Ok = '".$IsAnswer04Ok."' ,  AnswerTimeInSec = '".$AnswerTimeInSec."' , ControlType = '".$ControlType."' , IsActive = '".$IsActive."' , IsDeleted = '".$IsDeleted."'  ");
					
					
					
				}
				
			}
			
			header("location:".$AdminPath."pages/question_answers/");
			exit();
			
			
		}
		
		if($action=="update_topic") {
	
	echo "insert";
		$TopicDesc = $_REQUEST['TopicDesc'];
		$URL01 = $_REQUEST['URL01'];
		$URL02 = $_REQUEST['URL02'];
		$URL03 = $_REQUEST['URL03'];
		$URL04 = $_REQUEST['URL04'];
		$Doc01 = $_REQUEST['Doc01'];
		$Doc02 = $_REQUEST['Doc02'];
		$Doc03 = $_REQUEST['Doc03'];
		$Doc04 = $_REQUEST['Doc04'];
		
		$sql = mysql_query("update `topic` set TopicDesc = '".$TopicDesc."' ,  URL01 = '".$URL01."' , URL02 = '".$URL02."' , URL03 = '".$URL03."' , URL04 = '".$URL04."'  , Doc01 = '".$Doc01."' , Doc02 = '".$Doc02."' , Doc03 = '".$Doc03."' , Doc04 = '".$Doc04."' where TopicID = '".$TopicID."' "); 
		$_SESSION['success'] = "Your Topic Successfully Updated...";
		//header("location:".$AdminPath."pages/topic/");
		//exit();
	
	}	
		
		
		
		
		
		
		
		
?> 