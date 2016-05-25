<CFINCLUDE template="/public/header.cfm">  

    <CFINCLUDE template="/public/main-nav.cfm">

    <!-- Wrapper -->
    <div class="wrapper">

      <div class="container">
        <div class="row">
          <div class="col-sm-12">
          	<cfif session.lang eq 2>
            <h2 class="headline text-color">
              <span class="border-color">Confirmaci&oacute;n</span>
            </h2>
            
            <i class="fa fa-check-circle text-success pull-left font100"></i>
            <h4 class="topPad35">
            	
					Su mensaje ha sido enviado. Nosotros revisaremos su mensaje y responder apropiadamente.
					<br>
              		<br>
					Gracias.
            </h4>
			<cfelse>
			<h2 class="headline text-color">
              <span class="border-color">Confirmation</span>
            </h2>
            
            <i class="fa fa-check-circle text-success pull-left font100"></i>
            <h4 class="topPad35">
            
					Your message has been sent. We will review your message and respond appropriately.
					<br>
              		<br>
             	 Thank you.
		    </h4>
            </cfif>
          </div>
        </div>
      </div>
    </div> <!-- / .wrapper -->

    <CFINCLUDE template="/public/footer.cfm">