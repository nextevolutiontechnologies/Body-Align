<cfcomponent rest="true" restpath="/person">
	<cffunction
		name="GetAll"
		returntype="string"
access="remote" 
httpmethod="GET" 
produces="application/json"
				
				
				>
				<cfset var response = application['PersonGateway'].getall()/>
				<cfreturn serialialiseJson(response)>
		
	</cffunction>
	 
</cfcomponent>