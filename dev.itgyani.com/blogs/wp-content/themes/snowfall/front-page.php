<?php
/*
	SnowFall Theme's Front Page
	SnowFall Theme's Front Page to Display the Home Page if Selected
	Copyright: 2015-2016, D5 Creation, www.d5creation.com
	Based on the Simplest D5 Framework for WordPress
	Since SnowFall 1.0
*/
?>

<?php get_header(); ?>
<div class="clear-top"></div>
<?php if ( 'posts' == get_option( 'show_on_front' ) ) : get_template_part( 'fp-blog' ); 
else: get_template_part( 'featured-box' ); get_template_part( 'fcontent' );  
endif;
get_footer(); ?>