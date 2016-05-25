<cfcomponent output="no"  hint="This list of methods will be used for Platinum Service">
	<cfset This.apikey="M4I9JgESMnqyE4p5SfkbJBEtTKKTHmQc7KlMctBX2WjG10DVGh">
	<cfset This.SharedSec="VAiKlGT1pPkmFtTjyRMqrg==">
	<cfset This.PostURL="https://api.leisureloyalty.com/v3/members">
	<cfset This.SiteID="56">
	<cfset This.datasource='dev_paycation'>
<!---<cftry>
	<!--- we need to get Tier by brand? --->
 	<cfquery name="GetBrandInfo">
		SELECT TOP (1) strMerchantCode
		FROM  BRANDING 
		WHERE intBrandID = #Application.BrandID#
	</cfquery>
	
	
	<cfif GetBrandInfo.strMerchantCode NEQ ''>
		<cfset This.subid= GetBrandInfo.strMerchantCode>
	</cfif>
<cfcatch>
	<cfset This.subid="PWRVD">
</cfcatch>
</cftry>--->
<cffunction name="GetMemberList" returntype="string" output="no" access="remote" description="Make Payment" hint="Makes Payment pass in CC on file ">
	<cfhttp method="get" url="#this.PostURL#?apiKey=#this.apikey#" >
	</cfhttp>
 		<CFSET retvar = cfhttp.filecontent>
		<CFTRY><CFCATCH>
			<CFSET retvar  = -1>
		</CFCATCH>
	</CFTRY>
	<cfreturn retvar>
</cffunction>
<cffunction name="CreateMember" returntype="string" output="no" access="remote" description="Make Payment" hint="Makes Payment pass in CC on file ">
	<cfargument name="intMemberID" type="numeric" Required="yes">
	<cfargument name="tierID" type="numeric" default="129" required="no">
	
	<cfquery name="GetMember">
		SELECT intMemberID,strFirstName,strLastname,strEmail,strRepID FROM dbo.MEMBER with (nolock) WHERE intMemberID = #arguments.intMemberID#
	</cfquery>
	<cfif GetMember.recordcount eq 1>
		<cfsavecontent variable="CreateMembers"><cfoutput>[{ firstName: "#GetMember.strFirstName#", lastName: "#GetMember.strLastname#", email: "#GetMember.strEmail#",  memberId: "PVM#GetMember.intMemberID#", mtierId: "#arguments.tierID#" }]</cfoutput></cfsavecontent>
		<cfhttp result="DynamicPostResults" method="POST" url="#this.PostURL#?apiKey=#this.apikey#"> 
			<cfhttpparam type="HEADER" name="content-type" value="application/json;charset=UTF-8">
			<cfhttpparam type="body" value="#CreateMembers#">
		</cfhttp>
 		<CFSET retvar = DynamicPostResults.filecontent>
	<cfelse>
		<CFSET retvar  = -1>
	</cfif>
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -666>
		</CFCATCH>
	</CFTRY>
	
	<cfreturn retvar>
</cffunction>
<cffunction name="CreateCustomer" returntype="string" output="no" access="remote" description="Make Payment" hint="Get Customer Record and Pass data to API">
	<cfargument name="intCustomerID" type="numeric" Required="yes">
	<cfargument name="tierID" type="numeric" default="132" required="no">
	
	<cfquery name="GetCustomer">
		SELECT intCustomerID,strFirstName,strLastname,strEmail FROM dbo.CUSTOMER with (nolock) WHERE intCustomerID = #arguments.intCustomerID#
	</cfquery>
	<cfif GetCustomer.recordcount eq 1>
		<cfsavecontent variable="CreateMembers"><cfoutput>[{ firstName: "#GetCustomer.strFirstName#", lastName: "#GetCustomer.strLastname#", email: "#GetCustomer.strEmail#",  memberId: "PVC#GetCustomer.intCustomerID#", mtierId: "#arguments.tierID#" }]</cfoutput></cfsavecontent>
		<cfhttp result="DynamicPostResults" method="POST" url="#this.PostURL#?apiKey=#this.apikey#"> 
			<cfhttpparam type="HEADER" name="content-type" value="application/json;charset=UTF-8">
			<cfhttpparam type="body" value="#CreateMembers#">
		</cfhttp>
		
 		<CFSET retvar = DynamicPostResults.filecontent>
		
	<cfelse>
		<CFSET retvar  = -1>
	</cfif>
	
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -666>
		</CFCATCH>
	</CFTRY>
	
	<cfreturn retvar>
