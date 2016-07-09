<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script> 
<script src="/global/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="/global/js/bootstrapValidator-0.5.3.min.js"></script>
      <script type="text/javascript">
      
    $(document).ready(function() {
  $('#modal-fullscreen').on('hidden.bs.modal', function() {
    var $this = $(this).find('iframe'),
      tempSrc = $this.attr('src');
    $this.attr('src', "");
    $this.attr('src', tempSrc);
  });

  $('#html5Video').on('hidden.bs.modal', function() {
    var html5Video = document.getElementById("htmlVideo");
    if (html5Video != null) {
      html5Video.pause();
      html5Video.currentTime = 0;
    }
  });
});
</script>
        <script type="text/javascript">
    $(document).ready(function() {

		// For date picker on New Order page
	    $('#dp-ex-4').datepicker ()
    //start the validators
	$('#dp-ex-4')
	    .on('changeDate show', function(e) {
	        // Revalidate the date when user change it
	        $('#payment').bootstrapValidator('revalidateField', 'dtDateOfBirth');
	});



    //ENROLLMENT VALIDATOR
    $('#contactForm').bootstrapValidator({
    fields: {
    strFirstName: {
    validators: {
    notEmpty: {
    message: 'First Name is a required field.'
    }

    }
    },
    strLastName: {
    validators: {
    notEmpty: {
    message: 'Last Name is a required field.'
    }

    }
    },
    strAddress: {
    validators: {
    notEmpty: {
    message: 'Address 1 is a required field.'
    }

    }
    },
    strCity: {
    validators: {
    notEmpty: {
    message: 'City is a required field.'
    }

    }
    },
    intStateID: {
    validators: {
    notEmpty: {
    message: 'State is a required field.'
    }

    }
    },

    strEmail: {
    validators: {
    notEmpty: {
    message: 'Email is a required field.'
    },
    emailAddress: {
    message: 'This is not a valid email address.'
    }
    }
    },
    strMessage: {
    validators: {
    notEmpty: {
    message: 'Message is a required field.'
    }

    }
    },


    strPhone: {
    validators: {
    notEmpty: {
    message: 'Phone is a required field.'
    }


    }
    } //end validation fields
    }}); //end the validator

    //getHelp validation
    $('#MemberSupport').bootstrapValidator({
    fields: {
    SupportType: {
    validators: {
    notEmpty: {
    message: 'Support type is a required field.'
    }

    }
    },

    ContactMessage: {
    validators: {
    notEmpty: {
    message: 'Question or issue is a required field.'
    }


    }
    } //end validation fields
    }}); //end the validator


    $('#formZip').bootstrapValidator({
    fields: {

    strCartZip: {
    validators: {
    notEmpty: {
    message: 'Postal Code is Required.'
    }
    }
    }
    }}); //end the validator

	$('#form-coupon').bootstrapValidator({
    fields: {
    coupon: {
    validators: {
    notEmpty: {
    message: 'Coupon Code is Required.'
    }
    }
    }
    }}); //end the validator

    $('#addcart').bootstrapValidator({
    fields: {

    nqty: {
    validators: {
    notEmpty: {
    message: 'Quantity is Required.'
    }


    }
    }
    }}); //end the validator

 $('#upsertCartForm').bootstrapValidator({
    fields: {

    nqty: {
    validators: {
    notEmpty: {
    message: 'Quantity is Required.'
    }


    }
    }
    }}); //end the validator


    $('#payment').bootstrapValidator({
    fields: {

    strFirstName: {
    validators: {
    notEmpty: {
    message: 'First name is a required.'
    }
    }
    }

    ,
    strLastName: {
    validators: {
    notEmpty: {
    message: 'Last name is a required.'
    }
    }
    }

    ,
    CCNUMBER: {
    validators: {
    notEmpty: {
    message: 'Credit card number is required.'
    }
    }
    }

    ,
    strBillName: {
    validators: {
    notEmpty: {
    message: 'Name on credit card is a required.'
    }


    }
    } //end validation fields

    ,
    STREXPYEAR: {
    validators: {
    notEmpty: {
    message: 'Credit card expired year is required.'
    }
    }
    }

    ,
    STREXPMONTH: {
    validators: {
    notEmpty: {
    message: 'Credit card expired month is a required.'
    }
    }
    }

    ,
    ccv: {
    validators: {
    notEmpty: {
    message: 'CCV is a required.'
    }
    }
    }
    ,
    strBillingAddress: {
    validators: {
    notEmpty: {
    message: 'Mailing Address is a required.'
    }
    }
    }
    ,
    strBillingCity: {
    validators: {
    notEmpty: {
    message: 'Mailing city  is a required.'
    }
    }
    }
    ,
    intBillingStateID: {
    validators: {
    notEmpty: {
    message: 'Mailing state is a required.'
    }
    }
    }
    ,
    strBillingZip: {
    validators: {
    notEmpty: {
    message: 'Mailing Zip/Postal is a required.'
    }
    }
    }
    ,
    strEmail: {
    validators: {
    notEmpty: {
    message: 'Email Address is a required.'
    }
    }
    }
    ,


    strCartFirstName: {
    validators: {
    notEmpty: {
    message: 'Shipping first name is a required.'
    }
    }
    }
    ,
    strCartLastName: {
    validators: {
    notEmpty: {
    message: 'Shipping last name is a required.'
    }
    }
    }
    ,
    strCartAddress1: {
    validators: {
    notEmpty: {
    message: 'Shipping address is a required.'
    }
    }
    }
    ,
    strCartCity: {
    validators: {
    notEmpty: {
    message: 'Shipping city is a required.'
    }
    }
    }
    ,
    intCartStateID: {
    validators: {
    notEmpty: {
    message: 'Shipping state is a required.'
    }
    }
    }
    ,

    strCartZip: {
    validators: {
    notEmpty: {
    message: 'Shipping Zip/Postal is a required.'
    }
    }
    }
 ,
    strSsn: {
    validators: {
    notEmpty: {
    message: 'SSN# is a required.'
    }
    }
    }
     ,
    strUserName: {
    validators: {
    notEmpty: {
    message: 'Username is a required.'
    }
    }
    }
     ,

    dtDateOfBirth: {
    validators: {
    notEmpty: {
    message: 'Date of Birth is a required.'
    }
    }
    }
     ,
    strPhone: {
    validators: {
    notEmpty: {
    message: 'Phone is a required.'
    }
    }
    }

    }}); //end the validator

    }); // end document ready


  </script>
  
  <script>
    $('ul.nav li.dropdown').hover(function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
}, function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
});
</script>
<script>
$(document).ready(function(){
	
	if($( window ).width() >= 992 )
	{
		getFullheight();
	}
	else
	{
		getFullheightmobile();
	}
	
	newSlider($carousel_height);
	
	$( window ).resize(function() {
		if($( window ).width() >= 992 )
		{
			getFullheight();
		}
		else
		{
			getFullheightmobile();
		}
		
		newSlider($carousel_height);
	});
	
	

	function getFullheight()
	{	
		$s1024 = 0;
		
		if($( window ).width() == 1024 )
		{
			$s1024  = 7;
		}
		
		var deduct_height_total = $(".navbar").height() + $(".copyright").height() + $("footer").height();
		
		var window_height = $( window ).height();
		
		$mc = window_height - deduct_height_total;
		console.log(window_height);
		$("#myCarousel").height($mc-12);
		$carousel_height = $mc-12;
		$(".list-image").height( ($mc - 12 - 48 + 30 ) / 4);
		$("#myCarousel").css("margin-top",$(".navbar").height());
		$(".boxes").css("margin-top",$(".navbar").height() - 10 + $s1024);
	}
	function getFullheightmobile()
	{	
		var deduct_height_total = $(".ccont").height() + $(".copyright").height() + $("footer").height();
		
		var window_height = $( window ).height();
		
		$mc = window_height - deduct_height_total;
		
		$("#myCarousel").height($mc + $(".ccont").height()-12);
		$carousel_height = $mc + $(".ccont").height()-12;
		$(".list-image").height( (($( window ).width() - 12) / 4) - 30 );
		$("#myCarousel,.boxes").css("margin-top",$(".ccont").height());

	}	
});
</script>
<!-- END REVOLUTION SLIDER -->
            <script type="text/javascript">
                function newSlider($carouselHeight){
				
					var tpj = jQuery;

					var revapi8;

                    if ($("#rev_slider_8_1").revolution == undefined) {
                        revslider_showDoubleJqueryError("#rev_slider_8_1");
                    } else {
                        revapi8 = $("#rev_slider_8_1").show().revolution({
                            sliderType: "standard",
                            jsFileLocation: "files/js/",
                            sliderLayout: "auto",
                            dottedOverlay: "none",
                            delay: 1000,
                            navigation: {
                                keyboardNavigation: "on",
                                keyboard_direction: "horizontal",
                                mouseScrollNavigation: "off",
                                onHoverStop: "off",
                                touch: {
                                    touchenabled: "on",
                                    swipe_threshold: 75,
                                    swipe_min_touches: 1,
                                    swipe_direction: "horizontal",
                                    drag_block_vertical: false
                                },
                                arrows: {
                                    style: "hesperiden",
                                    enable: true,
                                    hide_onmobile: false,
                                    hide_onleave: false,
                                    tmp: '',
                                    left: {
                                        h_align: "left",
                                        v_align: "center",
                                        h_offset: 10,
                                        v_offset: 0
                                    },
                                    right: {
                                        h_align: "right",
                                        v_align: "center",
                                        h_offset: 10,
                                        v_offset: 0
                                    }
                                }
                            },
                            gridwidth: 800,
                            gridheight: $carouselHeight,
                            lazyType: "single",
                            shadow: 0,
                            spinner: "off",
                            stopLoop: "on",
                            stopAfterLoops: 0,
                            stopAtSlide: 1,
                            startDelay:100,
                            shuffle: "off",
                            autoHeight: "off",
                            disableProgressBar: "on",
                            hideThumbsOnMobile: "off",
                            hideSliderAtLimit: 0,
                            hideCaptionAtLimit: 0,
                            hideAllCaptionAtLilmit: 0,
                            debugMode: false,
                            fallbacks: {
                                simplifyAll: "off",
                                nextSlideOnWindowFocus: "off",
                                disableFocusListener: false,
                            }
                        });
                    }
 
					console.log($carouselHeight);
				}
            </script>
