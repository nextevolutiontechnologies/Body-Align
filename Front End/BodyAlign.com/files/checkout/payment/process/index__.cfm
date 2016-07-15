
<!---
the Payment page will post to this process and handle the following
1. Update cart with information from this page.
2. Use Billing as Shipping Address if not provided
3. Execute payment with collected information

--->
<!--- Set Checkbox values defaulted to 0 --->
<cfparam name="form.saveShipInfo" default="0">
<cfparam name="form.ISBILLINGONFILE" default="0">
<CFPARAM name="session.CartID" default="0" type="integer" >
<cfparam name="form.MemberID" default="0">
<cfparam name="SaleRequest" default="wrongpayment">
<cfparam name="form.STRBILLINGADDRESS" default="" >
<cfparam name="form.strCartAddress2" default="">
<cfparam name="form.STRFEDERALID" default="">
<CFPARAM name="session.AddInfoID" default="0">
<cfparam name="form.strBillingAddress" default="">
<cfparam name="form.intCartStateID" default="0">
<cfparam name="form.strCartZip" default="">
<cfparam name="form.strCartAddress1" default="">
<cfparam name="form.STRCARTCITY" default="">
<cfparam name="form.strPhone" default="">

<cfif isdefined("form.dupstrCartZip") and form.dupstrCartZip gt "">
	<cfset form.strCartZip=form.dupstrCartZip>
</cfif>

STRADDRESS1,STRADDRESS2,STRCITY,INTSTATEID,STRZIP1,CCNUMBER,STRBILLNAME,STREXPYEAR,STREXPMONTH,CCV,STRBILLSTREET,STRBILLCITY,INTSTATEID2,STRZIP2,STREMAIL
<!--- Pull Existing Data from cart that we are not updating with this posted form. --->
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetCartItems_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>

<!--- check to see if we have another address other than billing? --->
<cfif isdefined("form.strCartAddress1")>
	<cfif not isdefined("form.intBillingStateID") >
		<cfset form.intBillingStateID=form.intCartStateID>
	</cfif>
	<cfif not isdefined("form.strBillingZip") >
		<cfset form.strBillingZip=form.strCartZip>
	</cfif>
	<cfif not isdefined("form.strBillingAddress") >
		<cfset form.strBillingAddress=form.strCartAddress1>
	</cfif>
	<cfif not isdefined("form.strBillingCity") >
		<cfset form.strBillingCity=form.STRCARTCITY>
	</cfif>
</cfif>
<cfif pGetCartItems_Result.amtTotal eq 0>
<!---	Free Affiliate Signup--->
	<cfset form.STRBILLNAME=''>
	<cfset form.strExpMonth=''>
	<cfset form.strExpYear=''>
	<cfset form.strExpMonth=''>
	<cfset form.strExpYear=''>
	<cfset form.ccnumber=''>
	<cfset form.ccnumber=''>
</cfif>
<!---opportunity--->
<cfif pGetCartItems_Result.intCartTypeID eq 2>
	<cfstoredproc procedure="pCheckMemberDupSSN" debug="yes" datasource="#application.datasource#">
		<cfprocresult name="pCheckMemberDupSSN_Result">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strSSN" type="in" value="#form.strSSN#">
	</cfstoredproc>

	<!--- Check Username dup --->
	<cfstoredproc procedure="pCheckMemberDupUserName" debug="yes" datasource="#application.datasource#">
		<cfprocresult name="pCheckMemberDupUserName_Result">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strUserName" type="in" value="#form.strUserName#">
	</cfstoredproc>
</cfif>

<!--- Update cart with data from this form and anything else need is supplied by above procedure call --->
<cftry>

