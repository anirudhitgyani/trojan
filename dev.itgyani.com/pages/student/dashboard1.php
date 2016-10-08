<?php include('../../connection.php');

$sql_user = mysql_query("select * from `profile` where ProfileID = '".$_SESSION['stud_id']."' ") or die(mysql_error());
$row_user = mysql_fetch_array($sql_user);

header("location:".$RootPath."pages/student/dashboard.php?CourseID=".$row_user['LastCourseID']."&TopicID=".$row_user['LastTopicID']);
exit();
?>