<script>
$('#idj-play-button').click(function () {
    document.getElementById('peaks-audio').play();
    $('#idj-play-button').addClass('hide');
    $('#idj-pause-button').removeClass('hide');

});

$('#idj-pause-button').click(function () {
    document.getElementById('peaks-audio').pause();
    $('#idj-pause-button').addClass('hide');
    $('#idj-play-button').removeClass('hide');
});

$('#peaks-audio').on('ended', function() {
  $('#idj-pause-button').addClass('hide');
  $('#idj-play-button').removeClass('hide');
  $('#peaks-audio').load();
});

 
</script>

<script>
$('#idj2-play-button').click(function () {
    document.getElementById('peaks-audio2').play();
    $('#idj2-play-button').addClass('hide');
    $('#idj2-pause-button').removeClass('hide');

});

$('#idj2-pause-button').click(function () {
    document.getElementById('peaks-audio2').pause();
    $('#idj2-pause-button').addClass('hide');
    $('#idj2-play-button').removeClass('hide');
});

$('#peaks-audio2').on('ended', function() {
  $('#idj2-pause-button').addClass('hide');
  $('#idj2-play-button').removeClass('hide');
  $('#peaks-audio2').load();
});

</script>

<script>
// .modal-backdrop classes

$(".modal-transparent").on('show.bs.modal', function () {
  setTimeout( function() {
    $(".modal-backdrop").addClass("modal-backdrop-transparent");
  }, 0);
});
$(".modal-transparent").on('hidden.bs.modal', function () {
  $(".modal-backdrop").addClass("modal-backdrop-transparent");
});

$(".modal-fullscreen").on('show.bs.modal', function () {
  setTimeout( function() {
    $(".modal-backdrop").addClass("modal-backdrop-fullscreen");
  }, 0);
});
$(".modal-fullscreen").on('hidden.bs.modal', function () {
  $(".modal-backdrop").addClass("modal-backdrop-fullscreen");
});

</script>
<script type="text/javascript">
jQuery(function(){var $slider=jQuery('.slider'),transitionTime=15000;$slider.width(280).find('.slide').not('.current').fadeOut(0);setInterval(function(){$slider.find('.current').removeClass('current').fadeOut(500,function(){var $this=jQuery(this);if($this.is(':last-child')){var $nextItem=$slider.find('.slide:first-child');}else{var $nextItem=$this.next();}
$nextItem.addClass('current').fadeIn(500);});},transitionTime);});
</script> 
 
 
 </body>
</html>
