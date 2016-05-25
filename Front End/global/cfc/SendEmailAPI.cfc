<cfcomponent output="no"  hint="This list of Email sent from Public website">
<cffunction name="SendContactRequest" returntype="string" output="no" access="remote">

	<cfargument name="intContactID" type="numeric" required="yes">
	<CFSET retvar  = 0>
		<CFQUERY name="pGetContactResults" datasource="#Application.Datasource#">
			SELECT TOP 1 vc.[intCONTACTID] ,vc.[intMemberID]
				      ,vc.[intContactTypeID],vc.[intContactStatusID]
				      ,vc.[strFirstName] + ' ' + vc.[strLastName] ContactName
				      ,vc.[strPhone],vc.[strEmail]
				      ,vc.[strAddress],vc.[strAddress2],vc.[strCity],vc.[intStateID],vc.[strZip]
				      ,vc.[dtRecord]
				      ,vc.[strContactNote]
				      ,m.strEmail MemberEmail
				      ,m.strFirstName + ' ' + m.strLastname MemberName,m.intLangID
				      ,dbo.fGetMemberBrandID(m.intMemberID) as BrandID
  			FROM [dbo].[vGetContact] vc with (nolock) inner join dbo.member m with (nolock) on vc.intMemberID = m.intMemberID
  			WHERE vc.intContactID = #arguments.intContactID#
		</CFQUERY>
		<CFQUERY name="pGetEmailInfoResults" datasource="#Application.Datasource#">
			SELECT *
			FROM dbo.vGetEmailList
			WHERE strEmailAccess = 'SendContactRequest' and intLangID = #pGetContactResults.intLangID#
		</CFQUERY>
		<cfset efrom = pGetContactResults.strEmail>
		<cfset eSubject = pGetEmailInfoResults.strSubject>
		<cfset eto =  pGetContactResults.MemberEmail>

		<CFSAVECONTENT variable="EmailContent">
		<cfoutput>#REPLACENoCase(
					REPLACENoCase(
					REPLACENoCase(
					REPLACENoCase(
					REPLACENoCase(pGetEmailInfoResults.strContent,"$$ContactName$$",pGetContactResults.ContactName,"All")
					,"$$ContactEmail$$",pGetContactResults.strEmail)
					,"$$ContactPhone$$",pGetContactResults.strPhone)
					,"$$ContactMessage$$",pGetContactResults.strContactNote)
					,"$$MEMBERNAME$$",pGetContactResults.MemberName)#</cfoutput>
		</CFSAVECONTENT>

			<CFINVOKE method="SendEmail" returnVariable="SendEmail_results">
				<cfinvokeargument name="SendFROM" value="#efrom#">
				<cfinvokeargument name="SendTO" value="#eto#">
				<cfinvokeargument name="SendSUBJECT" value="#eSubject#">
				<cfinvokeargument name="SendCONTENT" value="#EmailContent#">
			</CFINVOKE>
		<CFSET retvar=SendEmail_results>
	<CFRETURN retvar>
</cffunction>

