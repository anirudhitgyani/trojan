<?php
/* 	SnowFall Theme's Functions
	Copyright: 2015-2016, D5 Creation, www.d5creation.com
	Based on the Simplest D5 Framework for WordPress
	Since SnowFall 1.0
*/
 

	require_once ( trailingslashit(get_template_directory()) . 'inc/customize.php' );
	function snowfall_about_page() { 
	add_theme_page( 'SnowFall Options', 'SnowFall Options', 'edit_theme_options', 'theme-about', 'snowfall_theme_about' ); 
	}
	add_action('admin_menu', 'snowfall_about_page');
	function snowfall_theme_about() {  require_once ( trailingslashit(get_template_directory()) . 'inc/theme-about.php' ); }	
	function snowfall_setup() {
//	Theme TextDomain for the Language File
	load_theme_textdomain( 'snowfall', get_template_directory() . '/languages' );
	
	register_nav_menus( array( 'main-menu' => __('Main Menu', 'snowfall'), 'top-menu' => __('Top Menu', 'snowfall') ) );


//	Set the content width based on the theme's design and stylesheet.
	global $content_width;
	if ( ! isset( $content_width ) ) $content_width = 584;

	add_theme_support( 'title-tag' );
	
// 	Tell WordPress for the Feed Link
	add_theme_support( 'automatic-feed-links' );
	
// 	This theme uses Featured Images (also known as post thumbnails) for per-post/per-page Custom Header images
	add_theme_support( 'post-thumbnails' );
	set_post_thumbnail_size( 150, 150, true ); // default Post Thumbnail dimensions (cropped)
	add_image_size( 'snowfall-fpage-thumb', 1100, 600, array( 'left', 'top' ) ); 
	
		
// 	WordPress Custom Background Support	
	$snowfall_custom_background = array( 'default-color' => 'FFFFFF', 'default-image'  => '', );
	add_theme_support( 'custom-background', $snowfall_custom_background );
	
	add_theme_support( 'custom-logo', array(
   'height'      => 70,
   'width'       => 250,
   'flex-width' => true,
	) );
	
// 	WordPress Custom Header Support				
	$snowfall_custom_header = array(
	'default-image'          => get_template_directory_uri() . '/images/snowfall.jpg',
	'random-default'         => false,
	'width'                  => 1600,
	'height'                 => 900,
	'flex-height'            => false,
	'flex-width'             => false,
	'default-text-color'     => 'ffffff',
	'header-text'            => false,
	'uploads'                => true,
	'wp-head-callback' 		 => '',
	'admin-head-callback'    => '',
	'admin-preview-callback' => '',
	);
	add_theme_support( 'custom-header', $snowfall_custom_header );
	
	}
	add_action( 'after_setup_theme', 'snowfall_setup' );

// 	Functions for adding script
	function snowfall_enqueue_scripts() { 
	wp_enqueue_style('snowfall-style', get_stylesheet_uri(), false );
	wp_enqueue_script( 'html5', get_template_directory_uri().'/js/html5.js');
    wp_script_add_data( 'html5', 'conditional', 'lt IE 9' );
	if ( is_singular() && comments_open() && get_option( 'thread_comments' ) ) { wp_enqueue_script( 'comment-reply' ); 	}

	wp_enqueue_script( 'snowfall-menu-style', get_template_directory_uri(). '/js/menu.js', array( 'jquery' ) );
	
	wp_register_style('snowfall-gfonts1', '//fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800', false );
	wp_enqueue_style('snowfall-gfonts1');
	wp_register_style('snowfall-gfonts2', '//fonts.googleapis.com/css?family=Roboto+Condensed:300italic,400italic,700italic,400,300,700', false );
	wp_enqueue_style('snowfall-gfonts2');
	
	wp_enqueue_style('font-awesome', get_template_directory_uri(). '/css/font-awesome.css' );
	
	wp_enqueue_style('snowfall-responsive', get_template_directory_uri(). '/style-responsive.css' );
	}
	add_action( 'wp_enqueue_scripts', 'snowfall_enqueue_scripts' );
	
// 	Functions for adding script to Admin Area
	function snowfall_admin_style( $hook ) {
    if ( 'appearance_page_theme-about' == $hook ) { 
        wp_enqueue_style( 'snowfall_admin_css', get_template_directory_uri() . '/inc/admin-style.css', false );
    	}
	}
	add_action( 'admin_enqueue_scripts', 'snowfall_admin_style' );


// 	Functions for adding some custom code within the head tag of site
	function snowfall_custom_code() {
?>
	
	<style type="text/css">
	.site-title a, 
	.site-title a:active, 
	.site-title a:hover {
	color: #<?php echo get_header_textcolor(); ?>;
	}
			
	<?php if ( is_admin_bar_showing() ): echo '#header { top: 32px; }'; endif; ?>
	.main-slider { background-image: url("<?php if ( get_header_image() !='' ): echo esc_url(header_image()); endif; ?>"); }
	</style>
<?php 
	
	echo snowfall_get_option('headcode');
	}
	
	add_action('wp_head', 'snowfall_custom_code');


	function snowfall_creditline () {
	echo '&copy; ' . date("Y"). ': ' . get_bloginfo( 'name' ). '<span class="credit"> | SnowFall ' . __('Theme by:', 'snowfall') . ' <a href="'. esc_url('http://d5creation.com/theme/snowfall') .'" target="_blank"> D5 Creation</a> | ' . __('Powered by:', 'snowfall') . ' <a href="http://wordpress.org" target="_blank">WordPress</a>';
    }

