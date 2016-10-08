<?php include('../../connection.php');
	if(!isset($_SESSION['ProfileID'])) {
		header("location:".$RootPath);
		exit();
	}

include('../../header_1.php');


$sql_profile = mysql_query("select * from `profile` where GroupID = '2' ") or die(mysql_error());
?>







<div class="middle-content hr-dashbord-content">
<div class="container">
<div class="row-fluid dashbord-row">
<?php include('sidebar.php'); ?>
<div class="col-sm-8 col-xs-12 col-md-10 no-padding-right right-col">
<div class="row">

<div class="col-sm-12 col-xs-12 col-md-12">
<div class="dashbord-page-heading">
<h1>Dashbord</h1>
<p>//Welcome back <?php echo $row_user['ProfileName']; ?></p>
</div>
</div></div>
<div class="row-fluid grey-box hr-overviews">
<div class="col-sm-12 col-xs-12 col-md-6">
<div class="white-shade-box treding-now-box">
<h2>Trending Now </h2>
<ul>
<li><a href="#">UI Developer</a></li>
<li><a href="#">Java Developer</a></li>
<li><a href="#">Mobile Developer</a></li>
<li><a href="#">Digital Marketing</a></li>
<li><a href="#">Sales Manager</a></li>
<li><a href="#">Accounting</a></li>
<li><a href="#">Web Developer</a></li>
<li><a href="#">Business Analyst</a></li>
<li><a href="#">Selenium</a></li>
<li><a href="#">Product Manager</a></li>
<li><a href="#">Data Scientist</a></li>
<li><a href="#">UX/UI Designer</a></li>
</ul>
</div>
</div>
<div class="col-sm-6 col-xs-6 col-md-3">
<div class="white-shade-box daily-visiters text-center">
<h3 class="text-uppercase">Daily Visiters</h3>
<img src="<?php echo $RootPath; ?>images/dashbord/daily-visiter-icon.png" /><br/>
<a href="#" class="grey-button">View more</a>
</div>
</div>
<div class="col-sm-6 col-xs-6 col-md-3">
<div class="white-shade-box my-profiles-box text-center">
<h3 class="text-uppercase">My Profile</h3>
<img src="<?php echo $RootPath; ?>images/dashbord/my-profile-icon.png" /><br/>
<div class="profile-progress">
<span class="bar"></span><strong class="count-text">80%</strong>
</div>
<a href="<?php echo $RootPath; ?>pages/dashboard/edit_profile.php">Edit your profile</a>
<a href="<?php echo $RootPath; ?>pages/dashboard/edit_profile.php" class="grey-button">View more</a>
</div>
</div>

</div>

<div class="row-fluid hidden" >
<div class="col-sm-12 col-xs-12 col-md-12 search-bar-back">
<div class="search-bars">
<form>
<div class="form-group group-1"><i class="fa fa-search"></i><input type="text" placeholder="Search by Skills or Titles" /></div>
<div class="form-group group-2"><i class="fa fa-map-marker"></i><input type="text" placeholder="Anywhere" /></div>
<input type="submit" class="green-button" value="Find Jobseekers" />
</form>
</div>

</div>
</div>
<div class="row">
<div class="col-sm-12 col-xs-12 col-md-12">
<div class="hr-box-title">
<span class="text-uppercase"><img src="<?php echo $RootPath; ?>images/corporate-icon.svg" width="45" height="45" /> graduates with qualification and estimated time to completion</span>
<div class="list-icons">
<abbr class="list-views-butt active"><i class="fa fa-list"></i></abbr>
<abbr class="grid-views-butt"><i class="fa fa-square"></i></abbr>


</div>
</div>
<div class="list-views-grid student-lists">
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
        
            <tr>
                <th>Name</th>
                <th>Profile</th>
                <th>City</th>
                <th>Year of passing</th>
                <th>Skills</th>

            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Name</th>
                <th>Profile</th>
                <th>City</th>
                <th>Year of passing</th>
                <th>Skills</th>

            </tr>
        </tfoot>
        <tbody>
        <?php while($row_profile = mysql_fetch_array($sql_profile)) { 
                $sql_academic = mysql_query("select * from `academic` where `ProfileID` = '".$row_profile['ProfileID']."' ");
                $row_academic = mysql_fetch_array($sql_academic);

                $sql_biodata = mysql_query("select * from `biodata` where `ProfileID` = '".$row_profile['ProfileID']."' ");
                $row_biodata = mysql_fetch_array($sql_biodata);

                $sql_city = mysql_query("select * from `city` where `CityID` = '".$row_biodata['CityID']."' ");
                $row_city = mysql_fetch_array($sql_city);
	?>
            <tr>
                <td><?php echo $row_profile['ProfileFirstName']." ".$row_profile['ProfileLastName']; ?></td>
                <td>System Architect</td>
                <?php if($row_city['CityName']) { ?>
                	<td><?php echo $row_city['CityName']; ?></td>
                <?php } else { ?>
                	<td>not declare</td>
                <?php } ?>
                <?php if($row_academic['GraduationPassing04Year']) { ?>
                	<td><?php echo $row_academic['GraduationPassing04Year']; ?></td>
				<?php } else { ?>
                	<td>not declare</td>
                <?php } ?>
                
                <td>Php Developer</td>
			</tr>
        <?php } ?>    
        </tbody>
    </table>
</div>
<div class="student-lists grid-views-grid grid-views">
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
<div class="item-box">
<div class="thubnails"><a href="#"><img src="<?php echo $RootPath; ?>images/student-files.png" /></a></div>
<div class="box-discription">
<h4>Jignesh shah</h4>
<p>Educated yet unemployable –When an enterprise hires a fresher neither have any clue as to what the candidate will be doing in the organization 8 months down the line. The company will hire and train the employee for weeks and months before they can become a billable resource. The requirement from the business units also dynamically change.</p>
</div>
</div>
</div>

</div>
</div>
<div class="schedule-interview">
<h2 class="titles">schedule interview</h2>


<div class="row">
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
<div class="col-sm-3 col-xs-4 col-md-2">
<div class="student-boxs"><a href="#"><img src="<?php echo $RootPath; ?>images/avtar-image.png" /><span class="name">Jagdis shah</span></a></div>
</div>
</div>
</div>
</div>
</div>
</div>

</div>

<?php include('../../footer.php'); ?>