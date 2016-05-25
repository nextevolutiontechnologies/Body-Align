<cfif (not isdefined("form.csrfToken")) or (not CSRFVerifyToken(form.csrfToken)) >
<CFLOCATION url="/#url.u#/?hackError=666" addtoken="no" >
<cfelse>
<cftry>
<cfstoredproc procedure="pUPSERT_CONTACT" debug="yes" datasource="#application.datasource#">
<cfprocresult name="pUPSERT_CONTACT_Result">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContactID" type="in" value="0">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContactTypeID" type="in" value="10">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContactStatusID" type="in" value="10">
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFirstName" type="in"value="#form.strFirstName#">
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strLastName" type="in" value="#form.strLastName#">
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strAddress" type="in" null="true" >
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strAddress2" type="in" null="true" >
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCity" type="in" null="true" >
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intStateID" type="in"  null="true" >
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strZipCode" type="in" null="true" >
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPhone" type="in" null="true" >
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strEmail" type="in" value="#form.strEmail#">
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContactNote" type="in" value="#form.strMessage#">
</cfstoredproc>
<cfcatch></cfcatch>
</cftry>
<CFLOCATION url="/#url.u#/contact/?e=1" addtoken="no" >
</cfif>