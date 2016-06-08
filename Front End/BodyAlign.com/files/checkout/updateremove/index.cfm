<CFPARAM name="session.CartID" default="0">
<cfparam name="this.ShipMethodID" default="7" >

<cfif form.PCS lt 1 or form.PCS eq ''><cfset form.PCS=1></cfif>

<CFIF isdefined("form.Update")>
<CFPARAM name="this.ItemDiscount" default="0" max=".5" type="numeric" >
  <cfstoredproc procedure="pAddToCart" debug="yes" datasource="#application.datasource#">
    <cfprocresult name="pAddtoCart_Result">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intMemberID" type="in" value="#session.MemberID#">
	 <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="0">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#form.intProductID#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="Quantity" type="in" value="#form.pcs#">
    <cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtUnit" type="in" null="yes">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="update">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="priceType" type="in" value="Retail">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscountRate" type="in" value="#this.ItemDiscount#" scale="2">
  	<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscount" type="in" value="0" scale="2">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartTypeID" type="in" value="1">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intGroupProductID" type="in" value="#form.intProductID#">
  </cfstoredproc>

</CFIF>

<CFIF isdefined("form.Remove")>
	<cfstoredproc procedure="pRemove_Cart_Detail_NEW" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pRemove_Cart_Detail_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#form.intProductID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intPromotionID" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intPromotionRuleID" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartDetailID" type="in" value="#form.intCartDetailID#">
	</cfstoredproc>

	

</CFIF>
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetCartItems_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>
<cfset session.ItemCount = "#pGetCartItems_Result.itemcount#">
<!--- START: Shipping Mess --->
<!--- if zipcode exist calculate shipping charges --->
<!--- calculate shipping for all order types except event ticket --->
<CFIF pGetCartItems_Result.strCartZip gt ''>
	<cfstoredproc procedure="dbo.pUpdate_CartShipAmount" debug="yes" datasource="#application.datasource#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	<!--- if we send null then Procedure will Get Shipping Rate --->
		<cfprocparam cfsqltype="CF_SQL_decimal" variable="ShipRate" type="in" null="true" >
		<cfprocparam cfsqltype="CF_SQL_int" variable="intShipMethodID" type="in" value="#this.ShipMethodID#" >
	</cfstoredproc>
<!--- Update Cart Total --->
	<cfstoredproc procedure="dbo.pUpdate_CartTotal" debug="yes" datasource="#application.datasource#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	</cfstoredproc>
</CFIF>
<CFLOCATION url="/#url.u#/checkout/?e=1&qu=1" addToken="no">