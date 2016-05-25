<CFDUMp var="#form#">

<cfstoredproc procedure="pGetCustomerSearch" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pCustomerSearch_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFirstName" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strLastName" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCity" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intStateID" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strZipCode" type="in" value="#form.ZipCode#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strEmail" type="in" value="#form.Email#">
</cfstoredproc>

<CFIF pCustomerSearch_Result.intCustomerID  gt 0>
	<CFINVOKE component="cfc.SendEmailAPI" method="ForgotPasswordCustomerEmail" returnVariable="ForgotPasswordCustomerEmail_results">
			<cfinvokeargument name="customerID" value="#pCustomerSearch_Result.intCustomerID#">
	</CFINVOKE>
	<CFIF ForgotPasswordCustomerEmail_results eq 0>
		<CFLOCATION url="/#url.u#/products/check-out/?e=2" addToken="0">
	<CFELSE>
		<CFLOCATION url="/#url.u#/products/check-out/?e=-3" addToken="0">
	</CFIF>
	<CFOUTPUT></CFOUTPUT>
<CFELSE>
	<CFLOCATION url="/#url.u#/products/check-out/?e=-3" addToken="0">
</CFIF>