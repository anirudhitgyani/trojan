<?php

/* 	SnowFall Theme's Post Content
	Copyright: 2015-2016, D5 Creation, www.d5creation.com
	Based on the Simplest D5 Framework for WordPress
	Since SnowFall 1.0
*/
?>

<div id="content">
          
	<?php if ( have_posts() ): while ( have_posts() ) : the_post(); ?>
    
	<div <?php post_class(); ?> id="post-<?php the_ID(); ?>">
    
    	<div class="post-container">
        
			<div class="fpthumb"><?php the_post_thumbnail('snowfall-fpage-thumb'); ?></div>
        	<div class="entrytext">
            	<?php if ( is_single() || is_page() ): ?><h1 class="page-title"><?php the_title(); ?></h1><?php else: ?><a href="<?php the_permalink(); ?>"><h2 class="post-title"><?php the_title(); ?></h2></a><?php endif; ?>
        		<div class="content-ver-sep"> </div>
				<?php snowfall_content(); ?>
        	</div>
            
        	<div class="clear"> </div>
            	<?php if ( !is_page() ): ?>
        		<div class="up-bottom-border">
            	<?php  wp_link_pages( array( 'before' => '<div class="page-link fa-file"><span>' . '' . '</span>', 'after' => '</div><br/>' ) ); 
            	snowfall_post_meta();
				if ( is_single() ): ?>
            	<div class="content-ver-sep"> </div>
                <?php echo the_post_navigation(array( 'prev_text' => '<div class="floatleft"><span class="fa-arrow-left"></span> %title</div>', 'next_text'          => '<div class="floatright">%title <span class="fa-arrow-right"></span></div>')); ?>
            		<?php endif; ?>
			</div>
            <?php endif; ?>
            
		</div>
    </div>
	<?php endwhile; ?>
	<!-- End the Loop. -->          
        	
		<?php 
		if ( is_page() ): comments_template(); endif;	
		if ( is_single() ): comments_template(); endif;
		?>
            
		<?php snowfall_page_nav(); ?>
  	
	<?php else: ?>
 
 		<?php snowfall_not_found(); ?>
 
	<?php endif; ?>
          	            
            
</div>		