//	function tied to the excerpt_more filter hook.
	function snowfall_excerpt_length( $snowfall_excerpt_length ) {
	global $snowfall_excerpt_length;
	if ($snowfall_excerpt_length) {
    return $snowfall_excerpt_length;
	} else {
    return 50; //default value
    } }
	add_filter( 'excerpt_length', 'snowfall_excerpt_length', 999 );
	
	function snowfall_excerpt_more($snowfall_more) {
    global $post;
	return '<a href="'. get_permalink($post->ID) . '" class="read-more">' . __('Read More', 'snowfall'). '</a>';
	}
	add_filter('excerpt_more', 'snowfall_excerpt_more');
	
	// Content Type Showing
	function snowfall_content() { the_content('<span class="read-more">' . __('Read More', 'snowfall'). '</span>'); }

//	Get our wp_nav_menu() fallback, wp_page_menu(), to show a home link
	function snowfall_page_menu_args( $snowfall_args ) {
	$snowfall_args['show_home'] = true;
	return $snowfall_args;
	}
	add_filter( 'wp_page_menu_args', 'snowfall_page_menu_args' );
	
// 	Post Meta design
	function snowfall_post_meta() { ?>
	<div class="post-meta"> <span class="post-edit"> <?php edit_post_link(__('Edit', 'snowfall'),'<span class="fa-edit">','</span>' ); ?></span> <span class="post-author fa-user-md"> <?php the_author_posts_link(); ?> </span> <span class="post-date fa-clock-o"><?php the_time('F j, Y'); ?></span>	<span class="post-tag fa-tags"> <?php the_tags('' , ', '); ?> </span> <span class="post-category fa-archive"> <?php the_category(', '); ?> </span> <span class="post-comments fa-comments"><?php comments_popup_link(__('No Comments', 'snowfall') . ' &#187;', __('One Comment', 'snowfall') . ' &#187;', '% ' . __('Comments', 'snowfall') . ' &#187;'); ?> </span>
	</div> 
	
	<?php
	}
	
//	Page Navigation
	function snowfall_page_nav() { ?>
		<div id="page-nav">
            
           <?php echo the_posts_navigation( array( 'next_text' => '<div class="alignleft"><span class="fa-arrow-left"></span> '. __('NEWER ENTRIES', 'snowfall').'</div>', 'prev_text' => '<div class="alignright">'. __('OLDER ENTRIES', 'snowfall').'  <span class="fa-arrow-right"></span></div>', 'snowfall' )  ); ?>
            
		</div>
    <?php }
	
//	Page Not Found
	function snowfall_not_found() { ?>
		<br /><br />
        <div class="searchinfo">
        <h1 class="page-title fa-times-circle"><?php echo __('SORRY, NOT FOUND ANYTHING', 'snowfall'); ?></h1>
		<h3 class="arc-src"><span><?php echo __('You Can Try Another Search...', 'snowfall'); ?></span></h3>
		<?php get_search_form(); ?>
		<p class="backhome"><a href="<?php echo esc_url(home_url()); ?>" >&laquo; <?php echo __('&laquo; Or Return to the Home Page', 'snowfall'); ?></a></p>
        </div>
        <br />
    <?php }	
	
	
//	Registers the Widgets and Sidebars for the site
	function snowfall_widgets_init() {

	register_sidebar( array(
		'name' =>  __('Primary Sidebar', 'snowfall'), 
		'id' => 'sidebar-1',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget' => "</aside>",
		'before_title' => '<h3 class="widget-title">',
		'after_title' => '</h3>',
	) );

	register_sidebar( array(
		'name' =>  __('Secondary Sidebar', 'snowfall'), 
		'id' => 'sidebar-2',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget' => "</aside>",
		'before_title' => '<h3 class="widget-title">',
		'after_title' => '</h3>',
	) );
	 
	register_sidebar( array(
		'name' => __('Footer Area One', 'snowfall'), 
		'id' => 'sidebar-3',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget' => "</aside>",
		'before_title' => '<h3 class="widget-title">',
		'after_title' => '</h3>',
	) );
	    
	register_sidebar( array(
		'name' =>  __('Footer Area Two', 'snowfall'), 
		'id' => 'sidebar-4',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget' => "</aside>",
		'before_title' => '<h3 class="widget-title">',
		'after_title' => '</h3>',
	) );

	register_sidebar( array(
		'name' => __('Footer Area Three', 'snowfall'), 
		'id' => 'sidebar-5',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget' => "</aside>",
		'before_title' => '<h3 class="widget-title">',
		'after_title' => '</h3>',
	) );
	
	
	register_sidebar( array(
		'name' => __('Footer Area Four', 'snowfall'), 
		'id' => 'sidebar-6',
		'before_widget' => '<aside id="%1$s" class="widget %2$s">',
		'after_widget' => "</aside>",
		'before_title' => '<h3 class="widget-title">',
		'after_title' => '</h3>',
	) );
	
	
	}
	add_action( 'widgets_init', 'snowfall_widgets_init' );
	
	
	add_filter('the_title', 'snowfall_title');
	function snowfall_title($title) { if ( '' == $title ) { return '(Untitled)'; } else { return $title; } }
	