<cffunction name="SendOrderEmailByAccessType" returntype="string" output="yes" access="remote">
	<cfargument name="OrderId" type="numeric" required="yes">
	<cfargument name="strEmailAccess" type="string" required="no" default="OrderInvoice" hint="OrderInvoice,OrderDeclined,OrderCancel">
	<cfargument name="pwdupdate" type="string" default="0" required="no">
	<cfargument name="brandId" type="numeric" default="0" required="no">
	<CFSET retvar  = 10>
	<cfset ResetPasswordResults="">
	<CFTRY>
		<cfstoredproc procedure="dbo.pGetOrderEmail" debug="no" datasource="#application.datasource#">
			<cfprocresult name="pGetOrderEmail_Results">
			<cfprocparam variable="intOrderID" cfsqltype="cf_sql_integer"  value="#arguments.OrderID#">
		</cfstoredproc>
		<cfset intBrandId="#pGetOrderEmail_Results.intBrandId#" >
		<cfif isdefined("arguments.brandId") and arguments.brandId gt 0>
			<cfset intBrandId="#arguments.brandId#">
		</cfif>
		<cfstoredproc procedure="pGetEmailByAccess" debug="yes" datasource="#application.datasource#">
			<cfprocresult name="pGetEmailByAccess_Results">
			<cfprocparam variable="strEmailAccess" cfsqltype="cf_sql_nvarchar"  value="#arguments.strEmailAccess#" >
			<cfprocparam variable="intBrandID" cfsqltype="cf_sql_integer" value="#intBrandId#" >
			<cfprocparam variable="intLangID" cfsqltype="cf_sql_integer" value="#pGetOrderEmail_Results.intLangId#" >
		</cfstoredproc>

		<CFIF pGetEmailByAccess_Results.RecordCount eq 0>
			<!---Email template does not exist--->
			<cfset retvar='-55'>
		</CFIF>
		<CFIF pGetOrderEmail_Results.strEmail eq ''>
			<!--- Email address not exist --->
			<cfset retvar='-60'>
		</CFIF>
		<!--- Are we Sending a password.--->
		<cfif isDefined("arguments.pwdupdate") and arguments.pwdupdate eq 1>
			<cfif pGetOrderEmail_Results.intCustomerID gt 0>
				<CFINVOKE component="global.cfc.SecureAPI" method="ResetCustomerPassword"  returnVariable="ResetPasswordResults">
					<cfinvokeargument name="intCustomerID" value="#pGetOrderEmail_Results.intCustomerID#">
				</CFINVOKE>
			<cfelse>
			<!--- update member password --->
				<CFINVOKE component="global.cfc.SecureAPI" method="ResetPassword"  returnVariable="ResetPasswordResults">
					<cfinvokeargument name="intMemberID" value="#pGetOrderEmail_Results.intMemberID#">
				</CFINVOKE>
			</cfif>
		</cfif>
		<CFIF pGetEmailByAccess_Results.RecordCount gt 0 and pGetOrderEmail_Results.strEmail gt ''>
			<cfset efrom = pGetEmailByAccess_Results.strFrom>
			<cfset eSubject = pGetEmailByAccess_Results.strSubject & " Order ##:"  &  arguments.OrderID >
			<cfset eto = pGetOrderEmail_Results.strBillingFirstName & " " & pGetOrderEmail_Results.strBillingLastName  & "<" & pGetOrderEmail_Results.strEmail & ">">
			<!---<cfset eto = "Test Emailname<email-test@tekvation.net>">--->
			<CFSET LineItems = ValueList(pGetOrderEmail_Results.strProduct,"<BR>")>
			<CFSAVECONTENT variable="EmailContent">
			<CFOUTPUT>#REPLACE(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				REPLACENoCase(
				pGetEmailByAccess_Results.strContent, '$$LAST4CARD$$',pGetOrderEmail_Results.strLast4,"All"),
				'$$ORDERFIRSTNAME$$',pGetOrderEmail_Results.strOrderFirstName,"ALL"),
				'$$ORDERDATE$$',pGetOrderEmail_Results.dtOrder,"ALL"),
				'$$ORDERID$$',pGetOrderEmail_Results.intOrderID,"ALL"),
				'$$LINEITEMS$$', LineItems,"ALL"),
				'$$ORDERSUBTOTAL$$',DollarFormat(pGetOrderEmail_Results.subtotal),"ALL"),
				'$$ORDERTAX$$',DollarFormat(pGetOrderEmail_Results.amtTax),"ALL"),
				'$$ORDERSHIP$$',DollarFormat(pGetOrderEmail_Results.amtShipping),"ALL"),
				'$$ORDERTOTAL$$',DollarFormat(pGetOrderEmail_Results.amtOrderTotal),"ALL"),
				'$$ORDERADDRESS$$',pGetOrderEmail_Results.strBillingAddress,"ALL"),
				'$$CITYSTATEZIP$$',pGetOrderEmail_Results.strBillingCity & ' ' & pGetOrderEmail_Results.strBillingStateCode & ' ' & pGetOrderEmail_Results.strBillingZip,"ALL"),
				'$$ORDERCOUNTRY$$',pGetOrderEmail_Results.strBillingCountryCode,"ALL"),
				'$$SPONSORNAME$$',pGetOrderEmail_Results.SponsorName,"ALL"),
				'$$ORDEREMAIL$$',pGetOrderEmail_Results.strEmail,"ALL"),
				'$$RESETPASSWORD$$',ResetPasswordResults,"ALL"),
				'$$SPONSOREMAIL$$',pGetOrderEmail_Results.strSponsorEmail,"ALL")
				#</CFOUTPUT>
			</CFSAVECONTENT>
			<CFINVOKE method="SendEmail" returnVariable="SendEmail_results">
				<cfinvokeargument name="SendFROM" value="#efrom#">
				<cfinvokeargument name="SendTO" value="#eto#">
				<cfinvokeargument name="SendSUBJECT" value="#eSubject#">
				<cfinvokeargument name="SendCONTENT" value="#EmailContent#">
			</CFINVOKE>
			<CFSET retvar  = 100>
		</CFIF>
		<CFCATCH>
			<CFSET retvar  = "-70">
			<!--- <CFINCLUDE template="/error/cfcatch.cfm"> --->
		</CFCATCH>
	</CFTRY>
	<cfreturn retvar>