</cffunction>
<cffunction name="UpdateMember" returntype="string" output="no" access="remote" description="Make Payment" hint="Makes Payment pass in CC on file ">
	<cfargument name="intMemberID" type="numeric" Required="yes">
	
	<cfquery name="GetMember">
		SELECT intMemberID,strFirstName,strLastname,strEmail FROM dbo.MEMBER with (nolock) WHERE intMemberID = #arguments.intMemberID#
	</cfquery>
	<cfif GetMember.recordcount eq 1>
		<cfsavecontent variable="CreateMembers"><cfoutput>{ firstName: "#GetMember.strFirstName#", lastName: "#GetMember.strLastname#", email: "#GetMember.strEmail#"}</cfoutput></cfsavecontent>
		<cfhttp result="DynamicPostResults" method="PUT" url="#this.PostURL#/#arguments.intMemberID#?apiKey=#this.apikey#">  
			<cfhttpparam type="HEADER" name="content-type" value="application/json;charset=UTF-8">
			<cfhttpparam type="body" value="#CreateMembers#">
		</cfhttp>
 		<CFSET retvar = DynamicPostResults.filecontent>
	<cfelse>
		<CFSET retvar  = -1>
	</cfif>
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -666>
		</CFCATCH>
	</CFTRY>
	
	<cfreturn retvar>
</cffunction>

<cffunction name="ConvertCustomerToAgent" returntype="string" output="no" access="remote" description="Make Payment" hint="Get Customer Record and Pass data to API">
	<cfargument name="intCustomerID" type="string" Required="yes">
	<cfargument name="newMemberID" type="string" Required="yes">
	<cfquery name="GetCustomer">
		SELECT intCustomerID,strFirstName,strLastname,strEmail,strMemberRepID FROM dbo.CUSTOMER with (nolock) WHERE intCustomerID = #arguments.intCustomerID#
	</cfquery>
	<cfif GetCustomer.recordcount eq 1>
		<cfsavecontent variable="UpdateTier"><cfoutput> {mtierId: "129" }</cfoutput></cfsavecontent>
		<cfhttp result="DynamicPostResults" method="PUT" url="#this.PostURL#/changeTier/#GetCustomer.intCustomerID#?apiKey=#this.apikey#"> 
			<cfhttpparam type="HEADER" name="content-type" value="application/json;charset=UTF-8">
			<cfhttpparam type="body" value="#UpdateTier#">
		</cfhttp>
		
		<cfsavecontent variable="UpdateMember"><cfoutput>{memberId: "#GetCustomer.strMemberRepID#" }</cfoutput></cfsavecontent>
		<cfhttp result="DynamicPostResults" method="PUT" url="#this.PostURL#/#arguments.intCustomerID#?apiKey=#this.apikey#"> 
			<cfhttpparam type="HEADER" name="content-type" value="application/json;charset=UTF-8">
			<cfhttpparam type="body" value="#UpdateMember#">
		</cfhttp>
		<CFSET retvar = DynamicPostResults.filecontent>
		
	<cfelse>
		<CFSET retvar  = -1>
	</cfif>
	
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -666>
		</CFCATCH>
	</CFTRY>
	
	<cfreturn retvar>
</cffunction>

<cffunction name="GetAutoLoginData" >
	<cfargument name="intMemberID" type="numeric" Required="yes">
	<cfquery name="GetMember">
		SELECT intMemberID,strFirstName,strLastname,strEmail,strRepID FROM dbo.MEMBER with (nolock) WHERE intMemberID = #arguments.intMemberID#
	</cfquery>
	<cfif GetMember.recordcount eq 1>
		<cfset dtNow = now() />
		
		
		<cfset Data= GetMember.strRepID & '|' & this.SiteID & '|' & dtNow.getTime()>
		<cfset DataEncrypted = encrypt(Data, this.SharedSec, "AES","base64" )  />
		<cfset DataEncryptedEncoded = URLEncodedFormat(DataEncrypted) />
 		<CFSET retvar = DataEncryptedEncoded>
		 
	<cfelse>
		<CFSET retvar  = -1>
	</cfif>

	<cfreturn retvar>
	
</cffunction>

