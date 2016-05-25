<!---<CFIF IsDefined("url.u") and url.u NEQ '/'>
<CFIF ListLen(url.u,"/") GT 0>
<cfquery name="GetSiteData" datasource="#Application.datasource#" cachedwithin="#createTimeSpan( 0, 1, 0, 0 )#">
	SELECT TOP 1000 [intMemberID] ,[intRepID],[strFirstName] + ' ' + [strLastname] as strCustomerName,[strUserName],strCountryCode
	FROM [dbo].[vGetMemberInfo]
	WHERE  (strUserName = '#ListGetAt(url.u, 1, "/")#') 
--AND UPPER(StatusCodes.SimpleStatus) in('ACTIVE','WARNING')
</cfquery>
<CFIF GetSiteData.recordCount GTE 1>
	<CFSET CURRENTDIRNAME="">
<CFELSE>
	<cflocation url="http://#CGI.Server_name#/home/" addtoken="No"> 
	<CFABORT>
</CFIF>
<CFELSE>
<cflocation url="http://#CGI.Server_name#/home/" addtoken="No">


<CFTRY>
<CFCATCH TYPE="Any">
<cflocation url="http://#CGI.Server_name#/home/" addtoken="No">
<CFABORT>

</CFCATCH>
</CFTRY>
</CFIF>
</CFIF>
<CFIF NOT IsDefined("Session.MEMBERID")>
<cflocation url="http://#CGI.Server_name#/home/" addtoken="No">
</CFIF>--->