<!--- This file is for starting and Enrollment cart --->
<CFPARAM name="url.pid" default="0">
<CFPARAM name="session.eCartID" default="0">

<CFIF isDefined("form.pid")>
	<cfset url.pid=form.pid>
</cfif>
<!--- check if complanid exists and numeric, if not send back --->
<CFIF url.pid eq 0 or not IsNumeric(url.pid)>
	<CFLOCATION url="/#url.u#/theopportunity/" addToken="no">
	<CFABORT>
</CFIF>
<cfstoredproc procedure="dbo.pREMOVE_CART_ALL" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pREMOVE_CART_ALL_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">	
</cfstoredproc>	

	<!--- check if product exist --->
	<cfstoredproc procedure="dbo.pGetProductInfo" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pGetProductInfo_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#url.pid#">	
	</cfstoredproc>
	
	<CFIF pGetProductInfo_Result.RecordCount eq 0>
		<CFLOCATION url="/#url.u#/theopportunity/" addToken="no"><CFABORT>
	</CFIF>
	
	<cfstoredproc procedure="pAddtoCart" debug="yes" datasource="#application.datasource#">		
			<cfprocresult name="pAddtoCart_Result">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="0">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#pGetProductInfo_Result.intProductID#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="Quantity" type="in" value="1">
			<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtUnit" type="in" value="#pGetProductInfo_Result.amtRetail#" scale="2">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="Update">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="priceType" type="in" value="override">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" value="#pGetProductInfo_Result.strProduct#">
			<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscountRate" type="in" value="0" scale="2">
		    <cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscount" type="in" value="0" scale="2">
		    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartTypeID" type="in" value="2">
	</cfstoredproc>
	<cfif isDefined("form.ShipFlatRate") and form.ShipFlatRate GT 0>
	<CFQUERY name="InsertShipFlatRate" datasource="#application.datasource#" > 
		UPDATE dbo.xCart
		SET amtShipping = #form.ShipFlatRate#,intShipMethodID = 6
		WHERE intCartID = #session.eCartID#
	</cfQUERY>
	<cfstoredproc procedure="dbo.pUpdate_CartTotal" debug="yes" datasource="#application.datasource#">
    	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
    </cfstoredproc>
	</cfif>
<CFSET session.eCartID=pAddtoCart_Result.intCartID>
<CFIF isDefined("form.intselectedproducts")>
<cfloop index = "pidSelectedElement" list = "#form.intselectedproducts#"> 
	<CFOUTPUT>#pidSelectedElement# </CFOUTPUT>
	<!--- check if product exist --->
	<cfstoredproc procedure="dbo.pGetProductInfo" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pGetProductInfo_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#pidSelectedElement#">	
	</cfstoredproc>
	
	<CFIF pGetProductInfo_Result.RecordCount eq 0>
		<CFLOCATION url="/#url.u#/theopportunity/" addToken="no"><CFABORT>
	</CFIF>
	
	<cfstoredproc procedure="pAddtoCart" debug="yes" datasource="#application.datasource#">		
			<cfprocresult name="pAddtoCart_Result">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="0">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#pidSelectedElement#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="Quantity" type="in" value="1">
			<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtUnit" type="in" value="0" scale="2">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="Add">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="priceType" type="in" value="override">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" value="#pGetProductInfo_Result.strProduct#">
			<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscountRate" type="in" value="0" scale="2">
		    <cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscount" type="in" value="0" scale="2">
		    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartTypeID" type="in" value="2">
	</cfstoredproc>
	<CFIF session.eCartID eq 0>
		<CFSET session.eCartID=pAddtoCart_Result.intCartID>
	</CFIF>
</cfloop>
</CFIF>

<cfstoredproc procedure="dbo.pGetCartItems" debug="yes" datasource="#application.datasource#">		
<cfprocresult name="pGetCartItems_Result">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">	
</cfstoredproc>	



<CFLOCATION url="/#url.u#/theopportunity/information/" addToken="no">
<CFABORT>