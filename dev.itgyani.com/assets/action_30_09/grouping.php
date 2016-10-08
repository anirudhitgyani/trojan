<?php include('../connection.php'); 
    
	$action = $_REQUEST['action'];
	
    if($action=='insert_category'){
		$CategoryName = $_REQUEST['CategoryName'];
		$sql = mysql_query("select * from coursecategory where CategoryName = '".$CategoryName."' ");
		$total_rows = mysql_num_rows($sql);
		if($total_rows!=''){
			echo "0";
		} else {
			$sql = mysql_query("insert into coursecategory set CategoryName = '".$CategoryName."' ");
			echo "1";
		}
		exit();
	}
	
	if($action=='select_category'){
		$CourseCategoryID = $_REQUEST['CourseCategoryID'];
		$sql = mysql_query("select * from `grouping` where CourseCategoryID = '".$CourseCategoryID."' ");
		?>
        
        <div id="course_list">
            <ul>
            <?php while($row = mysql_fetch_array($sql)) { ?>
                <li style="cursor: pointer;"  ondblclick="RemoveCategory('<?php echo $row['CourseID']; ?>','<?php echo $CourseCategoryID; ?>');" ><?php echo $row['CourseName']; ?></li>
            <?php } ?>    
            </ul>
        </div>
        
	<?php exit(); }
	
	if($action=='set_grouping'){
		$CourseID = $_REQUEST['CourseID'];
		$CourseCategoryID = $_REQUEST['CourseCategoryID'];
                $sql_course = mysql_query("select CourseName from course where CourseID = '".$CourseID."' ");
                $row_course = mysql_fetch_array($sql_course);
                $sql_coursecat = mysql_query("select CategoryName from coursecategory where CourseCategoryID = '".$CourseCategoryID."' ");
                $row_coursecat = mysql_fetch_array($sql_coursecat);
                $sql_check = mysql_query("select * from `grouping` where CourseCategoryID = '".$CourseCategoryID."' AND CourseID = '".$CourseID."' ");
                $row_check = mysql_fetch_array($sql_check);
                if(!empty($row_check)){
                    echo "0";
                    exit();
                } else {
                   
                    $sql_update = mysql_query("insert into `grouping` set CourseCategoryID = '".$CourseCategoryID."' , CourseID = '".$CourseID."' , CourseName = '".$row_course['CourseName']."' , CategoryName = '".$row_coursecat['CategoryName']."' , Status = '1' ");
                    $sql = mysql_query("select * from `grouping` where CourseCategoryID = '".$CourseCategoryID."' ");
		?>
        
                    <div id="course_list">
                        <ul>
                        <?php while($row = mysql_fetch_array($sql)) { ?>
                            <li style="cursor: pointer;" ondblclick="RemoveCategory('<?php echo $row['CourseID']; ?>','<?php echo $CourseCategoryID; ?>');" ><?php echo $row['CourseName']; ?></li>
                        <?php } ?>    
                        </ul>
                    </div>
        
	<?php exit(); }
        exit();
	}
	
	
	
	if($action=='remove_category'){
		$CourseID = $_REQUEST['CourseID'];
		$CourseCategoryID = $_REQUEST['CourseCategoryID'];
		$sql_update = mysql_query("delete from `grouping` where CourseCategoryID = '".$CourseCategoryID."' AND CourseID = '".$CourseID."' ");
                $sql = mysql_query("select * from `grouping` where CourseCategoryID = '".$CourseCategoryID."' ");
	?>
    	<div id="course_list">
            <ul>
            <?php while($row = mysql_fetch_array($sql)) { ?>
                <li style="cursor: pointer;" ondblclick="RemoveCategory('<?php echo $row['CourseID']; ?>','<?php echo $CourseCategoryID; ?>');" ><?php echo $row['CourseName']; ?></li>
            <?php } ?>    
            </ul>
        </div>
    	
    <?php
	exit();
	}
	
		
?> 