<cffunction name="GetAutoLoginCustomerData" >
	<cfargument name="intCustomerID" type="numeric" Required="yes">
	<cfquery name="GetMember">
		SELECT intCustomerID FROM dbo.Customer with (nolock) WHERE intCustomerID = #arguments.intCustomerID#
	</cfquery>
	<cfif GetMember.recordcount eq 1>
		<cfset dtNow = now() />
		
		
		<cfset Data= GetMember.intCustomerID & '|' & this.SiteID & '|' & dtNow.getTime()>
		<cfset DataEncrypted = encrypt(Data, this.SharedSec, "AES","base64" )  />
		<cfset DataEncryptedEncoded = URLEncodedFormat(DataEncrypted) />
 		<CFSET retvar = DataEncryptedEncoded>
		 
	<cfelse>
		<CFSET retvar  = -1>
	</cfif>

	<cfreturn retvar>
	
</cffunction>
<cffunction name="GetAutoLoginEncryptedData" >
	<cfargument name="strToEncrypt" type="string" Required="yes">
		<cfset dtNow = now() />
		<cfset Data= arguments.strToEncrypt & '|' & this.SiteID & '|' & dtNow.getTime()>
		<cfset DataEncrypted = encrypt(Data, this.SharedSec, "AES","base64" )  />
		<cfset DataEncryptedEncoded = URLEncodedFormat(DataEncrypted) />
 		<CFSET retvar = DataEncryptedEncoded>
		<CFSET retvar  = -1>
	<cfreturn retvar>
</cffunction>

<cffunction name="GetMemberData" >
	<cfargument name="AgentID" type="string" Required="yes">
	<cfhttp result="DynamicPostResults" method="get" url="https://secure.paycation.com/webservice/agentdata?AgentID=#arguments.AgentID#">
		<cfhttpparam type="header" name="Content-Type" value="application/json; charset=utf-8" />
		<cfhttpparam type="header" name="UserName" value="Montbriar" />
		<cfhttpparam type="header" name="ApplicationKey" value="9B0F498A-6277-4583-B68D-3571D557CF67" />
		<cfhttpparam type="header" name="ClientID" value="#cgi.REMOTE_ADDR#" />
		<cfhttpparam type="body" value=''>
	</cfhttp>
	<cfreturn DynamicPostResults.filecontent>
</cffunction>

<cffunction name="IsCustomerAgent" returntype="boolean" output="true">
	<cfargument name="intCustomerID" type="numeric" Required="yes">
	<CFSET retvar=0>
	
	<!--- check if we need to change customer to agent --->
	<cfquery name="isRepNotExists" datasource="#application.datasource#">
		SELECT     c.intCustomerID,c.strMemberRepID,c.strEmail,c.strFirstName,c.strLastName
		FROM         CUSTOMER c with (nolock)LEFT OUTER JOIN
                      MEMBER m with (nolock) ON c.strMemberRepID = m.strRepID
		WHERE     (c.strCustomerUserName IS NULL) AND (c.IsActive = 1) AND (c.strMemberRepID IS NOT NULL) AND (m.strRepID IS NULL)
 		AND c.intCustomerID=#arguments.intCustomerID#
		ORDER BY c.intCustomerID DESC
	</cfquery>
	<cfif isRepNotExists.RecordCount gt 0 and isRepNotExists.strMemberRepID gt ''>
		<cfinvoke component="global.cfc.bls-travel" method="GetMemberData" returnvariable="GetAgentData_Result">
			<cfinvokeargument name="agentID" value="#isRepNotExists.strMemberRepID#" >
		</cfinvoke>
		
		<cfset GetAgentData_Result = deserializeJSON(GetAgentData_Result)>
			<!--- if rep exist set sessions --->
			<cfif isDefined("GetAgentData_Result.AgentData") and arrayLen(GetAgentData_Result.AgentData)>
			<CFOUTPUT>
				<cfloop collection="#GetAgentData_Result.AgentData[1]#" item="key">
					<CFSET "#ReplaceNoCase(key,' ','')#"=GetAgentData_Result.AgentData[1][key]>
				</cfloop> 
				<CFIF isDefined("AgentID") and AgentID eq isRepNotExists.strMemberRepID  and isDefined("Email") and Email eq isRepNotExists.strEmail>
					<CFSET retvar=1>
				</CFIF>
				
	 		</CFOUTPUT>
	 		</cfif>
	</cfif> 

<cfreturn retvar>
</cffunction>

