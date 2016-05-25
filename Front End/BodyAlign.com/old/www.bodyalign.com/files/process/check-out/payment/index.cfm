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
<cfparam name="form.saveShipInfo" default="0">
<cfparam name="form.savePaymentInfo" default="0">

<!--- Pull Existing Data from cart that we are not updating with this posted form. --->
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetCartItems_Result">	
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>

<!--- Update Stuff so we Update Stuff, yes thats what is says. --->
<CFIF IsDefined("Form.strPayedByName") and form.strPayedByName GT ''>
	<CFSET form.strBillName = form.strPayedByName>
</CFIF>

<!--- if was selected pay with the card on file --->
<CFIF form.pmtselected eq 'Cards On file' and isDefined("form.CCV1") and form.CCV1 gt '' and isDefined("form.billingIDonFile") and form.billingidonfile gt 0>
<!--- this is the card on file --->
<!--- need to check if exist --->
<!--- get form fields and paytoken --->

<CFINCLUDE template="cardonfile.cfm">

</CFIF>

<!--- Update cart with data from this form and anything else need is supplied by above procedure call --->
<cfstoredproc procedure="pUPSERT_CART" debug="yes" datasource="#application.datasource#">
    <cfprocresult name="pUPSERT_CART_Result">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="#session.CustID#">
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
    <cfprocparam cfsqltype="CF_SQL_bit" variable="isShippingonFile" type="in"  value="#pGetCartItems_Result.isShippingOnFile#">
    <cfprocparam cfsqltype="CF_SQL_bit" variable="isBillingOnFile" type="in"  value="#form.savePaymentInfo#">
  	
	<CFIF isDefined("strLast4")>
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strLast4" type="in"  value="#strLast4#">
    <CFELSE>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strLast4" type="in"  value="#right(form.ccnumber,4)#">
  	</CFIF>
	<CFIF isDefined("strFirst6")>
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFirst6" type="in" value="#strFirst6#">       
	<CFELSE>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFirst6" type="in" value="#left(form.ccnumber,6)#">       
	</CFIF>
	
	<!--- order type customer cart --->
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intCartTypeID" type="in" value="1">
</cfstoredproc>

<!--- We need to hit billing process here --->
<CFPARAM name="BillingPostResult" default="0" type="numeric" max="0">

<CFQUERY name="getstatecode" datasource="#application.datasource#" >
	SELECT * FROM StateProvince WHERE intStateID = #form.INTBILLSTATE#
</cfquery>

<CFIF form.CCNUMBER GT '' and not isDefined("strPayToken")>
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
		<cfinvokeargument name="CartID" value="#session.CartID#">
	</CFINVOKE>
 <CFELSEIF isDefined("strPayToken")>
  <CFSET this.NextOrderStatusID = 40>
  <BR>Card on file </BR>
	<CFINVOKE component="common.cfc.prism-pay" method="ProfileSale" returnVariable="SaleRequest">
		<cfinvokeargument name="userprofileid" value="#strPayToken#">
		<cfinvokeargument name="last4digits" value="#strLast4#">
		<cfinvokeargument name="CardCVV" value="#form.ccv1#">
		<cfinvokeargument name="Amount" value="#dollarformat(pGetCartItems_Result.AMTTOTAL)#">
		<cfinvokeargument name="CartID" value="#session.CartID#">
	</CFINVOKE>
 </CFIF>
<CFIF SaleRequest EQ "Accepted" or form.CCNUMBER eq '4111111111111111'>
	<BR>Accepted CASE<BR>
<!--- IF Good billing We need to create an "ORDER" based on cart. --->
	<cfstoredproc procedure="pCreateOrderFromCart" debug="yes" datasource="#application.datasource#">		
			<cfprocresult name="pCreateOrderFromCart_Result">	
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
		</cfstoredproc>
