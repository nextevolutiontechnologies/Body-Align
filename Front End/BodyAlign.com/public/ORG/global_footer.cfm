		<script src="/global/js/jquery-1.11.1.min.js"></script>
        <script src="/global/js/bootstrap-3.3.5.min.js"></script>
        <script src="/global/js/plugins/datepicker/bootstrap-datepicker.js"></script>
        <script src="/js/flexslider.min.js"></script>
        <script src="/js/masonry.min.js"></script>
        <script src="/js/parallax.js"></script>
        <script src="/js/scripts.js"></script>
        <script src="/global/js/bootstrapValidator-0.5.3.min.js"></script>
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
    </body>
</html>