<cfstoredproc procedure="pUPSERT_CART" debug="yes" datasource="#application.datasource#">
    <cfprocresult name="pUPSERT_CART_Result">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="#pGetCartItems_Result.intCustomerID#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartFirstName" type="in" value="#form.strCartFirstname#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartLastName" type="in" value="#form.strCartlastname#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartAddress" type="in" value="#form.strCartAddress1#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartAddress2" type="in" value="#form.strCartAddress2#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartCity" type="in" value="#form.STRCARTCITY#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartStateID" type="in" value="#form.INTCARTSTATEID#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartZip" type="in" value="#form.STRCARTZIP#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strNameOnCard" type="in" value="#form.STRBILLNAME#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strExp" type="in" value="#form.strExpMonth#/#form.strExpYear#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingAddress" type="in" value="#form.STRBILLINGADDRESS#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingCity" type="in" value="#form.strBillingCity#">
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBillingStateID" type="in" value="#form.intBillingStateID#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingZip" type="in" value="#form.strBillingZip#">
    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartXip" type="in" value="#cgi.REMOTE_ADDR#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strEmail" type="in" value="#form.strEmail#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPhone" type="in" value="#form.strPhone#">
    <cfprocparam cfsqltype="CF_SQL_bit" variable="isShippingonFile" type="in"  value="#form.saveShipInfo#">
    <cfprocparam cfsqltype="CF_SQL_bit" variable="isBillingOnFile" type="in"  value="#form.isBillingOnFile#">
  	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strLast4" type="in"  value="#right(form.ccnumber,4)#">
  	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFirst6" type="in" value="#left(form.ccnumber,6)#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtDiscountRate" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtTaxRate" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtDiscount" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtShipping" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtTax" type="in" value="0">
	<!--- order type customer cart --->
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intCartTypeID" type="in" value="#pGetCartItems_Result.intCartTypeID#">
</cfstoredproc>

<CFIF session.CartID eq 0>
	<CFSET session.CartID=pUPSERT_CART_Result.intCartID>
</CFIF>

