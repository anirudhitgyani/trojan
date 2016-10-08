<?php include('../connection.php'); 
    $action = $_REQUEST['action'];
    
    if($action=='login') {
        $ProfileName = $_REQUEST['ProfileName'];
        $ProfilePassword = $_REQUEST['ProfilePassword'];
        
        $sql = mysql_query("select * from `profile` where ProfileName = '".$ProfileName."' AND ProfilePassword = '".md5($ProfilePassword)."' AND GroupID = '1'  ");
        $row = mysql_fetch_array($sql);

        if(empty($row)) {
                //echo "0";
                $_SESSION['error'] = "Your Username and Password Invalid";
                header("location:".$AdminPath);
                exit();
        } else {
                $_SESSION['AdminID'] = $row['ProfileID'];
                header("location:".$AdminPath."pages/dashboard/");
               // echo "1";
                exit();
        }
        exit();
    }
    
    if($action=='logout') {
        unset($_SESSION['AdminID']);
        header("location:".$AdminPath);
        exit();
    }
?>