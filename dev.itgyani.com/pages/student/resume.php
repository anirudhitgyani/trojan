<?php include('../../connection.php');include('../../header_stud.php'); $sql_biodata = mysql_query("select * from `biodata` where ProfileID = '".$_SESSION['stud_id']."' ");$row_biodata = mysql_fetch_array($sql_biodata);$sql_city = mysql_query("select * from city where CityID = '".$row_biodata['CityID']."' ");$row_city = mysql_fetch_array($sql_city);$sql_state = mysql_query("select * from state where StateID = '".$row_city['StateID']."' ");$row_state = mysql_fetch_array($sql_state);$sql_academic = mysql_query("select * from `academic` where ProfileID = '".$_SESSION['stud_id']."' ");$row_academic = mysql_fetch_array($sql_academic);$sql_ten = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['10ThBoard']."' ");$row_ten = mysql_fetch_array($sql_ten);$sql_twelve = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['12ThBoard']."' ");$row_twelve = mysql_fetch_array($sql_twelve);$sql_grad = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['GraduationUniversity']."' ");$row_grad = mysql_fetch_array($sql_grad);$sql_qua = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['Qualification']."' ");$row_qua = mysql_fetch_array($sql_qua);$sql_inst = mysql_query("select * from `standardpropertylist` where StandardPropListID = '".$row_academic['InstituteID']."' ");$row_inst = mysql_fetch_array($sql_inst);?><div class="middle-content resume-page"><div class="container static-page text-left">        <!-- row -->        <div class="row">            <!-- =========================================                           SIDEBAR            ==========================================-->            <!-- Start Sidebar -->            <aside class="col-md-4 col-xs-12 col-sm-4 sidebar z-depth-1" id="sidebar">                <!--  Sidebar row -->                <div class="row">                    <!--  top section   -->                    <div class="heading">                        <!-- ====================                                  IMAGE                        ==========================-->                        <div class="feature-img">                            <a href="<?php echo $RootPath; ?>pages/student/profile.php">                            <?php if($row_biodata['Photo']!='') { ?>            					<img src="<?php echo $RootPath; ?>upload_images/resume_images/<?php echo $row_biodata['Photo']; ?>" class="responsive-img" alt="" />        					<?php } else { ?>            					<img src="<?php echo $RootPath; ?>images/profile-img.jpg" class="responsive-img" alt="" />        					<?php } ?>                                                        </a>                        </div>                        <!-- =========================================                                   NAVIGATION                        ==========================================-->                        <!-- ========================================                                   NAME AND TAGLINE                        ==========================================-->                        <div class="title col-md-9 col-xs-12 col-sm-12 right  wow fadeIn animated" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s; animation-name: fadeIn;">                            <h2><?php echo $row_user['ProfileFirstName']." ".$row_user['ProfileLastName']; ?></h2> <!-- title name -->                            <!--<span>UI &amp; UX Expert</span> --> <!-- tagline -->                        </div>                    </div>                    <!-- sidebar info -->                    <div class="col-md-12 col-xs-12 col-sm-12 sort-info sidebar-item">                        <div class="row">                            <div class="col-md-3 col-xs-12 col-sm-12 icon">                                <!-- icon -->                                <i class="fa fa-user"></i>                            </div>                            <div class="col-md-9 col-xs-12 col-sm-12 info wow fadeIn a1 animated" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s; animation-name: fadeIn;">                                <!-- text -->                                <div class="section-item-details">                                    <p> Gender : <?php echo $row_user['ProfileGender']; ?> </p>                                    <p> DOB : <?php echo $row_user['ProfileDBO']; ?> </p>                                </div>                            </div>                        </div>                    </div>                    <!-- MOBILE NUMBER -->                    <div class="col-md-12 col-xs-12 col-sm-12  mobile sidebar-item">                        <div class="row">                            <div class="col-md-3 col-xs-12 col-sm-12 icon">                                <i class="fa fa-phone"></i> <!-- icon -->                            </div>                            <div class="col-md-9 col-xs-12 col-sm-12 info wow fadeIn a2 animated" data-wow-delay="0.2s" style="visibility: visible; animation-delay: 0.2s; animation-name: fadeIn;">                                <div class="section-item-details">                                    <div class="personal">                                        <h4><a href="tel:<?php echo $row_user['ProfileMobile']; ?>"><?php echo $row_user['ProfileMobile']; ?></a></h4> <!-- Number -->                                        <span>Mobile</span>                                    </div>                                </div>                            </div>                        </div>                    </div>                    <!--  EMAIL -->                    <div class="col-md-12 col-xs-12 col-sm-12  email sidebar-item ">                        <div class="row">                            <div class="col-md-3 col-xs-12 col-sm-12 icon">                                <i class="fa fa-envelope"></i> <!-- icon -->                            </div>                            <div class="col-md-9 col-xs-12 col-sm-12 info wow fadeIn a3 animated" data-wow-delay="0.3s" style="visibility: visible; animation-delay: 0.3s; animation-name: fadeIn;">                                <div class="section-item-details">                                    <div class="personal">                                        <h4><a href="mailto:<?php echo $row_user['ProfileEmail']; ?>"><?php echo $row_user['ProfileEmail']; ?></a></h4> <!-- Email -->                                        <span>Mail</span>                                    </div>                                </div>                            </div>                        </div>                    </div>                    <!-- ADDRESS  -->                    <div class="col-md-12 col-xs-12 col-sm-12  address sidebar-item ">                        <div class="row">                            <div class="col-md-3 col-xs-12 col-sm-12 icon">                                <i class="fa fa-home"></i> <!-- icon -->                            </div>                            <div class="col-md-9 col-xs-12 col-sm-12 info wow fadeIn a4" data-wow-delay="0.4s" style="visibility:visible; animation-delay: 0.4s; animation-name: none;">                                <div class="section-item-details">                                    <div class="address-details">                                        <!-- address  -->                                        <h4><a>                                            <?php echo $row_biodata['Address']; ?> <span><?php echo $row_biodata['Address1']; ?></span><br />                                            <?php echo $row_city['CityName']; ?>, <?php echo $row_state['StateName']; ?>.<br />                                            </a>                                        </h4>                                    </div>                                </div>                            </div>                        </div>                    </div>                    <!-- SKILLS -->                    <div class="col-md-12 col-xs-12 col-sm-12  skills sidebar-item">                        <div class="row">                            <div class="col-md-3 col-xs-12 col-sm-12 icon">                                <i class="fa fa-calendar-o"></i> <!-- icon -->                            </div>                            <!-- Skills -->                            <div class="col-md-9 col-xs-12 col-sm-12 skill-line a5 wow fadeIn" data-wow-delay="0.5s" style="visibility:visible; animation-delay: 0.5s; animation-name: none;">                                <h3>Professional Skills </h3>                                <span>Adobe Photoshop</span>                                <div class="progress">                                    <div class="determinate" style="width: 70%;"><i class="fa fa-circle"></i></div>                                </div>                                <span>HTML</span>                                <div class="progress">                                    <div class="determinate" style="width: 95%;"><i class="fa fa-circle"></i></div>                                </div>                                <span>CSS</span>                                <div class="progress">                                    <div class="determinate" style="width: 90%;"><i class="fa fa-circle"></i></div>                                </div>                                <span>Javascript</span>                                <div class="progress">                                    <div class="determinate" style="width: 85%;"><i class="fa fa-circle"></i></div>                                </div>                                <span>PHP</span>                                <div class="progress">                                    <div class="determinate" style="width: 70%;"><i class="fa fa-circle"></i></div>                                </div>                                <span>JAVA</span>                                <div class="progress">                                    <div class="determinate" style="width: 55%;"><i class="fa fa-circle"></i></div>                                </div>                                <span>SQL</span>                                <div class="progress">                                    <div class="determinate" style="width: 40%;"><i class="fa fa-circle"></i></div>                                </div>                            </div>                        </div>                    </div>                </div>   <!-- end row -->            </aside><!-- end sidebar -->            <!-- =========================================               Work experiences            ==========================================-->            <section class="col-md-8 col-xs-12 col-sm-12 section">                <div class="row">                                        <!-- ========================================                     Education                    ==========================================-->                    <div class="section-wrapper z-depth-1">                        <div class="section-icon col-md-2 col-xs-12 col-sm-12">                            <i class="fa fa-graduation-cap"></i>                        </div>                        <div class="custom-content col-md-10 col-xs-12 col-sm-12 wow fadeIn a1 animated" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s; animation-name: fadeIn;">                            <h2>Education </h2>                            <div class="custom-content-wrapper wow fadeIn a2 animated" data-wow-delay="0.2s" style="visibility: visible; animation-delay: 0.2s; animation-name: fadeIn;">                                <h3>SSC Board :<span>@<?php echo $row_ten['StandardPropListName']; ?></span></h3>                                <h3>SSC School Name :<span>@<?php echo $row_academic['10ThSchoolName']; ?></span></h3>                                <span>Year : <?php echo $row_academic['10ThPassingYear']; ?> </span>                                <p>Percentage : <?php echo $row_academic['10ThPercentage']."%"; ?> </p>                            </div>                            <div class="custom-content-wrapper wow fadeIn a3" data-wow-delay="0.3s" style="visibility: visible; animation-delay: 0.3s; animation-name: none;">                                <h3>HSC Board :  <span>@<?php echo $row_twelve['StandardPropListName']; ?></span></h3>                                <h3>HSC School Name :<span>@<?php echo $row_academic['12ThCollegeName']; ?></span></h3>                                <span>Year : <?php echo $row_academic['12ThPassingYear']; ?> </span>                                <p>Percentage : <?php echo $row_academic['12ThPercentage']."%"; ?> </p>                            </div>                            <div class="custom-content-wrapper wow fadeIn a4" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: none;">                                <h3>University: <span>@<?php echo $row_grad['StandardPropListName']; ?></span></h3>                                <h3>Institute / College Name: <span>@<?php echo $row_academic['GraduationCollegeName']; ?></span></h3>                                                                <h3>Qualification: <span>@<?php echo $row_qua['StandardPropListName']; ?></span></h3>                                                                <span>Year : <?php echo $row_academic['GraduationPassingYear']; ?>  </span>                                <p>Percentage : <?php echo $row_academic['GraduationPercentage']."%"; ?> </p>                            </div>                                                        <?php if($row_academic['ExternalCertificationName']) { ?>                            <div class="custom-content-wrapper wow fadeIn a4" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: none;">                                <h3>External Cerificate</h3>                                <h3>Course Name: <span>@<?php echo $row_academic['ExternalCertificationName']; ?></span></h3>                                                                <span>Year : <?php echo $row_academic['ExternalCertificationPassingYear']; ?>  </span>                                <p>Percentage : <?php echo $row_academic['ExternalCertificationPassingPer']."%"; ?> </p>                            </div>                            <?php } ?>                                                                                    <?php if($row_inst['StandardPropListName']) { ?>                            <div class="custom-content-wrapper wow fadeIn a4" data-wow-delay="0.4s" style="visibility: visible; animation-delay: 0.4s; animation-name: none;">                                <h3>Institute Name: <span>@<?php echo $row_inst['StandardPropListName']; ?></span></h3>                                                                <p> List of all Certificate : <?php echo $row_academic['AllCertificate']; ?> </p>                            </div>                            <?php } ?>                                                                                                                                        </div>                    </div>                    <!-- ========================================                          Intertests                    ==========================================-->                    <div style="height:280px;" class="section-wrapper z-depth-1">                        <div class="section-icon col-md-2 col-xs-12 col-sm-12">                            <i class="fa fa-plane"></i>                        </div>                        <div class="interests col-md-10 col-xs-12 col-sm-12 wow fadeIn" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s; animation-name: none;">                            <h2>Interestes </h2>                            <ul>                                <!-- interetsr icon start -->                                <li><a href="index.html"><i class="fa fa-camera-retro tooltipped" data-position="top" data-delay="50" data-tooltip="Photography"></i></a></li>                                <li><a href="index.html"><i class="fa fa-glass tooltipped" data-position="top" data-delay="50" data-tooltip="Drinking"></i></a></li>                                <li><a href="index.html"><i class="fa fa-headphones tooltipped" data-position="top" data-delay="50" data-tooltip="Music"></i></a></li>                                <li><a href="index.html"><i class="fa fa-comments tooltipped" data-position="top" data-delay="50" data-tooltip="Chatting"></i></a></li>                                <li><a href="index.html"><i class="fa fa-coffee tooltipped" data-position="top" data-delay="50" data-tooltip="Coffee"></i></a></li>                            </ul> <!-- interetsr icon end -->                        </div>                    </div>                    <!-- =======================================                      portfolio Website                    ==========================================--><!--                    <div class="section-wrapper z-depth-1 wow fadeIn">                        <div class="col-md-12 col-xs-12 col-sm-12 website">                            <p><?php echo $row_academic['CareerGoal']; ?></p>                        </div>                    </div>-->                </div><!-- end row -->            </section><!-- end section -->        </div> <!-- end row -->     <!-- end container -->    </div></div><?php include('../../footer.php'); ?>