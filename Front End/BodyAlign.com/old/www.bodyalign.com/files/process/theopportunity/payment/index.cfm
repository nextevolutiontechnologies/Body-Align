<!--- 
the Payment page will post to this process and handle the following 

1. Update cart with information from this page.
2. Execute payment with collected information
3. If Good Payment Create Order from Cart Set OrderID in Session.
4. Clear CartID and Item count from session.
5. If New Customer and the customer selects to keep address/shipping on file...  Send New customer Email with generated password.
6. Send Order Confirmation Email

Other Things to handle...

If we start another cart we need to clear the OrderID from session.

Only if the customer chooses to save address/billing should we treat them as a returning customer and auto login.

--->
<!--- Set Checkbox values defaulted to 0 --->
<cfsetting requestTimeOut = "300">
<cfparam name="form.saveShipInfo" default="0">
<cfparam name="form.savePaymentInfo" default="0">
<cfparam name="session.ecartID" default="0" type="numeric" >
<!--- Pull Existing Data from cart that we are not updating with this posted form. --->
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetCartItems_Result">	
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
</cfstoredproc>

<!--- Update cart with data from this form and anything else need is supplied by above procedure call --->
<cfstoredproc procedure="pUPSERT_CART" debug="yes" datasource="#application.datasource#">
    <cfprocresult name="pUPSERT_CART_Result">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="0">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartFirstName" type="in" value="#pGetCartItems_Result.STRCARTFIRSTNAME#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartLastName" type="in" value="#pGetCartItems_Result.STRCARTLASTNAME#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartAddress" type="in" value="#pGetCartItems_Result.STRCARTADDRESS#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartAddress2" type="in" value="#pGetCartItems_Result.STRCARTADDRESS2#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartCity" type="in" value="#pGetCartItems_Result.STRCARTCITY#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartStateID" type="in" value="#pGetCartItems_Result.INTCARTSTATEID#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartZip" type="in" value="#pGetCartItems_Result.STRCARTZIP#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strNameOnCard" type="in" value="#form.STRBILLNAME#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strExp" type="in" value="#form.strExpMonth#/#form.strExpYear#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingAddress" type="in" value="#form.STRBILLSTREET#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingCity" type="in" value="#form.STRBILLCITY#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBillingStateID" type="in" value="#form.INTBILLSTATE#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingZip" type="in" value="#form.STRBILLZIPCODE#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartXip" type="in" value="#cgi.REMOTE_ADDR#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strEmail" type="in" value="#form.strEmail#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPhone" type="in" value="#pGetCartItems_Result.strPhone#">
    <cfprocparam cfsqltype="CF_SQL_bit" variable="isShippingonFile" type="in"  value="#form.savePaymentInfo#">
    <cfprocparam cfsqltype="CF_SQL_bit" variable="isBillingOnFile" type="in"  value="#form.savePaymentInfo#">
  	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strLast4" type="in"  value="#right(form.ccnumber,4)#">
  	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFirst6" type="in" value="#left(form.ccnumber,6)#">       
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtDiscountRate" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtTaxRate" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtDiscount" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtShipping" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtTax" type="in" value="0">
	<!--- order type customer cart --->
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intCartTypeID" type="in" value="1">
</cfstoredproc>

<!--- We need to hit billing process here --->
<CFPARAM name="BillingPostResult" default="0" type="numeric" max="0">
<!--- HACK FOR NOW --->
<CFQUERY name="getstatecode" datasource="#application.datasource#" >
	SELECT * FROM StateProvince WHERE intStateID = #form.INTBILLSTATE#
</cfquery>

<CFSET this.NextOrderStatusID = 40>
<BR>Credit Card Payment CASE<BR>
<CFINVOKE component="common.cfc.prism-pay" method="PayTokenRequest" returnVariable="SaleRequest">
	<cfinvokeargument name="action" value="profile_add">
	<cfinvokeargument name="CardNum" value="#form.CCNUMBER#">
	<cfinvokeargument name="CardExpMonth" value="#form.strExpMonth#">
	<cfinvokeargument name="CardExpYear" value="#form.strExpYear#">
	<cfinvokeargument name="CardCVV" value="#form.ccv#">
	<cfinvokeargument name="CardName" value="#form.STRBILLNAME#">
	<cfinvokeargument name="CardBillAddr1" value="#form.STRBILLSTREET#">
	<cfinvokeargument name="CardBillAddr2" value="">
	<cfinvokeargument name="CardBillCity" value="#form.STRBILLCITY#">
	<cfinvokeargument name="CardBillState" value="#getstatecode.strStateCode#">
	<cfinvokeargument name="CardBillzip" value="#form.STRBILLZIPCODE#">
	<cfinvokeargument name="Amount" value="#dollarformat(pGetCartItems_Result.AMTTOTAL)#">
	<cfinvokeargument name="CartID" value="#session.eCartID#">
</CFINVOKE>
<CFIF SaleRequest EQ "Accepted">
<!--- IF Good billing We need to create an "MEMBER" based on cart. --->
<cfstoredproc procedure="pCreateMemberFromCart" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pCreateMemberFromCart_Result">	
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intChangeMemberID" type="in" value="0">
	<!--- type - affiliate --->
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberTypeID" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" value="#application.BrandID#">
</cfstoredproc>
<!--- IF We create Order after member then order is attached to new member. --->
<cfstoredproc procedure="pCreateOrderFromCart" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pCreateOrderFromCart_Result">	
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
</cfstoredproc>

	<CFIF pCreateOrderFromCart_Result.intOrderID GT 0>
		<CFSET session.MemberID = pCreateMemberFromCart_Result.intMemberID>
		<CFSET session.eCartID = 0>
		<CFSET session.Itemcount = 0>
		<CFSET Session.eOrderID = pCreateOrderFromCart_Result.intOrderID>
		<CFINVOKE component="common.cfc.SendEmailAPI" method="SendEnrollmentConfirmation" returnVariable="SendEmail_results">
			<cfinvokeargument name="OrderID" value="#session.eOrderID#">
			<cfinvokeargument name="MemberID" value="#session.MemberID#">
			<cfinvokeargument name="intBrandID" value="#application.BrandID#">
		</CFINVOKE>
		<!--- send email to the sponsor --->
			<CFINVOKE component="global.cfc.SendEmailAPI" method="SendNotificationToEnroller" returnVariable="SendEmail_results">
				<cfinvokeargument name="MemberID" value="#session.MemberID#">
				<cfinvokeargument name="BrandID" value="#application.BrandID#">
			</CFINVOKE>
	
	</cfif>


<CFSET This.OrderReturnCode = pCreateOrderFromCart_Result.ERRORCODE>

<!---based on Error code 0  meaning no problems we can think about how to handle Customer --->
	<cfif This.OrderReturnCode GTE 0>
	<CFQUERY name="GetNewMemberUsername" datasource="#Application.Datasource#" >
		SELECT strUsername FROM dbo.Member WHERE intMemberID = #session.MemberID#
	</CFQUERY>
		<cflocation url="/#GetNewMemberUsername.strUsername#/theopportunity/confirmation/" addtoken="no">
	<CFELSE>
		<cflocation url="/#url.u#/theopportunity/payment/?e=#This.OrderReturnCode#" addtoken="no">
	</cfif>
<CFELSE>
	<cflocation url="/#url.u#/theopportunity/payment/?e=-1&r=#SaleRequest#" addtoken="no">
	<CFABORT>
</CFIF> 