<cfif pGetCartItems_Result.intCartTypeID eq 2>
	<cfstoredproc procedure="pUPSERT_AdditionalInfo" debug="yes" datasource="#application.datasource#">
		<cfprocresult name="pUPSERT_AdditionalInfo_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intAddInfoID" type="in" value="#session.AddInfoID#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
		<CFIF form.STRCOAPPNAME neq ''>
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="STRCOAPPNAME" type="in" value="#form.STRCOAPPNAME#">
		<CFELSE>
		    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="STRCOAPPNAME" type="in" null="true" >
		</CFIF>

		<CFIF pCheckMemberDupSSN_Result.intMemberID eq 0>
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strSSN" type="in" value="#form.strSSN#">
		<CFELSE>
		    <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strSSN" type="in" null="true" >
		</CFIF>
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFederalID" type="in" value="#form.STRFEDERALID#">
		<CFIF IsDate(form.DTDATEOFBIRTH)>
			<cfprocparam cfsqltype="CF_SQL_DATETIME" variable="dtDateOfBirth" type="in" value="#form.DTDATEOFBIRTH#">
		<CFELSE>
			<cfprocparam cfsqltype="CF_SQL_DATETIME" variable="dtDateOfBirth" type="in"  null="true">
		</CFIF>
		<CFIF pCheckMemberDupUserName_Result.intMemberID eq 0>
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strUserName" type="in" value="#form.strUserName#">
		<CFELSE>
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strUserName" type="in" null="true">
		</CFIF>
		<CFIF isDefined("pUPSERT_PotentialSponsor_Result.intPotentialSponsorID")>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intPotentialSponsorID" type="in" value="#pUPSERT_PotentialSponsor_Result.intPotentialSponsorID#">
		<CFELSE>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intPotentialSponsorID" type="in" null="true">
		</CFIF>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intSponsorID" type="in" value="#session.memberID#">
	</cfstoredproc>

	<CFIF session.AddInfoID eq 0>
		<CFSET session.AddInfoID=pUPSERT_AdditionalInfo_Result.intAddInfoID>
	</CFIF>

	<cfstoredproc procedure="dbo.pGetCartItems" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetCartItems_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	</cfstoredproc>

	<CFIF  pGetCartItems_Result.amtTotal eq 0>
		<cfstoredproc procedure="pCreateMemberFromCart" debug="yes" datasource="#application.datasource#">
			<cfprocresult name="pCreateMemberFromCart_Result">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intChangeMemberID" type="in" value="0">
			<!--- type - affiliate --->
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberTypeID" type="in" value="500">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" value="#application.BrandID#">
		</cfstoredproc>
		<CFIF pCreateMemberFromCart_Result.intMemberID GT 0>

			<CFSET session.MemberID = pCreateMemberFromCart_Result.intMemberID>
			<CFSET session.CartID = 0>
			<CFSET session.Itemcount = 0>
			<CFINVOKE component="common.cfc.SendEmailAPI" method="SendEnrollmentConfirmation" returnVariable="SendEmail_results">
				<cfinvokeargument name="OrderID" value="0">
				<cfinvokeargument name="MemberID" value="#session.MemberID#">
				<cfinvokeargument name="intBrandID" value="#application.BrandID#">
			</CFINVOKE>
			<!--- send email to the sponsor --->
				<CFINVOKE component="global.cfc.SendEmailAPI" method="SendNotificationToEnroller" returnVariable="SendEmail_results">
					<cfinvokeargument name="MemberID" value="#session.MemberID#">
					<cfinvokeargument name="BrandID" value="#application.BrandID#">
				</CFINVOKE>
			<CFQUERY name="GetNewMemberUsername" datasource="#Application.Datasource#" >
				SELECT strUsername FROM dbo.Member WHERE intMemberID = #session.MemberID#
			</CFQUERY>

			<cflocation url="/#url.u#/checkout/confirmation/" addtoken="no">
			<CFABORT>

		<CFELSE>
			<cflocation url="/#url.u#/checkout/confirmation/?e=-10" addtoken="no">
			<CFABORT>
		</cfif>
	<CFELSE>
	<!--- shipping charges --->

		<cfstoredproc procedure="dbo.pUpdate_CartShipAmount" debug="yes" datasource="#application.datasource#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
				<cfprocparam cfsqltype="CF_SQL_decimal" variable="ShipRate" type="in" null="true" >
		</cfstoredproc>

	  	<cfstoredproc procedure="dbo.pUpdate_CartTotal" debug="yes" datasource="#application.datasource#">
	    	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	    </cfstoredproc>
	</cfif>
</cfif>
<!--- HACK FOR NOW --->
<CFQUERY name="getstatecode" datasource="#application.datasource#" >
	SELECT * FROM StateProvince WHERE intStateID = #form.intBillingStateID#
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
	<cfinvokeargument name="CardBillAddr1" value="#form.STRBILLINGADDRESS#">
	<cfinvokeargument name="CardBillAddr2" value="">
	<cfinvokeargument name="CardBillCity" value="#form.STRBILLINGCITY#">
	<cfinvokeargument name="CardBillState" value="#getstatecode.strStateCode#">
	<cfinvokeargument name="CardBillzip" value="#form.STRBILLINGZIP#">
	<cfinvokeargument name="Amount" value="#dollarformat(pGetCartItems_Result.AMTTOTAL)#">
	<cfinvokeargument name="CartID" value="#session.CartID#">
	<cfinvokeargument name="intBrandID" value="#application.brandID#">
</CFINVOKE>

