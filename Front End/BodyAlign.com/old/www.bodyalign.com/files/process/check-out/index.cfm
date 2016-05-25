<!---
<CFPARAM name="intCID" default="0">
<CFPARAM name="session.CustID" default="0">
 
<CFIF session.CustID eq 0>
	<CFINVOKE component="cfc.SecureAPI" method="GeneratePassword" returnVariable="GeneratePassword_results"></CFINVOKE>
</CFIF>
<cfstoredproc procedure="pUPSERT_CUSTOMER" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pUPSERT_CUSTOMER_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCID" type="in" value="#session.CustID#">	
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFirstName" type="in" value="#form.strFirstName#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strLastNam" type="in" value="#form.strLastName#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strAddress1" type="in" value="#form.strAddress1#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strAddress2" type="in" value="#form.strAddress2#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCity" type="in" value="#form.strCity#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intStateID" type="in" value="#form.intStateID#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strZipCode" type="in" value="#form.strZipCode#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPhone" type="in" value="#form.strPhone#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strEmail" type="in" value="#form.strEmail#">	
		
	<CFIF session.CustID eq 0>
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPassword" type="in" value="#HASH(GeneratePassword_results)#">
	</CFIF>
</cfstoredproc>

<CFIF session.CustID eq 0>
<CFINVOKE component="cfc.SendEmailAPI" method="SendCustPassword" returnVariable="SendCustPassword_results">
	<cfinvokeargument name="password" value="#GeneratePassword_results#">
	<cfinvokeargument name="email" value="#form.strEmail#">
</CFINVOKE>
</CFIF>
 
  <cfstoredproc procedure="pCreateOrderFromCart" debug="yes" datasource="#application.datasource#">
    <cfprocresult name="pUPSERT_CUSTOMER_Result">
      <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">        
   </cfstoredproc>
    
 
<!---
      <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCCExp" type="in" value="#form.strCCExp#">
        <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillName" type="in" value="#form.strBillName#">
          <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillStreet" type="in" value="#form.strBillAddress#">
            <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillCity" type="in" value="#form.strBillCity#">
              <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBillState" type="in" value="#form.intBillState#">
                <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillZipCode" type="in" value="#form.strBillZipCode#">
      ---> 
  
<CFIF pUPSERT_CUSTOMER_Result.intCID gt 0>
	<CFSET session.CustID=pUPSERT_CUSTOMER_Result.intCID>
	<CFLOCATION url="confirmation/" addToken="no">
<CFELSE>
 	<CFLOCATION url="/#url.u#/checkout/?E=1" addToken="no">
</CFIF>

--->