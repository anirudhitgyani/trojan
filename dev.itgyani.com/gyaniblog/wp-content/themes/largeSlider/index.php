<?php get_header(); ?>
    <!-- Slideshow 4 -->
    <div class="callbacks_container">
    
      <ul class="rslides" id="slider4">
      
      
        <?php
        $slider_arr = array();
        $x = 0;
        $args = array(
                     //'category_name' => 'blog',
                     'post_type' => 'post',
                     'meta_key' => 'ex_show_in_slideshow',
                     'meta_value' => 'Yes',
                     'posts_per_page' => 10
                     );
        query_posts($args);
        while (have_posts()) : the_post(); ?>                	      
	<?php $src = wp_get_attachment_image_src( get_post_thumbnail_id(get_the_ID()), 'slide-image', false, '' ); ?>
      
        <li>
          <a href="<?php the_permalink(); ?>"><img src="<?php echo $src[0]; ?>" alt="image" /></a>
<!--          <p class="caption">This is a caption</p>-->
        </li>
	
        <?php array_push($slider_arr,get_the_ID()); ?>
        <?php $x++; ?>
        <?php endwhile; ?>
        <?php wp_reset_query(); ?>                        	    		
	
      </ul>
    </div>
<div id="content">
    <?php
    $category_ID = get_category_id('blog');
    
    $args = array(
                 'post_type' => 'post',
                 'posts_per_page' => 4,
                 'post__not_in' => $slider_arr,
                 'cat' => '-' . $category_ID,
                 'paged' => ( get_query_var('paged') ? get_query_var('paged') : 1)
                 );
    query_posts($args);
    $x = 0;
    while (have_posts()) : the_post(); ?>                        
    
        <?php $post_box_last = ''; ?>
        
        <?php if($x == 1 || $x == 3 || $x == 5) { $post_box_last .= ' home_post_box_last'; } ?>
        <?php if($x == 1 || $x == 3 || $x == 5) { $post_box_last .= ' home_post_box_tablet_last'; } ?>
        
        <div class="home_post_box <?php echo $post_box_last; ?>">
        
            <a href="<?php the_permalink(); ?>"><?php the_post_thumbnail('home-image'); ?></a>
            
            <h3><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h3>
            
         
        </div><!--//home_post_box-->
        
        <?php if($x == 1 || $x == 3 || $x == 5) { ?>
            <div class="desktop_clear"></div>
        <?php } ?>
        
        <?php if($x == 1 || $x == 3 || $x == 5) { ?>
            <div class="tablet_clear"></div>
        <?php } ?>
    
    <?php $x++; ?>
    <?php endwhile; ?>        
    <?php wp_reset_query(); ?>                        
    <div class="clear"></div>
    
</div><!--//content-->
<script>
$(document).ready(function() {
//	$('.callbacks_container').css('margin-top','-' + ($('#header').height() + 29) + 'px');
});
</script>
<?php get_footer(); ?>        