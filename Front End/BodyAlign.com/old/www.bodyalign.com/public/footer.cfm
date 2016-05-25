<!-- Footer -->
<CFPARAM name="imgDir" default="#ExpandPath('/common/img/member/')#">
<CFPARAM name="ThisFileName" default="">
<CFPARAM name="hasMainImg" default=0>
<footer class="footer-dark">
<div class="container">
<div class="row">
<!-- Contact Us -->
<div class="col-md-5 col-sm-6">
<!--- <cfstoredproc procedure="pGetMemberWebsite" debug="yes" datasource="#application.datasource#">		
<cfprocresult name="pGetMemberWebsite_Results">
<cfprocparam variable="intMemberID" cfsqltype="cf_sql_integer" value="#session.memberID#">
</cfstoredproc> --->
<h3><span><cfif session.lang eq 2>Contactanos<cfelse>Contact</cfif></span></h3>
<div class="content">
<CFOUTPUT>
<div class="row">
<div class="col-sm-9">
<p>
#pGetMemberWebsite_Results.strFullname#<br>
<CFIF pGetMemberWebsite_Results.strAddress gt '' >
#pGetMemberWebsite_Results.strAddress# <br>
</CFIF>
#pGetMemberWebsite_Results.strCity#, #pGetMemberWebsite_Results.strStateCode# #pGetMemberWebsite_Results.strZipCode#<br>
<CFIF pGetMemberWebsite_Results.strPhone gt '' >
#pGetMemberWebsite_Results.strPhone#<br>
</CFIF>
</CFOUTPUT>
<CFOUTPUT><a href="/#url.u#/contact/">Contact</a></CFOUTPUT>
</p>
</div>
</div>
</div>
</div>
<!-- Social icons -->
<div class="col-md-3 col-sm-3">
<h3><span><cfif session.lang eq 2>Redes Sociales<cfelse>Go Social</cfif></span></h3>
<div class="content social">
<p><cfif session.lang eq 2>Mantente en contacto con nosotros<cfelse>Stay in touch with us:</cfif></p>
<ul class="list-inline">
<li><a href="http://www.facebook.com/powervidanow" target="_blank" class="facebook"><i class="fa fa-facebook"></i></a></li>
</ul>
<div class="clearfix"></div>
</div>
</div>
<!-- Subscribe -->
<div class="col-md-4 col-sm-3">
<h3><span><cfif session.lang eq 2>Subscr&iacute;bete<cfelse>Subscribe</cfif></span></h3>
<div class="content">
<cfif session.lang eq 2>
<p>
Escribe tu correo electr&oacute;nico para suscribirte a nuestro bolet&iacute;n informativo.
Prometemos no molestarte tan seguido.</p>	
<cfelse>
<p>Enter your e-mail below to subscribe to our free newsletter.<br />We promise not to bother you often!</p>
</cfif>
<form class="form" role="form">
<div class="row">
<div class="col-sm-10">
<div class="input-group">
<label class="sr-only" for="subscribe-email"><cfif session.lang eq 2>Correo electr&oacute;nico<cfelse>Email address</cfif></label>
<input type="email" class="form-control" id="subscribe-email" placeholder="Enter email">
<span class="input-group-btn">
<button type="submit" class="btn btn-default">OK</button>
</span>
</div>
</div>
</div>
</form>
</div>
</div>
</div>

<div class="row">
<div class="col-sm-12">
<hr>
</div>
</div><!-- /.row -->

<!-- Copyrights -->
<div class="row">
<div class="col-sm-12">
<CFIF session.lang EQ 2>
<p>&copy; <cfoutput>#Application.ClientName#</cfoutput> <CFOUTPUT>#dateformat(Now(),"YYYY")#. <a href="/#url.u#/privacy-policy/">Pol&iexcl;tica de Privacidad</a> | <a href="/#url.u#/terms-and-conditions/">Terminos y Condiciones</a> | <a href="http://#Application.BackOfficeURL#/login/">Acceso de Miembro <i class="fa fa-sign-in"></i></a></CFOUTPUT>
<CFELSE>
<p>&copy; <cfoutput>#Application.ClientName#</cfoutput> <CFOUTPUT>#dateformat(Now(),"YYYY")#. <a href="/#url.u#/privacy-policy/">Privacy Policy</a> | <a href="/#url.u#/terms-and-conditions/">Terms & Conditions</a> | <a href="http://#Application.BackOfficeURL#/login/">Member Login <i class="fa fa-sign-in"></i></a></CFOUTPUT>
</CFIF>
<span id="siteseal" class="pull-right"><script type="text/javascript" src="https://seal.godaddy.com/getSeal?sealID=V5Rt0OqodorZHk00L8GojVG6WLGniBYxONF01A7kd8gXkPOkNM"></script></span></p>

</div>
</div><!-- /.row -->
</div>
</footer>
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="/common/js/bootstrap.min.js"></script>
<script src="/common/js/scrolltopcontrol.js"></script>
<script src="/common/js/jquery.sticky.js"></script>
<script src="/js/<cfoutput>#application.brandname#</cfoutput>-custom.js"></script>
<script src="/common/js/bootstrapValidator.min.js"></script>
<script src="/common/js/polyfill-placeholder.js"></script>
<script src="/common/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<!--- Code to allow for custom stuff --->
<cfparam name="customfoot" default="" >
<cfoutput>#customfoot#</cfoutput>
<!---<cfif (NOT isdefined("session.movieoff") OR isDefined("url.showitanyway")) and application.BrandID EQ 1>
<script type="text/javascript">
	$(window).load(function(){
			$('#homeModal').modal('show');
	});
