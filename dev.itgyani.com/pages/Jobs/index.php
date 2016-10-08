<?php include('../../db.php');
include('../../header.php'); ?>

<div class="middle-content">
<div class="container static-page text-left">
<h2 class="page-title">Current Opening</h2>
<div class="input-group col-md-3 pull-right">
                                <input type="text" class="  search-query form-control" placeholder="Search" />
                                <span class="input-group-btn">
                                    <button class="btn" type="button">
                                        <span class=" glyphicon glyphicon-search"></span>
                                    </button>
                                </span>
                            </div>
<style>
    .clickable
    {
        cursor: pointer;
    }
    
</style>
<script>
    $(document).on('click', '.panel div.clickable', function (e) {
    var $this = $(this); //Heading
    var $panel = $this.parent('.panel');
    var $panel_body = $panel.children('.panel-body');
    var $display = $panel_body.css('display');

    if ($display == 'block') {
        $panel_body.slideUp();
    } else if($display == 'none') {
        $panel_body.slideDown();
    }
    });

    $(document).ready(function(e){
    var $classy = '.panel.autocollapse';

    var $found = $($classy);
    $found.find('.panel-body').hide();
    $found.removeClass($classy);
    });
</script>

<div class="container">
    <div class="panel">   	
    	<div class="panel-body">
    		<div class="row">
    			<div class="col-md-12">
    				<div class="panel autocollapse">
    					<div class="panel-heading clickable">
    						<h3 class="panel-title">
    							 Senior Content Manager  <p class="pull-right" style="color: red;"><span class="glyphicon glyphicon-plus"></span></p>
    						</h3>
    					</div>
    					<div class="panel-body">
                            <div class="col-sm-3 col-xs-12 col-md-5 text-center"><img src="<?php echo $RootPath; ?>images/jo1.jpg" /></div>
    						<div class="col-sm-9 col-xs-12 col-md-7"><p><strong>Single Position to fill for Senior Content Manager
</strong><strong></br></br>Location - </strong> Pune, INDIA</br></br><strong>Position Type - </strong> Permanent</br></br><strong>Responsibility - </strong>You will be responsible for managing website blogs, article section available on the website. You will also proofread and structure raw content and then put it in simple and easy way to form easy to understand tutorials and e-books, which can be used for self-learning purpose.</br></br><strong>Renumeration - </strong> The best in Industry</br></br><strong>Experience - </Strong> Minimum 4-5 years of experience in Content Preparation, Training, Presentation, Promotion and overall Management.</br></br></p></div><div><a href="../ex"><strong>Apply Now</strong></a></div>
    					</div>

    					
    				</div>
    				<div class="panel autocollapse">
    					<div class="panel-heading clickable">
    						<h3 class="panel-title">
    							Subject Matter Experts <p class="pull-right" style="color: red;"><span class="glyphicon glyphicon-plus"></span></p>
    						</h3>
    					</div>
    					<div class="panel-body">
    						<div class="col-sm-3 col-xs-12 col-md-5 text-center pull-right"><img src="<?php echo $RootPath; ?>images/web1.jpg" /></div>
<div class="col-sm-9 col-xs-12 col-md-7"><p><strong>4 Positions to fill for Subject Matter Experts with writing skills 
</strong><strong></br></br>Location - </strong> Pune, INDIA</br></br><strong>Position Type - </strong>Permanent, Contract Basis and Freelancers, choose what suits you.</br></br><strong>Responsibility - </strong> You will be responsible for doing R&D in your subject for the new concepts and then put the content in simple and easy way to form tutorials and e-books, which can be used for self-learning purpose.
</br></br>
<strong>Renumeration - </strong> The best in Industry</br></br><strong>Experience - </Strong> Minimum 4-5 years of experience in any of the following subjects:
</br></br>
1.Salesforce</br>
2.Cloud Computing</br>
3.Virtualization</br>
4.Software Testing</br>
5.Big Data related technologies</br>
6.BI and associated tools</br>
7.Digital Marketing</br>
8.Microsoft Technologies</br>
9.Android developer</br>
10.Web Developer</br></br>
</p><div><a href="../ex"><strong>Apply Now</strong></a></div>

</div>
    					</div>
    				</div>
    			</div>
    			<div class="col-md-12">
    				<div class="panel autocollapse">
    					<div class="panel-heading clickable">
    						<h3 class="panel-title">
    							 Web Developer <p class="pull-right" style="color: red;"><span class="glyphicon glyphicon-plus"></span></p>
    						</h3>
    					</div>
    					<div class="panel-body">
    						<div class="col-sm-3 col-xs-12 col-md-5 text-center"><img src="<?php echo $RootPath; ?>images/dev1.jpg" /></div>
<div class="col-sm-9 col-xs-12 col-md-7"><p><strong>Single Position to fill for Senior Web Developer
</strong><strong></br></br>Location - </strong> Pune, INDIA</br></br><strong>Position Type - </strong> Permanent</br></br>
<strong>Key Skills - </strong>Having Sound Knowledge of HTML5, CSS 3, PHP, JavaScript, JQuery. Knowledge of JavaScript framework will be added benefit.</br></br>
<strong>Renumeration - </strong> The best in Industry</br></br>
<strong>Experience - </Strong> 3+ years of experience.</br></br>
</p></div><div><a href="../ex"><strong>Apply Now</strong></a></div>
</div>
    					</div>
    				</div>
    				
    			</div>
    		</div>
    	</div>
    </div>
</div>
</div>
</div>

<?php include('../../footer.php'); ?>