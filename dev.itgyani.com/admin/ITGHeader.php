<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

?>
<nav style="z-index:999; ">
  <ul style="z-index:999; ">
    <li><a href='#'>Home</a></li>
    <li><a href='#'>Admin</a>
      <ul>
          <li><a href='ITGPhpPageCourse.php'>Course</a></li>
          <li><a href='ITGPhpPageCareerPath.php'>Career Path</a></li>
        <li><a href='#'>Sublink</a></li>
        <li><a href='#'>Sublink</a></li>
      </ul>
    </li>
    <li><a href='#'>Contact</a></li>
    <li><a href='#'>About</a></li>
    <li><a href='#'>Profile</a></li>
    <div style='clear:both'></div>
  </ul>
</nav> 
<script type="text/javascript" src="CoreJS.js"></script>
<script type="text/javascript" src="js/chosen.jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="CoreCSS.css" />
    <link rel="stylesheet" type="text/css" href="CSS/chosen.css" />
<script type="text/javascript">
var ITGWaitForHeaderLoad = setTimeout(function () {
    $('nav>ul').lavazi({background:"#4c1b1b",transitionTime:500,theme:'simple',height:4,mode:'belowBar'});
        clearTimeout(ITGWaitForHeaderLoad);
   }, 2000);
</script>