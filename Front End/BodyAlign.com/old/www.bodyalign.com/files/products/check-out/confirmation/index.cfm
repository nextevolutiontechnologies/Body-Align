<CFINCLUDE template="/public/header.cfm">  
<CFPARAM name="session.CustomerID" default="0">
<CFINCLUDE template="/public/main-nav.cfm">
<!--- shopping cart fields translation ---->
<!--- confirmation page translation ----> 
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_ResultConfirmation">
	<CFIF application.BrandID eq 2>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="63">
	<CFELSE>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="26">
	</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc> 
<!--- We need to show final orderdata here not cart - JM ---> 
<cfstoredproc procedure="pGetOrderInfo" debug="yes" datasource="#application.datasource#">		
<cfprocresult name="pGetOrderInfo_Result">	
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.intOrderID#">
</cfstoredproc>



<!-- Wrapper -->
<div class="wrapper">
<!-- Topic Header -->
<div class="topic">
<div class="container">
<div class="row">
<div class="col-sm-4">
<h3 class="primary-font"><!--- Confirmation - Order Completed ---><cfoutput>#pGetPageContent_ResultConfirmation.strContentText1#</cfoutput></h3>
</div> 
</div>
</div>
</div>

<CFINCLUDE template="/files/products/check-out/confirmation/#session.langcode#/index.cfm">

</div> <!-- / .wrapper -->
<CFINCLUDE template="/public/footer.cfm">