</cffunction>

<cffunction name="SendNotificationToEnroller" returntype="string" output="yes" access="remote">
	<cfargument name="MemberID" type="numeric" required="yes">
	<cfargument name="BrandID" type="numeric" required="yes">
	<CFSET retvar  = 10>
	<cfset ResetPasswordResults="">
	<CFTRY>
		<cfstoredproc procedure="dbo.pGetMemberInfo" debug="no" datasource="#application.datasource#">
			<cfprocresult name="pGetMemberInfo_Results">
			<cfprocparam variable="intMemberID" cfsqltype="cf_sql_integer"  value="#arguments.MemberID#">
		</cfstoredproc>
		<cfstoredproc procedure="pGetEmailByAccess" debug="yes" datasource="#application.datasource#">
			<cfprocresult name="pGetEmailByAccess_Results">
			<cfprocparam variable="strEmailAccess" cfsqltype="cf_sql_nvarchar"  value="NoticeToEnroller">
			<cfprocparam variable="intBrandID" cfsqltype="cf_sql_integer" value="#arguments.BrandID#" >
			<cfprocparam variable="intLangID" cfsqltype="cf_sql_integer" value="#pGetMemberInfo_Results.intLangId#" >
		</cfstoredproc>

		<CFIF pGetEmailByAccess_Results.RecordCount eq 0>
			<!---Email template does not exist--->
			<cfset retvar='-55'>
		</CFIF>
		<CFIF pGetMemberInfo_Results.strSponsorEmail eq ''>
			<!--- Email address not exist --->
			<cfset retvar='-60'>
		</CFIF>

		<CFIF pGetEmailByAccess_Results.RecordCount gt 0 and pGetMemberInfo_Results.strSponsorEmail gt ''>
			<cfset efrom = pGetEmailByAccess_Results.strFrom>
			<cfset eSubject = pGetEmailByAccess_Results.strSubject >
			<cfset eto = pGetMemberInfo_Results.SponsorName  & ' ' & "<" & pGetMemberInfo_Results.strSponsorEmail & ">">
			<!---<cfset eto = "Test Emailname<email-test@tekvation.net>">--->
			<CFSAVECONTENT variable="EmailContent">
			<CFOUTPUT>#ReplaceNoCase(
						ReplaceNoCase(
						ReplaceNoCase(pGetEmailByAccess_Results.strContent, '$$NEWMEMBERNAME$$',pGetMemberInfo_Results.strFullName,"All")
						,'$$NewMemberPhone$$',pGetMemberInfo_Results.strPhone,"ALL")
						,'$$NewMemberEmail$$',pGetMemberInfo_Results.strEmail,"ALL")#</CFOUTPUT>
			</CFSAVECONTENT>
			<CFINVOKE method="SendEmail" returnVariable="SendEmail_results">
				<cfinvokeargument name="SendFROM" value="#efrom#">
				<cfinvokeargument name="SendTO" value="#eto#">
				<cfinvokeargument name="SendSUBJECT" value="#eSubject#">
				<cfinvokeargument name="SendCONTENT" value="#EmailContent#">
			</CFINVOKE>
			<CFSET retvar  = 100>
		</CFIF>
		<CFCATCH>
			<CFSET retvar  = "-70">
			<!--- <CFINCLUDE template="/error/cfcatch.cfm"> --->
		</CFCATCH>
	</CFTRY>
	<cfreturn retvar>
</cffunction>

