<CFOUTPUT>
<CFTRY >
	<CFIF isDefined("url.p") and url.p GT ''>
		<cfif FileExists(ExpandPath('/public/#url.p#.cfm'))> 
			<CFINCLUDE  template="/public/#url.p#.cfm" >
		<cfelse>
			<CFINCLUDE  template="/common/error/404-error-page/#application.brandname#/index.cfm" >
		</cfif>
		<CFABORT>
	</cfif>
	
	<CFIF url.f GT '/'>
		<!--- if we are going to something other than home page or shop folder --->
		<cfif FileExists(ExpandPath('/files#url.f#index.cfm'))> 
			<CFINCLUDE template="/files#url.f#index.cfm">
		<cfelse>
			<CFINCLUDE  template="/common/error/404-error-page/#application.brandname#/index.cfm" >
		</cfif>
	<CFELSE>
		<CFINCLUDE template="index.cfm">
	</CFIF>

	<CFCATCH>
		<CFINCLUDE template="index.cfm">
	</CFCATCH>
	</CFTRY>
</CFOUTPUT>
