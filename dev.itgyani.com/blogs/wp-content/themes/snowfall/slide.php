<?php
/* 	SnowFall Theme's Slide Part
	Copyright: 2015-2016, D5 Creation, www.d5creation.com
	Based on the Simplest D5 Framework for WordPress
	Since SnowFall 1.0
*/
?>

<!--- ============  MAIN SLIDE  =========== ------------>
<div class="main-slider" >
	<ul class="mslides">
		<li class="slideitem">
			<div class="caption1">
				<p class="title1"><?php echo esc_attr(snowfall_get_option('slide-caption-a1' )); ?></p>
				<p class="title2"><?php echo esc_attr(snowfall_get_option('slide-caption-b1' )); ?></p>
				<p class="title3"><?php echo esc_attr(snowfall_get_option('slide-caption-c1' )); ?></p>
			</div>
			<div class="slide-links">
				<?php if ( snowfall_get_option('slide-link1-text1' )): ?><span class="slide_btn "><?php echo esc_attr(snowfall_get_option('slide-link1-text1', 'SnowFall is Free!')); ?></span><?php endif; ?>
				<?php if ( snowfall_get_option('slide-link2-text1' )): ?><span class="slide_btn  fill-color"><?php echo esc_attr(snowfall_get_option('slide-link2-text1' )); ?></span><?php endif; ?>
			</div>
		</li>
	</ul>
</div>


<!--- ============  END OF MAIN SLIDE  =========== ------------>