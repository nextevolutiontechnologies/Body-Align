<cfset this.activeNav="science">
<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" >		
	<cfprocresult name="pGetPageContent_Result">
	<CFIF application.BrandID eq 2>
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="81">
	<CFELSE>
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="0">
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
	<cfoutput>#pGetPageContent_Result.strContentText2#</cfoutput>
	</div> <!-- / .container -->
</div> <!-- / .wrapper -->
<CFINCLUDE template="/public/footer.cfm">