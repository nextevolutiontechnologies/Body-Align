<CFIF not isdefined("session.eOrderID")>
<cfstoredproc procedure="pCreateOrderFromCart" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pCreateOrderFromCart_Result">	
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
</cfstoredproc>


<cfstoredproc procedure="pCreateMemberFromCart" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pCreateMemberFromCart_Result">	
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intOrderID" type="in" value="#pCreateOrderFromCart_Result.intOrderID#">
</cfstoredproc>


<CFIF pCreateMemberFromCart_Result.intMemberID gt 0>
   <CFINVOKE component="cfc.SendEmailAPI" method="SendRegistrationConfirmation" returnVariable="SendCustPassword_results">
          <cfinvokeargument name="intMemberID" value="#pCreateMemberFromCart_Result.intMemberID#">
	</CFINVOKE>
</CFIF>


	<CFSET session.eOrderID=pCreateOrderFromCart_Result.intOrderID>
</CFIF>
<CFLOCATION url="/#url.u#/theopportunity/confirmation/" addToken="no">