<cffunction name="SendCourseComplete" returntype="string" output="yes" access="remote">
	<cfargument name="MemberID" type="numeric" required="yes">
	<cfargument name="BrandID" type="numeric" required="yes">
	<cfargument name="strEmailAccess" type="string" required="yes" >
	<CFSET retvar  = 10>
	<cfset ResetPasswordResults="">
	<CFTRY>
		<cfstoredproc procedure="dbo.pGetMemberInfo" debug="no" datasource="#application.datasource#">
			<cfprocresult name="pGetMemberInfo_Results">
			<cfprocparam variable="intMemberID" cfsqltype="cf_sql_integer"  value="#arguments.MemberID#">
		</cfstoredproc>
		<cfstoredproc procedure="pGetEmailByAccess" debug="yes" datasource="#application.datasource#">
			<cfprocresult name="pGetEmailByAccess_Results">
			<cfprocparam variable="strEmailAccess" cfsqltype="cf_sql_nvarchar"  value="#arguments.strEmailAccess#">
			<cfprocparam variable="intBrandID" cfsqltype="cf_sql_integer" value="#arguments.BrandID#" >
			<cfprocparam variable="intLangID" cfsqltype="cf_sql_integer" value="#pGetMemberInfo_Results.intLangId#" >
		</cfstoredproc>

		<CFIF pGetEmailByAccess_Results.RecordCount eq 0>
			<!---Email template does not exist--->
			<cfset retvar='-55'>
		</CFIF>
		<CFIF pGetMemberInfo_Results.strEmail eq ''>
			<!--- Email address not exist --->
			<cfset retvar='-60'>
		</CFIF>

		<CFIF pGetEmailByAccess_Results.RecordCount gt 0 and pGetMemberInfo_Results.strEmail gt ''>
			<cfset efrom = pGetEmailByAccess_Results.strFrom>
			<cfset eSubject = pGetEmailByAccess_Results.strSubject >
			<cfset eto = pGetMemberInfo_Results.strFullName  & ' ' & "<" & pGetMemberInfo_Results.strEmail & ">">
			<!---<cfset eto = "Test Emailname<email-test@tekvation.net>">--->
			<CFSAVECONTENT variable="EmailContent">
			<CFOUTPUT>#ReplaceNoCase(pGetEmailByAccess_Results.strContent, '$$ORDERFIRSTNAME$$',pGetMemberInfo_Results.strFullName,"All")#</CFOUTPUT>
			</CFSAVECONTENT>
			<CFINVOKE method="SendEmail" returnVariable="SendEmail_results">
				<cfinvokeargument name="SendFROM" value="#efrom#">
				<cfinvokeargument name="SendTO" value="#eto#">
				<cfinvokeargument name="SendSUBJECT" value="#eSubject#">
				<cfinvokeargument name="SendCONTENT" value="#EmailContent#">
			</CFINVOKE>
			<CFSET retvar  = 100>
		</CFIF>
		<CFCATCH>
			<CFSET retvar  = "-70">
			<cfdump var="#cfcatch#">
		</CFCATCH>
	</CFTRY>
	<cfreturn retvar>
</cffunction>
<cffunction name="SendForgotCustomerPassword" returntype="boolean" output="no" access="remote">
	<cfargument name="strEmail" type="string" required="yes">
	<cfargument name="strZipCode" type="string" required="yes">

		<CFSET retvar  = 0>
		<CFSET EmailAccess  = 'Customer-ResetPassword'>
	   	<CFQUERY name="GetCustomerData" datasource="#Application.Datasource#">
		   	SELECT intCustomerID,strEmail,strFirstName,strLastName, strPassword
			FROM dbo.CUSTOMER with (nolock)
			WHERE strEmail = <cfqueryparam value="#arguments.strEmail#" cfsqltype="CF_SQL_VARCHAR" >
				  and strZipCode = <cfqueryparam value="#arguments.strZipCode#" cfsqltype="CF_SQL_VARCHAR" >
		</CFQUERY>

		<!--- if a customer was found --->
		<cfif GetCustomerData.intCustomerID GT 0>
	   		<CFQUERY name="GetEmailData" datasource="#Application.Datasource#">
				SELECT e.intEmailID,e.strFrom,e.isSubjectLock,el.strSubject,el.strContent
				FROM dbo.EMAIL e with (nolock) inner Join dbo.EMAIL_LANG el with (nolock) on el.intEmailID = e.intEmailID
				WHERE strEmailAccess='#EmailAccess#'
			</CFQUERY>

		   	<CFINVOKE component="global.cfc.SecureAPI" method="ResetCustomerPassword"  returnVariable="ResetCustomerPasswordResults">
				<cfinvokeargument name="intCustomerID" value="#GetCustomerData.intCustomerID#">
			</CFINVOKE>

			<cfset efrom = GetEmailData.strFrom>
			<cfset eSubject = GetEmailData.strSubject>
			<cfset eto = GetCustomerData.strEmail>

			<CFSAVECONTENT variable="EmailContent">
			<CFOUTPUT>
				#REPLACE(
				REPLACE(
				REPLACE(
				REPLACE(GetEmailData.strContent,'$$MEMBERNAME$$',GetCustomerData.strFirstname,"All" )
				,"$$MEMBEREMAIL$$",GetCustomerData.strEmail,"ALL" )
				,"$$MEMBERPASSWORD$$",ResetCustomerPasswordResults,"All" )
				,"$$SITEURL$$",'http://www.mypaycationservices.com/platinumtravel-login/login/',"All" )#
			</CFOUTPUT>
			</CFSAVECONTENT>

			<CFINVOKE method="SendEmail" returnVariable="SendEmail_results">
				<cfinvokeargument name="SendFROM" value="#efrom#">
				<cfinvokeargument name="SendTO" value="#eto#">
				<cfinvokeargument name="SendSUBJECT" value="#eSubject#">
				<cfinvokeargument name="SendCONTENT" value="#EmailContent#">
			</CFINVOKE>
			<CFSET retvar  = 2>
			<CFIF ResetCustomerPasswordResults NEQ "-1">
			<CFELSE>
				<CFSET retvar  = -2>
			</CFIF>
	<CFELSE>
		<CFSET retvar  = -3>
   </cfif>
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -1>
			<CFINCLUDE template="/common/error/cfcatch.cfm">
		</CFCATCH>
	</CFTRY>
	<cfreturn retvar>

