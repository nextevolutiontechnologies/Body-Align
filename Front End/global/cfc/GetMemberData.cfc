<cfcomponent displayname="Get Member Data" hint="This allows acces to member data">
	 	
<cffunction name="GetMemberByStrMemberID" output="false" returntype="query" description="Returns intMemberID if Success, 0 - if user nto exist" access="remote">  
	<cfargument name="username" type="string" default="" required="no" displayname="user name" />
	<CFSET memberID_return = 0 >
	<CFTRY>
		<CFQUERY name="GetMemberData" datasource="#application.datasource#">
		SELECT        intMemberID,strFirstName,strLastname,strEmail
		FROM            MEMBER m with (nolock) INNER JOIN
       WHERE        strRepID =<cfqueryparam value="#arguments.username#" cfsqltype="CF_SQL_VARCHAR" >
		</CFQUERY>
		<CFIF GetMemberData.RecordCount gt 0>
			<CFSET memberID_return=checkUser>
		</CFIF>
		<CFCATCH>
		</CFCATCH>
	</CFTRY>
	
	<cfreturn memberID_return>
</cffunction>
</cfcomponent>