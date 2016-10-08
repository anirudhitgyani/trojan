<?php include('../../connection.php'); ?>
<footer id="footer">
<div class="container">
<a href="<?php echo $RootPath; ?>" class="footer-logo"><img src="<?php echo $RootPath; ?>images/logo.png" /></a>
<div class="social-login footer-login text-center">
    <p>social media links</p>
        <a target="_blank"  href="https://www.facebook.com/ITgyani"><i class="fa fa-facebook"></i></a>
        <a target="_blank" href="https://twitter.com/info_itgyani"><i class="fa fa-twitter"></i></a>
        <a target="_blank" href="https://plus.google.com/u/0/100206678218261154294"><i class="fa fa-google-plus"></i></a>
        <a target="_blank" href="https://www.linkedin.com/company/itgyani"><i class="fa fa-linkedin"></i></a>
</div>

<div class="footer-menu">
<a href="<?php echo $RootPath; ?>pages/about/">About us</a>
<a href="#">The Team</a>
<a href="#">News</a>
<a href="#">Blog</a> 
<a href="<?php echo $RootPath; ?>pages/Jobs/">Jobs</a>
<a href="<?php echo $RootPath; ?>pages/terms/">Legal</a>
<a href="<?php echo $RootPath; ?>pages/policy/">Privacy Policy</a>
<a href="<?php echo $RootPath; ?>pages/Disclaimer/">Disclaimer</a>
<a href="<?php echo $RootPath; ?>pages/contact-us/">Contact us</a>
</div> 

<p class="copyright">Copyright @ 2016, All Right Reserved Techno Flair Lab Private Ltd.</p>



</div>

</footer>

<!--Start of Tawk.to Script-->
<script type="text/javascript">
var $_Tawk_API={},$_Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/57ea843c1fd15618f0ccdec2/default';
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})();
</script>
<!--End of Tawk.to Script-->

<script type="text/javascript">
$( document ).ready(function() {
var $item = $('.home-header'); 
var $wHeight = $(window).height();
$item.height($wHeight); 

 $('#myCarousel').carousel({
	    interval: 10000
	})
});
$(window).on('resize', function (){
  $wHeight = $(window).height();
  $item.height($wHeight);
});
</script>


<script type="text/javascript">
$( document ).ready(function() {

// Setup - add a text input to each footer cell
    $('#example tfoot th').each( function () {
        var title = $(this).text();
        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
    } );
 
    // DataTable
    var table = $('#example').DataTable( {
"scrollX": true,

		
    });
 
    // Apply the search
    table.columns().every( function () {
        var that = this;
 
        $( 'input', this.footer() ).on( 'keyup change', function () {
            if ( that.search() !== this.value ) {
                that
                    .search( this.value )
                    .draw();
            }
        } );
    } );
$(".grid-views-grid").hide();
$(".grid-views-butt").click(function(){
$(".grid-views-grid").show();
$(".list-views-grid").hide();

	 $(this).addClass('active');
});
$(".list-views-butt").click(function(){
$(".grid-views-grid").hide();
$(".list-views-grid").show();

	 $(this).addClass('active');
	 $('.grid-views-butt').removeClass('active');
});
$('.dataTables_scrollFoot').prependTo('.dataTables_scroll');

 $('#myCarousel').carousel({
	    interval: 10000
	})

});
</script>

</body>
</html>