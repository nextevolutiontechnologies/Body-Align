<CFPARAM name="session.CustomerID" default="0">
<CFPARAM name="session.CartID" default="0">
<CFPARAM name="session.eOrderID" default="0">
<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,1,0,0)#">		
	<cfprocresult name="pGetPageContent_ResultShoppingCart">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" Value="22">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
</cfstoredproc> 
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_OpportunityConfirm">
	<CFIF application.BrandID eq 2>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="90">
	<CFELSE>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="91">
	</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc>

<cfstoredproc procedure="pGetOrderInfo" debug="yes" datasource="#application.datasource#">		
<cfprocresult name="pGetOrderInfo_Result">	
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eOrderID#">
</cfstoredproc>

<!-- Wrapper -->
<div class="wrapper">
<!-- Topic Header -->
<div class="topic">
<div class="container">
<div class="row">
<div class="col-sm-8">
<h3 class="primary-font"><cfoutput>#pGetPageContent_OpportunityConfirm.strContentText1#</cfoutput></h3>
</div>
</div>
</div>
</div>
<cfoutput>
<div class="container">
<cftry>

<div class="row">
<div class="col-sm-12">

<p class="botMarg25">#pGetPageContent_OpportunityConfirm.strContentText3#</p>
</div>
</div>

	     
<div class="row">
<cfif pGetOrderInfo_Result.intOrderID neq ''>
<div class="col-sm-7 shopping-cart">
<h3>#pGetPageContent_OpportunityConfirm.strContentText2#</h3>
<CFINCLUDE template="/files/theopportunity/confirmation/#session.langcode#/index.cfm">
</div>

<cflock timeout=20 scope="Session" type="Exclusive">
    <cfset Session.eorderid = 0>
</cflock>
<cflock timeout=20 scope="Session" type="Exclusive">
    <cfset Session.ecartid = 0>
</cflock>
</cfif>
<cfcatch>
<cfdump var="#cfcatch#">
<cfabort>          
</cfcatch>
</cftry>

</div> <!-- / .row -->

</div> <!-- / .container -->
</CFOUTPUT>
</div> <!-- / .wrapper -->

<CFINCLUDE template="/public/footer.cfm">