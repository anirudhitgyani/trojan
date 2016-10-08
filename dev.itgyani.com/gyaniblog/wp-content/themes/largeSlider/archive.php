<?php get_header(); ?>


<div id="content">
<h3 class="top_title">
        <?php if (is_category()) { ?>
              <?php single_cat_title(); ?>
        <?php } elseif( is_tag() ) { ?>
              <?php single_tag_title(); ?>
        <?php } elseif (is_day()) { ?>
              <?php the_time('F jS, Y'); ?>
        <?php } elseif (is_month()) { ?>
              <?php the_time('F, Y'); ?>
        <?php } elseif (is_year()) { ?>
              <?php the_time('Y'); ?>
        <?php } elseif (is_author()) { ?>
              Author Archive
        <?php } elseif (isset($_GET['paged']) && !empty($_GET['paged'])) { ?>
              Blog Archives
        <?php } ?>   
    </h3>

    <?php
    $args = array_merge( $wp_query->query, array( 'posts_per_page' => 10 ) );
    query_posts( $args );        
    $x = 0;
    while (have_posts()) : the_post(); ?>                        
    
        <?php $post_box_last = ''; ?>
        
        <?php if($x == 1 || $x == 3 || $x == 5 || $x == 7 || $x == 9 || $x == 11 || $x == 13 || $x == 15 || $x == 17 || $x == 19) { $post_box_last .= ' home_post_box_last'; } ?>
        <?php if($x == 1 || $x == 3 || $x == 5 || $x == 7 || $x == 9 || $x == 11 || $x == 13 || $x == 15 || $x == 17 || $x == 19) { $post_box_last .= ' home_post_box_tablet_last'; } ?>
        
        <div class="home_post_box <?php echo $post_box_last; ?>">
        
            <a href="<?php the_permalink(); ?>"><?php the_post_thumbnail('home-image'); ?></a>
            
            <h3><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h3>
            
        
        </div><!--//home_post_box-->
        
        <?php if($x == 1 || $x == 3 || $x == 5 || $x == 7 || $x == 9 || $x == 11 || $x == 13 || $x == 15 || $x == 17 || $x == 19) { ?>
            <div class="desktop_clear"></div>
        <?php } ?>
        
        <?php if($x == 1 || $x == 3 || $x == 5 || $x == 7 || $x == 9 || $x == 11 || $x == 13 || $x == 15 || $x == 17 || $x == 19) { ?>
            <div class="tablet_clear"></div>
        <?php } ?>        
    
    <?php $x++; ?>
    <?php endwhile; ?>        
    
    <div class="clear"></div>
    
    <div class="archive_nav">
        <div class="left"><?php previous_posts_link('&lt;&lt; Previous Page') ?></div>
        <div class="right"><?php next_posts_link('Next Page &gt;&gt;') ?></div>
        
        <div class="clear"></div>
    </div><!--//archive_nav-->
    
    <?php wp_reset_query(); ?>                        
    <div class="clear"></div>
</div><!--//content-->
<?php get_footer(); ?>        