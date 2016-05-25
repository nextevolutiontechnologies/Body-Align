<CFPARAM name="repID" default=-1>
<CFPARAM name="session.signupID" default=0>
<CFPARAM name="session.eCartID" default=0>
<CFPARAM name="e" default="0">
<CFPARAM name="cid" default="0">

<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_Result">
	  <CFIF application.BrandID eq 2>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="52">
		<CFELSE>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="14">
		</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc> 

<!--- get additionalinfo --->
<cfstoredproc procedure="dbo.pGetAdditionalInfo" debug="yes" datasource="#application.datasource#">		
<cfprocresult name="pGetAdditionalInfo_Result">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">	
</cfstoredproc>	

<cfstoredproc procedure="dbo.pGetCartItems" debug="yes" datasource="#application.datasource#">		
<cfprocresult name="pGetCartItems_Result">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">	
</cfstoredproc>	
<CFQUERY name="getKitDescription" datasource="#application.datasource#">
	select strProductText2 from product_lang where intProductID=#pGetCartItems_Result.intProductID# and intLangID=#session.Lang#
</CFQUERY>


<CFINCLUDE template="/public/header.cfm">
<CFINCLUDE template="/public/main-nav.cfm">

<!-- Wrapper -->
<div class="wrapper">

<!-- Topic Header -->
<div class="topic">
<div class="container">
<div class="row">
<div class="col-sm-12">
<h3 class="primary-font"><cfoutput>#pGetPageContent_Result.strContentText1#</cfoutput></h3>
</div>
</div>
</div>
</div>
<div class="container"><cfoutput>#pGetPageContent_Result.strContentText2#</cfoutput>
<CFINCLUDE template="/files/theopportunity/information/#session.langcode#/index.cfm">
</div>
</div><!--- wrapper --->
<CFINCLUDE template="/public/footer.cfm">
