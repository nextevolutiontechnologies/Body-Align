<cfcomponent>

	<cfset this.name=ListGetAt(CGI.HTTP_HOST,2,".") & '_1'>

	<cfset this.SessionManagement = "true">
	<cfset this.ClientManagement = "true">
	<cfset this.LogPath = expandPath("CFError.log")>
	<cfset this.ErrorTemplate = "/common/Error/DefaultMsg.cfm">
	<cfset this.datasource = "DEV_BODYALIGN">
	<cferror type="Request" template="/common/error/" >

	<cffunction name="onApplicationStart" returntype="boolean" output="true">
	 	<cfquery name="GetBrandInfo">
			SELECT TOP (1) intBrandID, strBrandName, strBrandCSS, isActive, dtRecord, strMerchantCode, strEmailDomain, strFrontEndDomain, strBackOfficeDomain, isHTTPS,strGoogleID
			FROM  BRANDING
			WHERE lower(strBrandName) = '#lcase(ListGetAt(CGI.HTTP_HOST,2,"."))#'
		</cfquery>
		<cfif GetBrandInfo.recordCount EQ 0>
		<cfquery name="GetBrandInfo">
			SELECT TOP (1) intBrandID, strBrandName, strBrandCSS, isActive, dtRecord, strMerchantCode, strEmailDomain, strFrontEndDomain, strBackOfficeDomain, isHTTPS,strGoogleID
			FROM  BRANDING
			WHERE intBrandID = 1
		</cfquery>
		</cfif>

		<cfset Application.ClientName = GetBrandInfo.strBrandName>
		<cfset Application.dateInitialized = Now()>
		<cfset Application.AppRootPath = "#ExpandPath("/")#">

		<CFSET Application.BrandID = GetBrandInfo.intBrandID>
		<cfset Application.EmailDomain = GetBrandInfo.strEmailDomain>
		<CFSET Application.BrandName = GetBrandInfo.strBrandName>
		<cfset Application.GoogleID = GetBrandInfo.strGoogleID>
		<cfset Application.BackOfficeURL = GetBrandInfo.strBackOfficeDomain>
		<cfif getBrandInfo.isHTTPS>
			<cfset Application.Protocol = "http://">
		<cfelse>
			<cfset Application.Protocol = "http://">
		</cfif>
		<cfset Application.datasource = 'DEV_BODYALIGN'>

		<CFIF LEFT(cgi.SERVER_NAME,6) EQ 'local.'>
			<cfset Application.datasource = 'DEV_BODYALIGN'>
			<cfset Application.Protocol = "http://">
        	<cfset Application.BackOfficeURL = "local." & ListGetAt(CGI.HTTP_HOST,2,".") & ".backoffice">
			<cfset Application.PublicURL = "local." & ListGetAt(CGI.HTTP_HOST,2,".")>
		</CFIF>

		<cfreturn true>

	</cffunction>
	<cffunction name="onRequestStart" returntype="boolean" output="true">
		<cfif structKeyExists(url,"reinit")>
			<cfset Applicationstop()>
		</cfif>

		<cfreturn true>
	</cffunction>
	<cffunction name="onRequestEnd" returntype="void" output="true">

	</cffunction>
	<!--- This method overrides any error handlers that you set in the ColdFusion Administrator or in cferror tags.
	It does not override try/catch blocks. --->
	<!--- Handle script related / 500 errors --->
	<cffunction name="onError" returntype="void" output="true">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" required="true">
	<!--- ---> <CFDUMP var="#arguments#"> <CFABORT>
	<!--- Throw validation errors to ColdFusion for handling. --->
    <cfif Find("coldfusion.filter.FormValidationException", Arguments.exception.StackTrace)>
        <cfthrow object="#exception#">
	<cfelse>
	    <cftry>
            <!--- Set response to 500 for Search Engine and statistics purposes --->
           <!---  <cfheader
               statusCode = "500"
               statusText = "Internal Server Error"
            > --->

			<!--- Log all errors in an application-specific log file. --->
			<cfset NewLine = chr(13) & chr(10)>
			<cfset ErrorMessage = "Event: #Eventname##NewLine#Error: #exception.Message##NewLine#">

	                <!--- retrieve the log path from the application scope --->
	                <cflock timeout="5" scope="application">
	                    <cfset logPath = This.LogPath>
					</cflock>

			<!--- <cffile
			   action = "append"
			   file = "#logPath#"
			   output = "#ErrorMessage#"
			> --->
		<!--- retrieve the error template from the application scope --->
		    <cflock timeout="5" scope="application">
		        <cfset ErrorTemplate = This.ErrorTemplate>
		    </cflock>

		    <!--- include a template to show to the user --->
		    <cfinclude template = "#This.ErrorTemplate#">
		    <!--- INSERT INTO ErrorLog --->
			<CFOUTPUT>
					<cfsavecontent variable="dumpexception">
			 		<b>Error</b>
					<CFDUMP var="#exception#">
					</cfsavecontent>

					<cfsavecontent variable="dumpcgi">
			 		<b>CGI</b>
					<CFDUMP var="#cgi#">
					</cfsavecontent>

					<cfsavecontent variable="dumpclient">
			 		<b>Client</b>
					<CFDUMP var="#client#">
					</cfsavecontent>
				    <CFSET strDiagnostics='#exception.Message# #exception.Detail#'>

				<cfstoredproc procedure="pErroLog_Insert" debug="no" datasource="#application.datasource#">
					<cfprocresult name="pErrorLog_Result">
					<cfprocparam dbvarname="intAppID" cfsqltype="cf_sql_integer"  value="1">
					<cfprocparam dbvarname="Application_Name" cfsqltype="cf_sql_varchar" value="#this.name#">
					<cfprocparam dbvarname="strErrorLog" cfsqltype="cf_sql_varchar"  value="#LEFT(exception.Message,500)#">
					<cfprocparam dbvarname="intErrorLogTypeID" cfsqltype="cf_sql_integer"  value="1">
					<cfprocparam dbvarname="strCGIPathinfo" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.Path_Info,200)#">
					<cfprocparam dbvarname="strDiagnostics" cfsqltype="cf_sql_varchar"  value="#LEFT(strDiagnostics,1000)#">
					<cfprocparam dbvarname="strSQLStatement" cfsqltype="cf_sql_varchar"  null="Yes">
					<cfprocparam dbvarname="strCGIREMOTE_ADDR" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.REMOTE_ADDR,500)#">
					<cfprocparam dbvarname="strCGIHTTPCOOKIE" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.HTTP_COOKIE,1000)#">
					<cfprocparam dbvarname="strCGIHTTPREFERER" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.HTTP_REFERER,500)#">
					<cfprocparam dbvarname="strCGIHTTPUSERAGENT" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.HTTP_USER_AGENT,1000)#">
					<cfprocparam dbvarname="strCGI" cfsqltype="cf_sql_varchar"  value="#dumpcgi#">
					<cfprocparam dbvarname="strclient" cfsqltype="cf_sql_varchar"  value="#dumpclient#">
					<cfprocparam dbvarname="strerror" cfsqltype="cf_sql_varchar"  value="#dumpexception#">
					<CFIF CGI.QUERY_STRING eq ''>
						<cfprocparam dbvarname="strQueryString" cfsqltype="cf_sql_varchar"   null="Yes">
					<CFELSE>
						<cfprocparam dbvarname="strQueryString" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.QUERY_STRING,1000)#">
					</CFIF>
				</cfstoredproc>

		    </CFOUTPUT>

		       <!--- If an error occurs within the error handler, the cfcatch routine will run.  In that case, we will return a custom error to the user.  This should only happen if there is a permissions problem writing to the log or the error template does not exist. --->
		   <cfcatch>
	      <!---   <cfthrow message="An error has occured."> --->An error has occured.
	    </cfcatch>
        </cftry>
    </cfif>

	<!--- 	<CFABORT> --->

	</cffunction>

	<cffunction name="onMissingTemplate" returnType="boolean">
    <cfargument type="string" name="targetPage" required=true/>
	<cftry>
	    <!--- set response to 404 for Search Engine and statistical purposes --->
	    <cfheader
	       statusCode = "404"
	       statusText = "Page Not Found"
	    >
	    <!--- retrieve the error template from the application scope --->
	    <cflock timeout="5" scope="application">
	        <cfset ErrorTemplate = This.ErrorTemplate>
	    </cflock>
	    <!--- include a template to show to the user --->
	    <cfinclude template = "#ErrorTemplate#">

	    <!--- insert into ErrorLog --->
	    <cfstoredproc procedure="pErroLog_Insert" debug="no" datasource="#application.datasource#">
					<cfprocresult name="pErrorLog_Result">
					<cfprocparam dbvarname="intAppID" cfsqltype="cf_sql_integer"  value="1">
					<cfprocparam dbvarname="strErrorLog" cfsqltype="cf_sql_varchar"  value="Missing Page">
					<cfprocparam dbvarname="intErrorLogTypeID" cfsqltype="cf_sql_integer"  value="2">
					<cfprocparam dbvarname="strCGIPathinfo" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.Path_Info,200)#">
					<cfprocparam dbvarname="strDiagnostics" cfsqltype="cf_sql_varchar"  value="Page Not Found: #arguments.targetPage#">
					<cfprocparam dbvarname="strSQLStatement" cfsqltype="cf_sql_varchar"  null="Yes">
					<cfprocparam dbvarname="strCGIREMOTE_ADDR" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.REMOTE_ADDR,500)#">
					<cfprocparam dbvarname="strCGIHTTPCOOKIE" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.HTTP_COOKIE,1000)#">
					<cfprocparam dbvarname="strCGIHTTPREFERER" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.HTTP_REFERER,500)#">
					<cfprocparam dbvarname="strCGIHTTPUSERAGENT" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.HTTP_USER_AGENT,1000)#">
					<cfprocparam dbvarname="strCGI" cfsqltype="cf_sql_varchar"  null="Yes">
					<cfprocparam dbvarname="strclient" cfsqltype="cf_sql_varchar"  null="Yes">
					<cfprocparam dbvarname="strerror" cfsqltype="cf_sql_varchar" null="Yes">
					<CFIF CGI.QUERY_STRING eq ''>
						<cfprocparam dbvarname="strQueryString" cfsqltype="cf_sql_varchar"   null="Yes">
					<CFELSE>
						<cfprocparam dbvarname="strQueryString" cfsqltype="cf_sql_varchar"  value="#LEFT(CGI.QUERY_STRING,1000)#">
					</CFIF>
			</cfstoredproc>
		    <!--- return true to prevent the default ColdFusion error handler from running --->
	    <cfreturn true />
	    <cfcatch>
	    <!--- If an error occurs within the error handler routine, allow ColdFusion's default error handler to run --->
	        <cfreturn false />
	    </cfcatch>
	</cftry>
	</cffunction>


</cfcomponent>