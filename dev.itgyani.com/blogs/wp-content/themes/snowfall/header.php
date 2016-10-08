<?php

/* 	SnowFall Theme's Header
	Copyright: 2015-2016, D5 Creation, www.d5creation.com
	Based on the Simplest D5 Framework for WordPress
	Since SnowFall 1.0
*/

?>

<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>" />
<meta name="viewport" content="width=device-width" />
<link rel="profile" href="http://gmpg.org/xfn/11" />
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>" />
<?php wp_head(); ?>

</head>

<body <?php body_class(); ?> >
	<div id="headercontainer">
	<?php if ( is_front_page() ): if ( 'posts' != get_option( 'show_on_front' ) ) : get_template_part( 'slide' ); endif; endif; ?> 
      <div id ="header">
      <!-- Top Menu -->
        <div class="box100 snowfall-top-menu-container">
        	<div class="box90">
        		<div class="snowfall-top-menu-items">
        			<nav class="snowfall-top-menu">
						<?php if ( has_nav_menu( 'top-menu' ) ) :  wp_nav_menu( array( 'theme_location' => 'top-menu' )); endif; ?>
        			</nav> 
                    <?php get_search_form(); ?>
        			  		
        		</div>
        	</div>   
      	</div>
      
      <div id ="header-content">
		<!-- Site Titele and Description Goes Here -->
         
       <a href="<?php echo esc_url( home_url( '/' ) ); ?>"><?php if ( has_custom_logo()): the_custom_logo(); else: ?><h1 class="site-title"><?php echo bloginfo( 'name' ); ?></h1><?php endif; ?></a>
		<h2 class="site-title-hidden"><?php bloginfo( 'description' ); ?></h2>
        <!-- Site Main Menu Goes Here -->
        <div class="mobile-menu"><?php echo __('Main Menu','snowfall'); ?></div>
        <nav id="snowfall-main-menu">
		<?php if ( has_nav_menu( 'main-menu' ) ) :  wp_nav_menu( array( 'theme_location' => 'main-menu' )); else: wp_page_menu(); endif; ?>
        </nav>
      
      </div><!-- header-content -->
      </div><!-- header -->
      </div>
      <?php if (is_front_page()): if ( 'posts' == get_option( 'show_on_front' ) ) : ?><div class="headerheight"> </div><?php endif; endif; ?>
      <?php if (!is_front_page()): ?><div class="headerheight"> </div><?php endif; ?>
      <div class="site-container">
	  