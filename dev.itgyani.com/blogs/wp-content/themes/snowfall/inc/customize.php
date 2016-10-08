<?php

function snowfall_customize_register($wp_customize){

    
    $wp_customize->add_section('snowfall_options', array(
        'priority' 		=> 10,
		'capability'     => 'edit_theme_options',
		'title'    		=> __('SNOWFALL OPTIONS', 'snowfall'),
        'description'   => '<div class="infohead"><span class="donation"><strong>'. __('SnowFall is CSS3 Powered and WordPress Latest Version Ready Responsive Theme. You can Learn More about the Features from the', 'snowfall').' <a href="'. esc_url('http://d5creation.com/theme/snowfall/').'" target="_blank"><strong>SnowFall '. __('Theme Page', 'snowfall').'</strong></a></strong></span></div>'
    ));
	
	
//  Social Links
	foreach (range(1, 5 ) as $snowfall_numslinksn) {
    $wp_customize->add_setting('snowfall[sl' . $snowfall_numslinksn .']', array(
        'default'        	=> '',
    	'sanitize_callback' => 'esc_url',
        'capability'     	=> 'edit_theme_options',
        'type'           	=> 'option'

    ));

    $wp_customize->add_control('snowfall_sl' . $snowfall_numslinksn, array(
        'label'      => __('Social Link - ',  'snowfall'). $snowfall_numslinksn,
        'section'    => 'snowfall_options',
        'settings'   => 'snowfall[sl' . $snowfall_numslinksn .']',
		'description' => __('Input Your Social Page Link. Example: <b>http://wordpress.org/d5creation</b>. Supported Links are: wordpress.org, wordpress.com, dribbble.com, github.com, tumblr.com, youtube.com, flickr.com, vimeo.com, codepen.io, linkedin.com', 'snowfall'),
    ));	
	}
	
	
	
//  Slide Titles 	
	$wp_customize->add_setting('snowfall[slide-caption-a1]', array(
        'default'        	=> '',
        'capability'     	=> 'edit_theme_options',
    	'sanitize_callback' => 'sanitize_text_field',
        'type'           	=> 'option'

    ));

    $wp_customize->add_control('snowfall_slide-caption-a1', array(
        'label'      => __('Slide Title 01', 'snowfall'),
        'section'    => 'snowfall_options',
        'settings'   => 'snowfall[slide-caption-a1]'
    ));
	
	$wp_customize->add_setting('snowfall[slide-caption-b1]', array(
        'default'        	=> '',
        'capability'     	=> 'edit_theme_options',
    	'sanitize_callback' => 'sanitize_text_field',
        'type'           	=> 'option'

    ));

    $wp_customize->add_control('snowfall_slide-caption-b1', array(
        'label'      => __('Slide Title 02', 'snowfall'),
        'section'    => 'snowfall_options',
        'settings'   => 'snowfall[slide-caption-b1]'
    ));
	
	$wp_customize->add_setting('snowfall[slide-caption-c1]', array(
        'default'        	=> '',
        'capability'     	=> 'edit_theme_options',
    	'sanitize_callback' => 'sanitize_text_field',
        'type'           	=> 'option'

    ));

    $wp_customize->add_control('snowfall_slide-caption-c1', array(
        'label'      => __('Slide Title 03', 'snowfall'),
        'section'    => 'snowfall_options',
        'settings'   => 'snowfall[slide-caption-c1]'
    ));
	
	$wp_customize->add_setting('snowfall[slide-link1-text1]', array(
        'default'        	=> '',
        'capability'     	=> 'edit_theme_options',
    	'sanitize_callback' => 'sanitize_text_field',
        'type'           	=> 'option'

    ));

    $wp_customize->add_control('snowfall_slide-link1-text1', array(
        'label'      => __('Special Text 01', 'snowfall'),
        'section'    => 'snowfall_options',
        'settings'   => 'snowfall[slide-link1-text1]'
    ));
	
	$wp_customize->add_setting('snowfall[slide-link2-text1]', array(
        'default'        	=> '',
        'capability'     	=> 'edit_theme_options',
    	'sanitize_callback' => 'sanitize_text_field',
        'type'           	=> 'option'

    ));

    $wp_customize->add_control('snowfall_slide-link2-text1', array(
        'label'      => __('Special Text 02', 'snowfall'),
        'section'    => 'snowfall_options',
        'settings'   => 'snowfall[slide-link2-text1]'
    ));

}


add_action('customize_register', 'snowfall_customize_register');


	if ( ! function_exists( 'snowfall_get_option' ) ) :
	function snowfall_get_option( $snowfall_name, $snowfall_default = false ) {
	$snowfall_config = get_option( 'snowfall' );

	if ( ! isset( $snowfall_config ) ) : return $snowfall_default; else: $snowfall_options = $snowfall_config; endif;
	if ( isset( $snowfall_options[$snowfall_name] ) ):  return $snowfall_options[$snowfall_name]; else: return $snowfall_default; endif;
	}
	endif;