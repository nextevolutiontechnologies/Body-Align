 <cfparam name="form.SELECTCUSTOMERADDR" default=0>
   <cfstoredproc procedure="pGetCustomerAddressByCustomerAddressID" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="getCustomerShipping">	
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="#form.SELECTCUSTOMERADDR#">
	</cfstoredproc>
  <cfset data = '#serializeJSON(getCustomerShipping)#'>
  
  
<cfoutput>#data#</cfoutput>
     

  