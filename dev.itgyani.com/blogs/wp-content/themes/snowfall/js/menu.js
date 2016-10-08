jQuery(document).ready(function(){ jQuery('#header').css('width', jQuery('body').outerWidth(true) ); jQuery("#snowfall-main-menu ul ul").css({display: "none"}); jQuery('#snowfall-main-menu ul li').hover( function() { jQuery(this).find('ul:first').slideDown(200).css('visibility', 'visible'); jQuery(this).addClass('selected'); }, function() { jQuery(this).find('ul:first').slideUp(200); jQuery(this).removeClass('selected'); }); });

 jQuery(window).resize(function(){ jQuery('#header').css('width', jQuery('body').outerWidth(true) ); });

		jQuery(document).ready(function() {
		var hheight = jQuery('#header').outerHeight(true);
		jQuery('.mslides').css('marginTop', hheight ); 
		var sheight = jQuery('.mslides').outerHeight(true);
		jQuery('.clear-top').css('marginTop', sheight );

		 
		
		
		jQuery('.mobile-menu').click(function(){ jQuery('#snowfall-main-menu').toggle(); });
		jQuery('.headerheight').css('marginTop', jQuery('#header').outerHeight(true) );
		
		
			jQuery(window).scroll(function() {
				jQuery('#header').css('left','-'+jQuery(window).scrollLeft()+'px');
				if (jQuery(this).scrollTop() > jQuery('#header').outerHeight(true)) {
					jQuery(".snowfall-top-menu-container").hide();
					jQuery('.go-top').fadeIn(150);

				} else {
					jQuery(".snowfall-top-menu-container").show();;
					jQuery('.go-top').fadeOut(150);
				}
			});
			
			// Animate the scroll to top
			jQuery('.go-top').click(function(event) {
				event.preventDefault();
				jQuery('html, body').animate({scrollTop: 0}, 500);
			})
		
		});

	

	
		
	












