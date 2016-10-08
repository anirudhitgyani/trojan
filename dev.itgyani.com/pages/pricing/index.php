<?php include('../../connection.php'); 

    if(!isset($_SESSION['stud_id'])){
        header("location:".$RootPath."pages/student/");
        exit();
    }

?>
<?php include('../../header.php'); ?>
<style>
.im-checkout a.im-powered-link { display: none;}   
.im-checkout {margin-bottom: 0px;}

#right_border { border-right: 7px solid white; }
</style>
<div class="middle-content">
  <div class="pricing-section">
    <div class="container">
      <div class="black-box-pop">
        <div class="price-table">
          <h2>The ITGYANI program - Get your first IT job.123</h2>
          <div class="table-responsive">
            <table class="table">
              <thead>
                <tr>
                  <td>Particulars</td>
                  <td class="text-center">Free</td>
                  <td class="text-center">10,000/-</td>
                </tr>
              </thead>
              <tbody>
                <tr >
                  <td align="left">Aptitude Test</td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Foundation Course</td>
                  <td>Partial</td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Guarantee</td>
                  <td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Counselling</td>
                  <td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Trainer Access</td>
                  <td>Partial</td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Psychometric Evaluation</td>
                  <td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Specialized Training Tests</td>
                  <td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Corporate Access</td>
                  <td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Interview Preparation</td>
                  <td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
                <tr>
                  <td>Live Environment Training</td>
                  <td><img src="<?php echo $RootPath; ?>images/wrong.png" height="20px;" width="20px;" /></td>
                  <td><img src="<?php echo $RootPath; ?>images/right.png" height="20px;" width="20px;" /></td>
                </tr>
              </tbody>
              <tfoot>
                <tr>
                  <td></td>
                  <td id="right_border"  class="text-center"><a href="#">Join-free</a></td>
                  <td class="text-center"><!--<a onclick="buynow();" href="javascript:void(0);">Buy Now</a>-->
                    <!--<a href="https://www.instamojo.com/itgyani/courses-fdfd8/" rel="im-checkout" id="ckurl" data-behaviour="remote" data-style="no-style" data-text="Buy Now"></a>
<script src="https://d2xwmjc4uy2hr5.cloudfront.net/im-embed/im-embed.min.js"></script>-->
                    <a href="https://www.instamojo.com/itgyani/courses-fdfd8/" rel="im-checkout" data-behaviour="remote" data-style="no-style" data-text="Buy Now"></a>
                    <script src="https://d2xwmjc4uy2hr5.cloudfront.net/im-embed/im-embed.min.js"></script>
                  </td>
                </tr>
              </tfoot>
            </table>
          </div>
          <h2>Know What you love, Love What You Do!</h2>
        </div>
        <!--<a href="#" class="blue-buttons close-butt">Close</a>-->
      </div>
    </div>
  </div>
</div>
<?php include('../../footer.php'); ?>