</cffunction>
<cffunction name="SendForgotPassword" returntype="boolean" output="no" access="remote">
	<cfargument name="intMemberID" type="numeric" required="yes">
	<CFSET retvar  = 0>
	<CFSET EmailAccess  = 'forgot-password'>
   	<CFQUERY name="GetMemberData" datasource="#Application.Datasource#">
	   	SELECT intMemberID,intBrandID,strEmail,strFirstName,strLastName,intLangID
		FROM dbo.MEMBER
		WHERE intMemberID = IsNull(#arguments.intMemberID#,0)
	</CFQUERY>
   <cfif GetMemberData.intMemberID GT 0>
   	<CFQUERY name="GetBrandData" datasource="#Application.Datasource#">
		SELECT Top 1 intBrandID,strFrontEndDomain,strBackOfficeDomain,strBrandName
		FROM dbo.BRANDING
		WHERE intBrandID IN(0,IsNull(#GetMemberData.intBrandID#,0))
		ORDER BY intBrandID DESC
	</CFQUERY>
	<CFQUERY name="GetEmailData" datasource="#Application.Datasource#">
		SELECT e.intEmailID,e.strFrom,e.isSubjectLock,el.strSubject,el.strContent
		FROM dbo.EMAIL e with (nolock) inner Join dbo.EMAIL_LANG el with (nolock) on el.intEmailID = e.intEmailID
		WHERE strEmailAccess='#EmailAccess#'
			and intBrandID='#GetMemberData.intBrandID#'
			and intlangID=#GetMemberData.intlangID#
	</CFQUERY>

	<CFINVOKE component="global.cfc.SecureAPI" method="ResetPassword"  returnVariable="ResetPasswordResults">
		<cfinvokeargument name="intMemberID" value="#arguments.intMemberID#">
	</CFINVOKE>

	<cfset efrom = GetEmailData.strFrom>
	<cfset eSubject = GetEmailData.strSubject>
	<cfset eto = GetMemberData.strFirstName  & ' ' & GetMemberData.strLastName  & '<' & GetMemberData.strEmail & '>'>

	<CFSAVECONTENT variable="EmailContent">
	<CFOUTPUT>
	#REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(
	REPLACE(GetEmailData.strContent,'$$MEMBERFIRSTNAME$$',GetMemberData.strFirstname,"All" )
	,"$$FRONTENDDOMAIN$$",GetBrandData.strFrontEndDomain,"ALL" )
	,"$$BACKOFFICEDOMAIN$$",GetBrandData.strBackOfficeDomain,"ALL" )
	,"$$BRANDNAME$$",GetBrandData.strBrandName,"ALL" )
	,"$$MEMBEREMAIL$$",GetMemberData.strEmail,"ALL" )
	,"$$NewPassword$$",ResetPasswordresults,"All" )#
	</CFOUTPUT>
	</CFSAVECONTENT>
	<CFIF ResetPasswordResults NEQ "-1">
		<CFINVOKE method="SendEmail" returnVariable="SendEmail_results">
			<cfinvokeargument name="SendFROM" value="#efrom#">
			<cfinvokeargument name="SendTO" value="#eto#">
			<cfinvokeargument name="SendSUBJECT" value="#eSubject#">
			<cfinvokeargument name="SendCONTENT" value="#EmailContent#">
		</CFINVOKE>
		<CFSET retvar  = 2>
	<CFELSE>
		<CFSET retvar  = -2>
	</CFIF>
	<CFELSE>
		<CFSET retvar  = -3>
   </cfif>
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -1>
			<CFINCLUDE template="/common/error/cfcatch.cfm">
		</CFCATCH>
	</CFTRY>
	<cfreturn retvar>