</script>
<cfset session.movieoff = 1>
</cfif>--->
<script type="text/javascript">
	$(window).load(function(){  
		$('input').placeholder();
	});  
</script>

<!--[if lt IE 10]>
<script src="/js/carousel.js"></script>
<![endif]-->


<script type="text/javascript">
$(document).ready(function() {
// For date picker on New Order page
	    $('#dp-ex-4').datepicker ()
			
$('#CustomerForm').bootstrapValidator({
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
strAddress1: {
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
strZipCode: {
validators: {
		notEmpty: {
				message: 'Zip Code is a required field.'
		}
		
}
},
ccnumber: {
validators: {
		notEmpty: {
				message: 'CC Number is a required field.'
		}
		
}
},
strBillName: {
validators: {
		notEmpty: {
				message: 'Name on card is a required field.'
		}
		
}
},
strCCExp: {
validators: {
		notEmpty: {
				message: 'Exp. Date is a required field.'
		}
		
}
},
ccv: {
validators: {
		notEmpty: {
				message: 'CCV is a required field.'
		}
		
}
},
ccv1: {
validators: {
		notEmpty: {
				message: 'CCV is a required field.'
		}
		
}
},
strBillStreet: {
validators: {
		notEmpty: {
				message: 'Mailing Address is a required field.'
		}
		
}
},
strBillCity: {
validators: {
		notEmpty: {
				message: 'City is a required field.'
		}
		
}
},
intBillState: {
validators: {
		notEmpty: {
				message: 'State is a required field.'
		}
		
}
},
strBillZipCode: {
validators: {
		notEmpty: {
				message: 'Zip code is a required field.'
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
}




}
});
//});
// STEP ONE
$('#dist-agreement').bootstrapValidator({
fields: {
strSponsorname: {
validators: {
notEmpty: {
message: 'Name is a required field'
}
}
},

sponsoremail: {
validators: {
notEmpty: {
message: 'Email is a required field'
},
emailAddress: {
message: 'This is not a valid email address'
}
}
},
sponsorphone: {
validators: {
notEmpty: {
message: 'Phone is a required field'
},
phone: {
message: 'Not a valid Number, must use area code'
}
}
},
strFName: {
validators: {
notEmpty: {
message: 'First Name is a required field'
}
}
},
strLName: {
validators: {
notEmpty: {
message: 'First Name is a required field'
}
}
},
stremail: {
validators: {
notEmpty: {
message: 'Email is a required field'
},
emailAddress: {
message: 'This is not a valid email address'
}
}
},
strAddress: {
validators: {
notEmpty: {
message: 'Address is a required field'
}
}
},
strCity: {
validators: {
notEmpty: {
message: 'City is a required field'
}
}
},
intStateid: {
validators: {
notEmpty: {
message: 'State is a required field'
}
}
},
strZipcode: {
validators: {
notEmpty: {
message: 'Zip Code is a required field'
}
}
},
strSsn: {
validators: {
notEmpty: {
message: 'SSN# is a required field'
}
}
},
dtDateOfBirth: {
validators: {
notEmpty: {
message: 'DOB is a required field'
}
//date: {
       //format: 'MM/DD/YYYY',
      // message: 'The value is not a valid date'
//}
}
},	

strUserName: {
validators: {
notEmpty: {
message: 'User Name is a required field'
}
}
}								
}
});


    
    $('#dp-ex-4')
    .on('changeDate show', function(e) {
        // Revalidate the date when user change it
        $('#dist-agreement').bootstrapValidator('revalidateField', 'dtDateOfBirth');
});

// STEP ONE
$('#paymentinfo').bootstrapValidator({
fields: {
ccnumber: {
validators: {
notEmpty: {
message: 'Credit Card # is a required field'
},
creditCard: {
message: ''	
}
}
},
nameoncard: {
validators: {
notEmpty: {
message: 'Name On Card is a required field'
}
}
},
expdate: {
validators: {
notEmpty: {
message: 'Exp. Date is a required field'
}
}
},
ccv: {
validators: {
notEmpty: {
message: 'CCV is a required field'
},
cvv: {
creditCardField: 'ccnumber',
message: ''	
}
}
},
mailAddress: {
validators: {
notEmpty: {
message: 'Mailing Address is a required field'
}
}
},
city: {
validators: {
notEmpty: {
message: 'City is a required field'
}
}
},
state: {
validators: {
notEmpty: {
message: 'State is a required field'
}
}
},
zip: {
validators: {
notEmpty: {
message: 'Zip Code is a required field'
}
}
},
terms: {
validators: {
notEmpty: {
message: 'Terms &amp; Conditions must be checked'
}
}
}
}
});

// CONTACT US
$('#contact-form').bootstrapValidator({
fields: {                
strFirstname: {
validators: {
notEmpty: {
message: 'Firstname is a required field'
}
}
},
strLastname: {
validators: {
notEmpty: {
message: 'Lastname is a required field'
}
}
},
strEmail: {
validators: {
notEmpty: {
message: 'Email is a  required field'
},
		emailAddress: {
				message: 'This is not a valid email address'
		}
}
}
}
});

});
</script>
</body>
</html>