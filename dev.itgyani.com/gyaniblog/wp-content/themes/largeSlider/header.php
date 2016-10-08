<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
<head> 
<link href='http://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
  <title><?php wp_title('&laquo;', true, 'right'); ?> <?php bloginfo('name'); ?></title>          
  <?php wp_head(); ?>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <!--[if lt IE 9]>
  <script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
  <![endif]-->                  
  <link rel="stylesheet" href="<?php bloginfo('stylesheet_url'); ?>" type="text/css" media="screen" title="no title" charset="utf-8"/>
  <script src="<?php bloginfo('stylesheet_directory'); ?>/js/jquery-latest.js" type="text/javascript"></script>  
  <script src="<?php bloginfo('stylesheet_directory'); ?>/js/scripts.js" type="text/javascript"></script>  
  <script src="<?php bloginfo('stylesheet_directory'); ?>/js/modernizr-2.6.1.min.js"></script>
  <!-- Demo CSS -->
	<link rel="stylesheet" href="<?php bloginfo('stylesheet_directory'); ?>//flexslider.css" type="text/css" media="screen" />
	
	<!-- Modernizr -->
  <script src="<?php bloginfo('stylesheet_directory'); ?>/js/modernizr.js"></script>
  
  <!-- FlexSlider -->
  <script defer src="<?php bloginfo('stylesheet_directory'); ?>/js/jquery.flexslider.js"></script>
  
  <link rel="stylesheet" href="<?php bloginfo('stylesheet_directory'); ?>/responsiveslides.css">
  <script src="<?php bloginfo('stylesheet_directory'); ?>/js/responsiveslides.js"></script>
  
  <script type="text/javascript">
    $(window).load(function(){
      $('.flexslider').flexslider({
        animation: "slide",
        start: function(slider){
          $('body').removeClass('loading');
        }
      });
    });
    
    
    $(function () {
      // Slideshow 4
      $("#slider4").responsiveSlides({
        auto: true,
        pager: false,
        nav: true,
	timeout: 8000,  
        speed: 500,
        namespace: "callbacks",
        before: function () {
          $('.events').append("<li>before event fired.</li>");
        },
        after: function () {
          $('.events').append("<li>after event fired.</li>");
        }
      });
    });    
  </script>  
  
  
    <!-- Optional FlexSlider Additions -->
  <script src="<?php bloginfo('stylesheet_directory'); ?>/js/jquery.easing.js"></script>
  <script src="<?php bloginfo('stylesheet_directory'); ?>/js/jquery.mousewheel.js"></script>
  <script defer src="<?php bloginfo('stylesheet_directory'); ?>/js/demo.js"></script>
</head>
<body>
<?php $shortname = "ultra_simple"; ?>
    <?php if(get_option($shortname.'_custom_background_color','') != "") { ?>
    <style type="text/css">
      body { background-color: <?php echo get_option($shortname.'_custom_background_color',''); ?>; }
    </style>
    <?php } ?>

<?php if(is_home()) { ?>
<div style="position: absolute; width: 100%;">    
<?php } ?>
<div id="header">
    <div class="social_cont">
        <ul>
          <?php if(get_option($shortname.'_pinterest_link','') != "") { ?>
              <li><a href="<?php echo get_option($shortname.'_pinterest_link',''); ?>"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/pinterest-icon.png" /></a></li>
          <?php } ?>
          <?php if(get_option($shortname.'_dribbble_link','') != "") { ?>
              <li><a href="<?php echo get_option($shortname.'_dribbble_link',''); ?>"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/dribbble-icon.png" /></a></li>
          <?php } ?>
          <?php if(get_option($shortname.'_google_plus_link','') != "") { ?>
              <li><a href="<?php echo get_option($shortname.'_google_plus_link',''); ?>"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/google-plus-icon.png" /></a></li>
          <?php } ?>
          <?php if(get_option($shortname.'_facebook_link','') != "") { ?>
              <li><a href="<?php echo get_option($shortname.'_facebook_link',''); ?>"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/facebook-icon.png" /></a></li>
          <?php } ?>
          <?php if(get_option($shortname.'_twitter_link','') != "") { ?>
              <li><a href="<?php echo get_option($shortname.'_twitter_link',''); ?>"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/twitter-icon.png" /></a></li>
          <?php } ?>
        </ul>
        <div class="clear"></div>
    </div><!--//social_cont-->
   
    <div align="center">
    
        <?php if(get_option($shortname.'_custom_logo_url','') != "") { ?>
          <a href="<?php bloginfo('url'); ?>"><img src="<?php echo stripslashes(stripslashes(get_option($shortname.'_custom_logo_url',''))); ?>" class="logo" alt="logo" /></a>
        <?php } else { ?>
          <a href="<?php bloginfo('url'); ?>"><img src="<?php bloginfo('stylesheet_directory'); ?>/images/logo.png" class="logo" alt="logo" /></a>
        <?php } ?>        
        
    </div>
    
    <div class="header_menu">
        <?php wp_nav_menu('menu=header_menu&container=false&menu_id=menu'); ?>
        <div class="clear"></div>
    </div><!--//header_menu-->
    
    <div class="clear"></div>
</div><!--//header-->
<?php if(is_home()) { ?>
</div>
<?php } ?>