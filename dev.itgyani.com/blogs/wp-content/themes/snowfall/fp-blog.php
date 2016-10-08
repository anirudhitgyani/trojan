<?php

/* 	SnowFall Theme's Blog/Page Part of Front Page
	Copyright: 2014-2016, D5 Creation, www.d5creation.com
	Based on the Simplest D5 Framework for WordPress
	Since SnowFall 1.2.3
*/
?>

<!--- ============  BLOG POSTS  =========== ------------>

<div id="wpsblogpost" class="box100 bqpcontainer" >
	<div class="box90">
    	<div class="featured-boxs">

			<?php if ( have_posts() ): while ( have_posts() ) : the_post(); ?>

			<div class="featured-box view effect"><a href="<?php the_permalink(); ?>" target="_blank" ><div class="fpthumb"><?php the_post_thumbnail('snowfall-fpage-thumb'); ?><div class="mask"></div></div><h3 class="ftitle"><?php the_title(); ?></h3></a><div class="fppost-content"><?php the_excerpt(); ?></div></div>
			<?php endwhile; snowfall_page_nav(); endif; ?>
			
		</div>
	</div>
</div>

<!--- ============  END OF BLOG POSTS  =========== ------------>