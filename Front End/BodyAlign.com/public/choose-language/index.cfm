<cfparam name="returnURL" default="/">
<cfparam name="url.lang" default="1">
<cfparam name="url.cntry" default="1">

<cfset session.Lang=url.lang>
<CFCOOKIE name="lang" value="#url.lang#" expires="NEVER">
<CFCOOKIE name="cntry" value="#url.cntry#" expires="NEVER">

<cfswitch expression="#url.lang#"> 
	<cfcase value="1"> 
		<CFSET session.langcode='en'>
	</cfcase>
	<cfcase value="2"> 
		<CFSET session.langcode='sp'>
	</cfcase>
</cfswitch>
<cfswitch expression="#url.cntry#"> 
	<cfcase value="1"> 
		<CFSET session.CountryCode='US'>
	</cfcase>
	<cfcase value="2"> 
		<CFSET session.CountryCode='MX'>
	</cfcase>
</cfswitch>
<cfif isdefined("cgi.HTTP_REFERER") and cgi.HTTP_REFERER gt "">	
	<cflocation url="#cgi.HTTP_REFERER#" ADDTOKEN="No">
<cfelse>	
	<cflocation url="/#url.u#" ADDTOKEN="No">
</cfif>