<CFIF SaleRequest EQ "Accepted">
	<BR>Accepted CASE<BR>
	<!--- IF Good billing We need to create an "ORDER" based on cart. --->
	<cfif pGetCartItems_Result.intCartTypeID eq 2 >
		<cfstoredproc procedure="pCreateMemberFromCart" debug="yes" datasource="#application.datasource#">
			<cfprocresult name="pCreateMemberFromCart_Result">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intChangeMemberID" type="in" value="0">
			<!--- type - affiliate --->
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberTypeID" type="in" null="yes">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" value="#application.BrandID#">
		</cfstoredproc>
	</cfif>


	<cfstoredproc procedure="pCreateOrderFromCart" debug="yes" datasource="#application.datasource#">
		<cfprocresult name="pCreateOrderFromCart_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intOrderStatusID" type="in" value="#This.NextOrderStatusID#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLastChangedBy" type="in" value="#session.memberid#">
		<cfif pGetCartItems_Result.intCartTypeID eq 11>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="isCustomer" type="in" value="1">
		</cfif>
	</cfstoredproc>

	<CFIF pCreateOrderFromCart_Result.intOrderID GT 0>

		<cflock timeout=20 scope="Session" type="Exclusive">
    		<cfset session.cartID = 0>
		</cflock>
		<cfstoredproc procedure="pGetOrderInfo" debug="yes" datasource="#application.datasource#">
			<cfprocresult name="pGetOrderInfo_Result">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intOrderID" type="in" value="#pCreateOrderFromCart_Result.intOrderID#">
			<cfprocparam variable="strOrderGUID" cfsqltype="cf_sql_nvarchar" null='true' >
		</cfstoredproc>

		<!--- If order created and order type is enrollment, need to send confirmation email --->
		<CFIF pGetCartItems_Result.intCartTypeID  eq 2 >
			<CFINVOKE component="common.cfc.SendEmailAPI" method="SendEnrollmentConfirmation" returnVariable="SendEmail_results">
				<cfinvokeargument name="OrderID" value="#pCreateOrderFromCart_Result.intOrderID#">
				<cfinvokeargument name="MemberID" value="#pCreateMemberFromCart_Result.intMemberID#">
				<cfinvokeargument name="intBrandID" value="#pGetCartItems_Result.intBrandID#">
			</CFINVOKE>
		</CFIF>
		<CFIF pGetCartItems_Result.intCartTypeID  eq 1 >
			<CFINVOKE component="common.cfc.SendEmailAPI" method="SendShoppingConfirmation" returnVariable="SendEmail_results">
				<cfinvokeargument name="OrderID" value="#pCreateOrderFromCart_Result.intOrderID#">
			</CFINVOKE>
		</CFIF>
		<CFIF pGetCartItems_Result.intCartTypeID  eq 11 >
			<CFINVOKE component="global.cfc.SendEmailAPI" method="SendOrderEmailByAccessType" returnVariable="SendEmail_results">
			<cfinvokeargument name="OrderID" value="#pCreateOrderFromCart_Result.intOrderID#">
			<cfinvokeargument name="strEmailAccess" value="RelaxNoteEnroller">
			<cfinvokeargument name="pwdupdate" value="1">
			<cfinvokeargument name="brandid" value="#application.brandID#" >
		</CFINVOKE>

		<cfinvoke component="global.cfc.bls-travel" method="CreateCustomer" returnvariable="CreateMemberDataResult">
			<cfinvokeargument name="intCustomerID" value="#pGetOrderInfo_Result.intCustomerID#">
			<cfinvokeargument name="tierID" value="131">
		</cfinvoke>
		</CFIF>
	</cfif>

	<CFSET This.OrderReturnCode = pCreateOrderFromCart_Result.ERRORCODE>

<!---based on Error code 0  meaning no problems we can think about how to handle Customer --->
	<cfif This.OrderReturnCode GTE 0>
		<BR>GOOD Things Happend!<BR>
		<cflocation url="/#url.u#/checkout/confirmation/?o=#pGetOrderInfo_Result.STRORDERGUID#" addtoken="no">
		<CFABORT>
	<CFELSE>
		<BR>Order Error CASE2<BR>
		<CFLOCATION url="/#url.u#/checkout/payment/?e=#This.OrderReturnCode#" addToken="no">

		<CFABORT>
	</cfif>
<CFELSE>
	<BR>DECLINED CASE<BR>
	<CFLOCATION url="/#url.u#/checkout/payment/?e=-1&r=#SaleRequest#" addtoken="no">
	<CFABORT>
</cfif>
<cfcatch><cfdump var="#form#"><cfdump var="#cfcatch#"><cfdump var="#SaleRequest#"></cfcatch>
</cftry>
