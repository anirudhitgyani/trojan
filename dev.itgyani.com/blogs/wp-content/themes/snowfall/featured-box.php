<?php
/* 	SnowFall Theme's Featured Box to show the Featured Items of Front Page
	Copyright: 2015-2016, D5 Creation, www.d5creation.com
	Based on the Simplest D5 Framework for WordPress
	Since SnowFall 1.0
*/
?>

<div class="box90">
	
    <?php $snowfall_sticky = get_option( 'sticky_posts' ); $snowfall_fpbp_args = array( 'post_type'=> 'post',  'orderby' => 'date', 'order' => 'DESC', 'post__in'  => $snowfall_sticky, 'posts_per_page'  => 4); $snowfall_fpbp_query = new WP_Query($snowfall_fpbp_args); ?>
    <div class="featured-boxs">
    	<?php if (have_posts()) : while ( $snowfall_fpbp_query->have_posts()) :  $snowfall_fpbp_query->the_post(); ?>
				<span class="featured-box" > 
					<div class="box-icon fa-asterisk"></div>
						<a href="<?php the_permalink(); ?>" target="_blank" ><h3 class="ftitle"><?php echo the_title(); ?></h3></a>
						<p><?php echo the_excerpt(); ?></p>
				</span>
		<?php endwhile; endif; wp_reset_query(); ?>

	</div> <!-- featured-boxs -->

</div>
<div class="lsep"></div>
