<CFPARAM name="session.CartID" default="0">
<CFPARAM name="url.e" type="numeric" default="0">

<!--- check out page info translations:Order Subtotal, tax info etc. ---->
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_ResultInfo">
	<CFIF application.BrandID eq 2>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="57">
	<CFELSE>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="19">
	</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc>
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetCartItems_Result">	
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>
<!--- this should be a SUM function - jm not a loop --->
<CFSET orderSubtotal=0>
<CFIF pGetCartItems_Result.intProductID neq ''>
<CFLOOP query="pGetCartItems_Result">
	<CFSET orderSubtotal=orderSubtotal+Subtotal>
</CFLOOP>
</CFIF>
<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">
<!-- Wrapper -->
<div class="wrapper">
<!-- Topic Header -->
<div class="topic">
  <div class="container">
    <div class="row">
      <div class="col-sm-4">
      <h3 class="primary-font"> <cfoutput>#pGetPageContent_ResultInfo.strContentText1#</cfoutput></h3>
      </div>
    </div><!-- / .row -->
  </div>
</div>
<div class="container">
<cfoutput>#pGetPageContent_ResultInfo.strContentText2#</cfoutput>
<div class="row">

<CFINCLUDE template="/files/products/check-out/#session.langcode#/index.cfm">

</div><!-- / .row -->
</div> <!-- / .container -->
</div> <!-- / .wrapper -->
<CFINCLUDE template="/public/footer.cfm">