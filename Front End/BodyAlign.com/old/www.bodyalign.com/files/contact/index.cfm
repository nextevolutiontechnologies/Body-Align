<cfset this.activeNav="contact">
<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">

<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_Result">
	<CFIF application.BrandID eq 2>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="66">
	<CFELSE>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="29">
	</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc> 

<!-- Wrapper -->
<div class="wrapper">
<div class="container">
<div class="row">
<div class="col-sm-8 contact-us-p">
<h2 class="headline text-color">
<span class="border-color"><cfoutput>#pGetPageContent_Result.strContentText1#</cfoutput></span>
</h2>
<p><cfoutput>#pGetPageContent_Result.strContentText2#</cfoutput></p>
<CFINCLUDE template="/files/contact/#session.langcode#/index.cfm">
</div>
<div class="col-sm-4">
<h2 class="headline first-child first-child-m text-color">
<span class="border-color"><cfif session.lang eq 2>Nuestro Domicilio<cfelse>Our Address</cfif></span>
</h2>
<p><cfoutput>#pGetPageContent_Result.strContentText3#</cfoutput></p>
<h2 class="headline text-color">
<span class="border-color"><cfif session.lang eq 2>Mapa Google<cfelse>Google Map</cfif></span>
</h2>
<div class="map">
<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3441.1083828406104!2d-97.9266402!3d30.404666699999996!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x865b30e8787d440f%3A0xe2fa38e679d93bb8!2s4417+Hudson+Bend+Rd!5e0!3m2!1sen!2sus!4v1403824914888" width="350" height="300" frameborder="0" style="border:0"></iframe>
<a class="btn btn-sm btn-color" target="_blank" href="https://www.google.com/maps/place/4417+Hudson+Bend+Rd/@30.4046667,-97.9266402,17z/data=!3m1!4b1!4m2!3m1!1s0x865b30e8787d440f:0xe2fa38e679d93bb8"><CFIF session.lang EQ 2>Vea El Mapa M&aacute;s Grande<CFELSE>View Larger Map</CFIF></a>
</div>
</div>
</div>
</div>
</div> <!-- / .wrapper -->
<CFINCLUDE template="/public/footer.cfm">