</cffunction>
<cffunction name="SendResetPassword" returntype="boolean" output="no" access="remote">
	<cfargument name="intMemberID" type="numeric" required="Yes">
	<cfargument name="intLangID" type="numeric" default="1" required="No">
	<cfargument name="intBrandID" type="numeric" default="1" required="No">
	<CFSET retvar  = 0>

		<cfstoredproc procedure="dbo.pGetMemberInfo" debug="no" datasource="#application.datasource#">
			<cfprocresult name="PGETMEMBERINFO_RESULT">
			<cfprocparam variable="intMemberID" cfsqltype="cf_sql_integer"  value="#arguments.intMemberID#">
		</cfstoredproc>

		<CFQUERY name="pGetEmailInfoResults" datasource="#Application.Datasource#">
			select top 1 *
			from vGetEmailList_NEW
			where intEmailTypeID=10
				and intBrandID='#PGETMEMBERINFO_RESULT.intBrandID#'
				and intlangID=#arguments.intLangID#
		</CFQUERY>



		<CFINVOKE component="cfc.SecureAPI" method="ResetPassword"  returnVariable="ResetPasswordResults">
			<cfinvokeargument name="intMemberID" value="#arguments.intMemberID#">
		</CFINVOKE>


		<cfset efrom = pGetEmailInfoResults.strFrom>
		<cfset eSubject = pGetEmailInfoResults.strSubject & pGetEmailInfoResults.intEmailID>
		<cfset eto = PGETMEMBERINFO_RESULT.strFullName  & '<' & PGETMEMBERINFO_RESULT.strEmail & '>'>

		<CFSAVECONTENT variable="EmailContent">
			<CFOUTPUT>

			 #REPLACE(
            	REPLACE(
					REPLACE(
						REPLACE(
							REPLACE(
							pGetEmailInfoResults.strContent,'$$MEMBERNAME$$',PGETMEMBERINFO_RESULT.strFirstname,"All" )
						,"$$MEMBEREMAIL$$",pGetmemberinfo_result.strEmail,"ALL" )
					,"$$MEMBERPASSWORD$$",ResetPasswordresults,"All" )
				,"$$MEMBERUSERNAME$$",pGetmemberinfo_result.strusername,"all" )
			,"$$SITEURL$$",cgi.server_name,"All")
			#
			</CFOUTPUT>
		</CFSAVECONTENT>

		<CFIF ResetPasswordResults NEQ "-1">
		<CFINVOKE component="cfc.SendEmailAPI" method="SendEmail" returnVariable="SendEmail_results">
			<cfinvokeargument name="SendFROM" value="#efrom#">
			<cfinvokeargument name="SendTO" value="#eto#">
			<cfinvokeargument name="SendSUBJECT" value="#eSubject#">
			<cfinvokeargument name="SendCONTENT" value="#EmailContent#">
		</CFINVOKE>
			<CFSET retvar  = 2>
		<CFELSE>
			<CFSET retvar  = -2>
		</CFIF>
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -1>
			<CFINCLUDE template="/error/cfcatch.cfm">

		</CFCATCH>
	</CFTRY>
	<cfreturn retvar>
</cffunction>
<cffunction name="SendEmail" returntype="string" output="yes" access="remote">
	<cfargument name="SendFROM" type="string" required="yes">
	<cfargument name="SendTO" type="string" required="yes">
	<cfargument name="SendSUBJECT" type="string" required="no">
	<cfargument name="SendCONTENT" type="string" required="yes">
	<CFSET retvar  = 0>
	<CFTRY>
		<CFMAIL to="#SendTO#" from="#SendFROM#" subject="#SendSUBJECT#" type="html">#SendCONTENT#</CFMAIL>
		<CFCATCH>
			<!---<cfoutput>#cfcatch.message#</cfoutput>--->

			<CFSET retvar  = -1>
			<CFINCLUDE template="/common/error/cfcatch.cfm">
			<!---<cfabort>--->
		</CFCATCH>
	</CFTRY>
	<cfreturn retvar>
</cffunction>
</cfcomponent>