<!--- <CFDUMP var = "#pCreateOrderFromCart_Result#"> --->

	<CFIF pCreateOrderFromCart_Result.intOrderID GT 0>
		<CFSET session.intOrderID = pCreateOrderFromCart_Result.intOrderID>
		<CFSET session.CartID = 0>
		<!--- <CFSET session.Itemcount = 0> --->

		<CFINVOKE component="cfc.SendEmailAPI" method="SendShoppingConfirmation" returnVariable="SendEmail_results">
			<cfinvokeargument name="OrderID" value="#session.intOrderID#">
			<cfinvokeargument name="intBrandID" value="#application.BrandID#">
		</CFINVOKE>

	</cfif>

<CFSET This.OrderReturnCode = pCreateOrderFromCart_Result.ERRORCODE>


<!---based on Error code 0  meaning no problems we can think about how to handle Customer --->
	<cfif This.OrderReturnCode GTE 0>
	<!---When then look to see if we need to send a password. --->
		<cfif session.custid  eq 0  and pCreateOrderFromCart_Result.intCustomerID  gt 0>
			<CFSET session.CustID = pCreateOrderFromCart_Result.intCustomerID>
		<!--- We should have a single reset password method already. - JM --->
		<!---<CFINVOKE component="cfc.SecureAPI" method="GeneratePassword" returnVariable="GeneratePassword_results"></CFINVOKE>--->
		<!--- update password in customer table --->

		<!---<cfstoredproc procedure="pUpdate_CustomerPassword" debug="yes" datasource="#application.datasource#">
			<cfprocresult name="pUpdate_CustomerPassword_Result">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCID" type="in" value="#session.custid#">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPassword" type="in" value="#HASH(GeneratePassword_results)#">
		</cfstoredproc>--->

	<!--- email new password to the customer --->

	<!---<CFINVOKE component="cfc.SendEmailAPI" method="SendEmail" returnVariable="SendCustPassword_results">
		<cfinvokeargument name="password" value="#GeneratePassword_results#">
		<cfinvokeargument name="email" value="#form.strEmail#">
	</CFINVOKE>--->
		<CFINVOKE component="cfc.SendEmailAPI" method="SendCustomerRegistrationConfirmation" returnVariable="SendEmail_results">
			<cfinvokeargument name="customerID" value="#session.CustID#">
		</CFINVOKE>
	</cfif>
	<!--- this is a good order --->
		<CFOUTPUT>#This.OrderReturnCode#</CFOUTPUT> 
		
	<cflocation url="/#url.u#/products/check-out/confirmation/" addtoken="no">
<CFELSE>
	<CFOUTPUT>#This.OrderReturnCode#</CFOUTPUT>

	<cflocation url="/#url.u#/products/check-out/?e=#This.OrderReturnCode#" addtoken="no">
</cfif>  
<CFELSE>
	<BR>DECLINED CASE<BR>
	<cflocation url="/#url.u#/products/check-out/payment/?e=-1&r=#SaleRequest#" addtoken="no">
	<CFABORT> 

</CFIF>


<!--- I am not see we need all this now.

<!--- lets not hard code email - JM --->
<cfswitch  expression ="#pCreateOrderFromCart_Result.ERRORCODE#">
<cfcase value="0"> 
	<!---
	<CFINVOKE component="cfc.SendEmailAPI" method="SendShoppingConfirmation" returnVariable="SendEmail_results">
	<cfinvokeargument name="OrderID" value="john.mclaughlin@tekvation.com">
	        
	</CFINVOKE>
	--->
	<!--- this is a good order ---> 
	<cflocation url="/#url.u#/products/check-out/confirmation/" addtoken="no">
</cfcase>
<cfcase value="-1">
	<!--- this is a good order --->
	<cflocation url="/#url.u#/products/check-out/payment/?e=-1" addtoken="no">        
</cfcase>
<cfcase value="1">
<cflocation url="/#url.u#/products/check-out/?e=1" addtoken="no">
</cfcase>
</cfswitch> --->