<script language="javascript">
	function getShipping()
	{
		var z=$("#strCartZip").val();
		if(z == '')
		{
			 $('#sec-total' ).hide();
			 $("#shipping-message").html("<font color='red'>Zip Code is Required</font>")
			return false;
		}
		else
		{
			$("#shipping-message").html('');
			$.ajax({
            url:'/<cfoutput>#url.u#</cfoutput>/checkout/ShipandTax/',
            data: {
            		"strCartZip": z
            		},
        	dataType: 'json',
            success: function(response) {

                if(response.success >=1)
					{
						$('#sec-total' ).show();
						$('#submit').on('click', function() {
                		window.location="/<cfoutput>#url.u#</cfoutput>/checkout/payment/";
            });
					}
                },
            error: function(response) {
                console.log('There is error.')}
          });
        }
	}
</script>