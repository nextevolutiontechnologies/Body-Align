<CFPARAM name="urlnotexists" default="0">
<CFIF isDefined("url.u") and (url.u neq '/'  or url.u NEQ '') and ListLen(url.u, "/") gte 1>

<CFSET local.Username = ListGetAt(url.u, 1, "/")>

	<cfstoredproc procedure="pCheckMemberUsername" datasource="#application.datasource#" debug="true"  cachedwithin="#createTimeSpan( 0, 0, 0, 0 )#">
		<cfprocparam value="#local.Username#" cfsqltype="CF_SQL_VARCHAR">
		 <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" value="#application.brandID#">
		<cfprocresult name="pCheckMemberUsername_RESULTS">
	</cfstoredproc>

	<CFIF pCheckMemberUsername_RESULTS.intMemberID gt 0>
	   <cfstoredproc procedure="pGetMemberInfo" datasource="#application.datasource#" debug="true">
			<cfprocparam value="#pCheckMemberUsername_RESULTS.intMemberID#" cfsqltype="CF_SQL_INTEGER">
			<cfprocresult name="pGetMemberInfo_RESULTS">
		</cfstoredproc>
		

	
		<CFIF not isDefined("session.url") or session.url neq local.Username> 
			<CFSET Session.MemberID = pCheckMemberUsername_RESULTS.intMemberID>
			<CFCOOKIE name="strMyURL" value="#local.username#" expires="NEVER">	
		</CFIF>
           
		<CFIF not isdefined("cookie.lang")>
				<!--- <CFPARAM NAME="session.lang" default="#pGetMemberInfo_RESULTS.intLangID#"> --->
				 <CFSET session.lang=pGetMemberInfo_RESULTS.intLangID>
				<CFCOOKIE name="lang" value="#pGetMemberInfo_RESULTS.intLangID#" expires="NEVER">
		 <CFELSEIF not isDefined("session.lang")>
		 	<CFSET session.lang=cookie.lang> 	
		 </CFIF>
	<CFELSE>
	   <!--- <cflocation url="/home/" addtoken="No"><CFABORT> ---><CFSET urlnotexists=1>
	</CFIF>
</CFIF>    
<!--- <CFELSE> --->
<CFIF not (isDefined("url.u") and (url.u neq '/'  or url.u NEQ '') and ListLen(url.u, "/") gte 1) or urlnotexists is 1>
	<CFIF isDefined("cookie.strMyURL")>
		<!--- check if username exists --->
		<cfstoredproc procedure="pCheckMemberUsername" datasource="#application.datasource#" debug="true"  cachedwithin="#createTimeSpan( 0, 0, 0, 0 )#">
			<cfprocparam value="#cookie.strMyURL#" cfsqltype="CF_SQL_VARCHAR">
			<cfprocresult name="pCheckMemberUsername_RESULTS">
		</cfstoredproc>
		<CFIF pCheckMemberUsername_RESULTS.intMemberID gt 0>
			<cflocation url="/#cookie.strMyURL#/" addtoken="No">
		<cfelse>
			<CFCOOKIE name="strMyURL" value="#local.username#" expires="#now()#">
			<cflocation url="/home/" addtoken="No">
		</cfif>
		<CFABORT>
	<CFELSE>
	
		<cflocation url="/home/" addtoken="No">
		<CFABORT>
	</cfif>
	<CFIF isDefined("cookie.lang")>
  		<CFSET session.lang=cookie.lang>
	<CFELSE>
	    <CFSET session.lang=1>
	</CFIF>
</CFIF>  

<CFIF not isDefined("session.lancode")>
	<cfswitch expression="#session.lang#"> 
	<cfcase value="1"> 
		<CFSET session.langcode='en'>
	</cfcase>
	<cfcase value="2"> 
		<CFSET session.langcode='sp'>
	</cfcase>
	</cfswitch>
</CFIF>
