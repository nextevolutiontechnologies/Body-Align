<!--- We are going to need to handle looking for email address attached to other reps. --->
<cfparam name="session.memberid" default="1">
<cfstoredproc procedure="pCustomerLogin" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pCustomerLogin_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.memberid#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strEmail" type="in" value="#form.Email#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPassword" type="in" value="#HASH(form.password)#">
</cfstoredproc>

<CFIF pCustomerLogin_Result.intCustomerID  gt 0>
	<CFSET session.CustFirstName=pCustomerLogin_Result.strFirstName>
	<CFSET session.CustID=pCustomerLogin_Result.intCustomerID>
	<cflocation url="/#url.u#/products/check-out/customer/" addtoken="no">
<CFELSE>
	<CFLOCATION url="/#url.u#/products/check-out/?e=-1" addToken="0">
</CFIF>