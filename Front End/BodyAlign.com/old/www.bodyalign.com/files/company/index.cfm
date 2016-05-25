<cfset this.activeNav="company">
<CFINCLUDE template="/public/header.cfm">  


    <CFINCLUDE template="/public/main-nav.cfm">
    	<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" >		
		<cfprocresult name="pGetPageContent_Result">
		<CFIF application.BrandID eq 2>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="54">
		<CFELSE>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="16">
		</CFIF>

		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
	</cfstoredproc> 

    <!-- Wrapper -->
    <div class="wrapper">      
      <div class="container">
        <div class="row">
          <div class="col-sm-12">
            <h2 class="headline text-color">
              <span class="border-color"><cfoutput>#pGetPageContent_Result.strContentText1#</cfoutput></span>
            </h2>
          </div>
        </div>
      </div>

      <div class="container">
        <div class="row port-item-p">
          <div class="col-sm-6">          
            <div class="port-slideshow-p">
              <!-- Image Carousel -->
              <div id="port-slideshow-p" class="carousel slide" data-ride="carousel">
                <!-- Wrapper for slides -->
                <div class="carousel-inner">
				<CFOUTPUT>
                  <div class="item active">
                    <img src="/common/img/pages/#session.langcode#/#pGetPageContent_Result.strContentImg1#" class="img-responsive" alt="Powervida">
                  </div>
                  <div class="item">
                    <img src="/common/img/pages/#session.langcode#/#pGetPageContent_Result.strContentImg2#" class="img-responsive" alt="Ingredients">
                  </div>
                  <div class="item">
                    <img src="/common/img/pages/#session.langcode#/#pGetPageContent_Result.strContentImg3#" class="img-responsive" alt="Big City">
                 </CFOUTPUT> </div>
				   
				  

                </div>
                <!-- Controls -->
                <a class="port-arrow-p port-arrow-prev bg-hover-color" href="#port-slideshow-p" data-slide="prev">
                  <i class="fa fa-angle-left"></i>
                </a>
                <a class="port-arrow-p port-arrow-next bg-hover-color" href="#port-slideshow-p" data-slide="next">
                  <i class="fa fa-angle-right"></i>
                </a>
              </div>
            </div>
          </div>
          <div class="col-sm-6">
            <!--- <p>
            	PowerVida is dedicated to helping its customers transform their lives!  We strongly believe that self-transformation begins on the inside by nourishing one's self with wholesome nutrition.
            </p>
            <p>
							Our product line was developed to support a healthy, active lifestyle!  Whether you're looking to lose weight, boost your immunity or simply supplement your "less than perfect" diet, we 
              believe you'll find what you need with PowerVida.
            </p>
            <p>
							Formulated by a medical doctor and his team with a lifetime of nutritional supplement experience, our products have been carefully created using only the highest quality ingredients available.
              Our team is continually researching ingredients and developing products with the most nutritional benefits to support an array of lifestyles.
            </p>
            <p>
            	Headquartered in Austin, TX, PowerVida's ownership and corporate structure consists of individuals with over 20 years of experience in the field of health and wellness.  Our mission is to improve 
            	our customers' quality of life by providing them with the latest advances in nutritional science.
          	</p> --->
		<cfoutput>#pGetPageContent_Result.strContentText2#</cfoutput>
          </div>
        </div> <!-- / .row -->
        <div class="row">
        	<div class="col-sm-12">
          	<hr>
            <a href="/<CFOUTPUT>#url.u#</CFOUTPUT>/contact/" class="btn btn-lg btn-color"><cfoutput>#pGetPageContent_Result.strContentText3#</cfoutput></a>
          </div>
        </div> <!-- / .row -->        
      </div> <!-- / .container -->

    </div> <!-- / .wrapper -->
    
    

    <CFINCLUDE template="/public/footer.cfm">