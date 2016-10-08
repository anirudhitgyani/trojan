<?php 
if(isset($_POST['file'])){
    $file = '../Upload/' . $_POST['file'];
    if(file_exists($file)){
        unlink($file);
    }
}
?>