<cffunction name="validateTheKey" output="yes">
	<cfargument name="strRepID" type="string" Required="yes">
	<cfargument name="keyValue" type="string" Required="yes">
	
	<cfset retvar=0>
	<cfset dtNow = DateTimeFormat(Now(),'mm/dd/yyyy h:mm:ss TT') />
	<cfset KeytoString = ToString( ToBinary( URLdecode(keyValue) )) />
	<CFIF KeytoString gt '' and listlen(KeytoString, "|") gte 2>
		<cfset KeyStringRepID = ListGetAt(Keytostring,2,"|") />
		<CFSET origDate=DateAdd("h", -1, Now())>
		
		<!---<CFOUTPUT>#DateDiff("n", ListGetAt(Keytostring,1,"|"), origDate)# #origDate# #ListGetAt(Keytostring,1,"|")#</CFOUTPUT><CFABORT>--->
	</CFIF>

	<!---<cfif IsDefined("KeyStringRepID") and Trim(arguments.strRepID) eq Trim(KeyStringRepID) and DateDiff("h", ListGetAt(Keytostring,1,"|"), origDate) lte 3>--->
	<cfif IsDefined("KeyStringRepID") and Trim(arguments.strRepID) eq Trim(KeyStringRepID) and DateDiff("n", ListGetAt(Keytostring,1,"|"), origDate) lte 10>
			<cfset retvar=1>
			
	</cfif>
		<CFTRY>
			<cfquery name="insert" datasource="#application.datasource#">
				INSERT INTO [dbo].[KeyValues]
           		([strRepID]
           		
           		,[strDateTIme]
           		,[IsKeyValid])
     			VALUES
           		('#Trim(KeyStringRepID)#'
           		
           		,'#ListGetAt(Keytostring,1,"|")#'
           		,'#retvar#')	
			</cfquery>
			<CFCATCH></CFCATCH>
		</CFTRY>
	<cfreturn retvar>
	
</cffunction>

<cffunction name="SuspendMember" returntype="string" output="no" access="remote" description="Make Payment" hint="Makes Payment pass in CC on file ">
	<cfargument name="intMemberID" type="numeric" Required="yes">
	
	<cfquery name="GetMember">
		SELECT intMemberID,strFirstName,strLastname,strEmail,strRepID FROM dbo.MEMBER with (nolock) WHERE intMemberID = #arguments.intMemberID#
	</cfquery>
	<cfif GetMember.recordcount eq 1>
		<cfsavecontent variable="CreateMembers"><cfoutput>[{}]</cfoutput></cfsavecontent>
		<cfhttp result="DynamicPostResults" method="PUT" url="https://api.leisureloyalty.com/v3/members/suspend/#GetMember.strRepID#?apiKey=#this.apiKey#"> 
			<cfhttpparam type="HEADER" name="content-type" value="application/json;charset=UTF-8">
			<cfhttpparam type="body" value="#CreateMembers#">
		</cfhttp>
 		<CFSET retvar = DynamicPostResults.filecontent>
	<cfelse>
		<CFSET retvar  = -1>
	</cfif>
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -666>
		</CFCATCH>
	</CFTRY>
	
	<cfreturn retvar>
</cffunction>
<cffunction name="ResumeMember" returntype="string" output="no" access="remote" description="Make Payment" hint="Makes Payment pass in CC on file ">
	<cfargument name="intMemberID" type="numeric" Required="yes">
	
	<cfquery name="GetMember">
		SELECT intMemberID,strFirstName,strLastname,strEmail,strRepID FROM dbo.MEMBER with (nolock) WHERE intMemberID = #arguments.intMemberID#
	</cfquery>
	<cfif GetMember.recordcount eq 1>
		<cfsavecontent variable="CreateMembers"><cfoutput>[{}]</cfoutput></cfsavecontent>
		<cfhttp result="DynamicPostResults" method="PUT" url="https://api.leisureloyalty.com/v3/members/resume/#GetMember.strRepID#?apiKey=#this.apiKey#"> 
			<cfhttpparam type="HEADER" name="content-type" value="application/json;charset=UTF-8">
			<cfhttpparam type="body" value="#CreateMembers#">
		</cfhttp>
 		<CFSET retvar = DynamicPostResults.filecontent>
	<cfelse>
		<CFSET retvar  = -1>
	</cfif>
	<CFTRY>	<CFCATCH>
			<CFSET retvar  = -666>
		</CFCATCH>
	</CFTRY>
	
	<cfreturn retvar>
</cffunction>

</cfcomponent>
















