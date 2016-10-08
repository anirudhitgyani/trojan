<?php
/* 	SnowFall Theme's Footer
	Copyright: 2015-2016, D5 Creation, www.d5creation.com
	Based on the Simplest D5 Framework for WordPress
	Since SnowFall 1.0
*/
?>
<div class="clear"></div>
<div id="footer">

<div class="versep"></div>
<div id="footer-content">

<div class="social social-link">
<?php if (esc_html(snowfall_get_option('fpostex', '0')) == '1' ): ?>
	  <?php foreach (range(1, 5 ) as $snowfall_numslinksn) { 
	  if ( snowfall_get_option('sl' . $snowfall_numslinksn, '') != '' ): echo '<a href="'. esc_url(snowfall_get_option('sl' . $snowfall_numslinksn, '')) .'" target="_blank"> </a>'; endif;
	  } ?>
<?php endif; ?>
</div>

<?php
   	get_sidebar( 'footer' );
?>

<div id="creditline"><?php snowfall_creditline(); ?></div>

</div> <!-- footer-content -->
</div> <!-- footer -->
<a href="#" class="go-top"></a>
<div class="clear"> </div>
</div>
<?php wp_footer(); ?>
</body>
</html>