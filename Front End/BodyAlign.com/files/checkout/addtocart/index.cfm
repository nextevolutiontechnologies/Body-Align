﻿<CFPARAM name="form.CustID" default=0 type="integer">
<CFPARAM name="form.unit" default="0" type="numeric">
<CFPARAM name="form.nQty" default="0" type="numeric" min="0" max="100">
<CFPARAM name="form.nQty" default="0" type="numeric" min="0" max="100">
<CFPARAM name="form.CartTypeID" default="1" type="numeric" min="1" max="1">
<CFPARAM name="this.PriceType" default="retail">
<CFPARAM name="this.AbortStop" type="numeric" default="0">

<CFPARAM name="session.memberID" default="0">
<CFPARAM name="session.cartID"	default="0">

<!--- Just in case... (validation of field prior to post should be done)--->
<cfif form.nQty eq ''>
	<cfset form.nQty = 0>
</cfif>

<!--- Product List Option - This is for some products who have a list of items to deal with --->
<CFIF (isDefined("form.ProductIDList")
		and ListLen(form.ProductIDList) gt 4)
		or (isDefined("form.isSelections") and not isDefined("form.ProductIDLIst"))>
	<CFIF session.CartID gt 0>

	<CFLOCATION url="/orders/new-order/?e=-1" addToken="no"><CFABORT>
	<CFELSE>
	<CFQUERY name="GetMemberIDFromGUID" datasource="#application.datasource#">
		SELECT * FROM [dbo].[fGetMemberData] (#session.MemberID#,NULL)
	</CFQUERY>

	<CFLOCATION url="/orders/new-order/e=-1&m=#GetMemberIDFromGUID.strMemberGUID#" addToken="no"><CFABORT>
	</CFIF>
</CFIF>

<!--- Thing 2 --->
<CFIF isDefined("form.pricetype")>
	<CFSET this.pricetype=form.pricetype>
</CFIF>
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetCartItems_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>

<cfif isdefined("pGetCartItems_Result.intcarttypeid") and pGetCartItems_Result.intcarttypeid neq form.CartTypeID>
	<cfstoredproc procedure="dbo.pREMOVE_CART_ALL" debug="yes" datasource="#application.datasource#">
		<cfprocresult name="pREMOVE_CART_ALL_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	</cfstoredproc>
	<cfset session.cartID=0>
</cfif>
<cfif form.CartTypeID eq 2 or form.CartTypeID eq 11>
	<cfstoredproc procedure="dbo.pREMOVE_CART_ALL" debug="yes" datasource="#application.datasource#">
		<cfprocresult name="pREMOVE_CART_ALL_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	</cfstoredproc>
	<cfset session.cartID=0>
</cfif>
<!--- Always --->
<cfstoredproc procedure="pGetProductInfo" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetProductInfo_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" Value="#form.Productid#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intMemberID" type="in" value="#session.MemberID#">
</cfstoredproc>




<!--- Always --->
<cfstoredproc procedure="pAddToCart" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pAddtoCart_Result">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intMemberID" type="in" value="#session.MemberID#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intCustomerID" type="in" value="#form.CustID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">

<!--- in case of size selection, use intProductOptionID, not intProductID --->
<!---<CFIF isDefined("form.intProductOptionID") and form.intProductOptionID gt 0>
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#form.intProductOptionID#">
<CFELSE>--->
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#form.Productid#">
<!---</CFIF>--->
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="Quantity" type="in" value="#form.nqty#">
	<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtUnit" type="in" value = "#form.Unit#">
<!--- in case of Null --->
<!---<CFIF isDefined("form.ProductIDList") and form.ProductIDList gt '' >
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="Insert">
<CFELSE>--->
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="add">
<!---</CFIF>--->
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="priceType" type="in" value="#this.pricetype#">
<!--- in case of Null --->
<!---<cfif isDefined("form.strOptionList") and form.strOptionList NEQ ''>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" value="#form.strProductName#-#form.strOptionList#">
<cfelse>--->
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" null="yes">
<!---</cfif>--->
	<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscountRate" type="in" value="0" scale="2">
	<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscount" type="in" value="0" scale="2">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartTypeID" type="in" value="#form.CartTypeID#">
<!---<CFIF isDefined("form.ProductIDList") and form.ProductIDList gt '' >
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intGroupProductID" type="in" value="#form.Productid#">
<cfelseif isDefined("form.intselectedproducts") and form.intselectedproducts gt '' >
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intGroupProductID" type="in" value="#form.Productid#">
<cfelse>--->
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intGroupProductID" type="in" null="true" >
<!---</CFIF>--->
</cfstoredproc>

<!--- START: mix and match products --->
<CFIF isDefined("form.ProductIDList") and form.ProductIDList gt '' >
	<CFIF ListLen(form.ProductIDList) lte 4>

	<cfquery name="GetItemsQuantity_MixandMatch_results" datasource="#application.datasource#">
		SELECT RETURNRESULT FROM [dbo].[GetItemsQuantity_MixandMatch] (
   			'#ListLen(form.ProductIDList)#',DEFAULT,DEFAULT
 		)
	</cfquery>
	<CFSET qty=GetItemsQuantity_MixandMatch_results.RETURNRESULT>
	<CFIF qty eq 0>

		<!--- <CFLOCATION url="/#url.u#/products/?e=-2" addToken="no"> ---><CFABORT>
	</CFIF>
	<CFELSE>

	<!--- <CFLOCATION url="#ReplaceNoCase(CGI.HTTP_REFERER,'?e=-2','')#?e=-2" addToken="no"> ---><CFABORT>

	</CFIF>
	<cfloop index = "pidSelectedElement" list = "#form.ProductIDList#">
		<cfstoredproc procedure="pAddToCart" debug="yes" datasource="#application.datasource#">
  		<cfprocresult name="pAddtoCart_Result">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="#form.CustID#">
 		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#pidSelectedElement#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="Quantity" type="in" value="#qty#">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtUnit" type="in" value="0.00" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="Insert">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="priceType" type="in" value="override">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" null="yes">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscountRate" type="in" value="#form.DiscountRate#" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscount" type="in" value="0" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartTypeID" type="in" value="#form.CartTypeID#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intGroupProductID" type="in" value="#form.Productid#">
		</cfstoredproc>

	</cfloop>
</CFIF>
<!--- END: mix and match products --->

<!--- START: Size Selection --->
<CFIF isDefined("form.intselectedproducts")>
<cfloop index = "pidSelectedElement" list = "#form.intselectedproducts#">
	<CFOUTPUT>#pidSelectedElement# </CFOUTPUT>
	<!--- check if product exist --->
	<cfstoredproc procedure="dbo.pGetProductInfo" debug="yes" datasource="#application.datasource#">
		<cfprocresult name="pGetProductInfo_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#pidSelectedElement#">
	</cfstoredproc>

	<CFIF pGetProductInfo_Result.RecordCount eq 0>

		<CFLOCATION url="/orders/new-order/" addToken="no"><CFABORT>
	</CFIF>

	<cfstoredproc procedure="pAddToCart" debug="yes" datasource="#application.datasource#">
  		<cfprocresult name="pAddtoCart_Result">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="#form.CustID#">
 		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#pidSelectedElement#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="Quantity" type="in" value="#form.nqty#">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtUnit" type="in" value="0.00" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="Insert">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="priceType" type="in" value="override">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" null="yes">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscountRate" type="in" value="#form.DiscountRate#" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscount" type="in" value="0" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartTypeID" type="in" value="#form.CartTypeID#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intGroupProductID" type="in" value="#form.Productid#">
		</cfstoredproc>

</cfloop>
</CFIF>
<!--- END: Size Selection --->

<!--- Get Cart Items. --->
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetCartItems_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>
<!--- START: Shipping Mess --->
<!--- if zipcode exist calculate shipping charges --->
<!--- calculate shipping for all order types except event ticket --->
<CFIF pGetCartItems_Result.strCartZip gt '' and (pGetCartItems_Result.intCartTypeID neq 11)>
	<!--- calculate shipping amount --->
	<CFQUERY name="GetCartWeight" datasource="#Application.Datasource#" >
		SELECT IsNull([dbo].[fGetTotalCartWeight] (#session.CartID#),0) as CartWeight
	</CFQUERY>
	<CFQUERY name="GetItemCount" datasource="#Application.Datasource#" >
		SELECT sum(Quantity) TotalItemCount from dbo.xCart_Detail WHERE intCartID = #session.CartID#
	</CFQUERY>
	<CFQUERY name="GetShippingBrand" dbtype="query">
	SELECT MIN(intBrandID) intBrandID from pGetCartItems_Result WHERE intCartID = #session.CartID#
	</CFQUERY>
		<cfparam name="this.ShipMethodID" default="1" >
		<CFIF GetShippingBrand.intBrandID eq 2 or GetShippingBrand.intBrandID eq 0>
			<CFSET this.ShipMethodID = 7 >
		</CFIF>
		<CFIF GetShippingBrand.intBrandID eq 1>
			<CFSET this.ShipMethodID = 1>
		</CFIF>
		<CFIF GetShippingBrand.intBrandID eq 1 and  pGetCartItems_Result.intCartStateID eq 63>
			<CFSET this.ShipMethodID = 6>
		</CFIF>
		<!---<CFIF GetShippingBrand.intBrandID eq 0 and  pGetCartItems_Result.intCartStateID eq 63>
			<CFSET this.ShipMethodID = 6>
		</CFIF>
		<CFIF (GetShippingBrand.intBrandID eq 2 or GetShippingBrand.intBrandID eq 0) and  pGetCartItems_Result.intCartTypeID eq 3>
			<CFSET this.ShipMethodID = 5>
		</CFIF>--->

		<cfswitch expression="#this.ShipMethodID#">
			<!--- United Parcel Service Only --->
			<cfcase value="1">
				<CFTRY>

				<!--- this should be in utils.. .but for now lets get it done --->
				<CFSET application.key = '5CDCC4D0A67945F5'>
				<CFSET application.username = 'powervida333'>
				<CFSET application.password = 'powervida4417'>
				<cfset st = createObject("component", "global.cfc.cfups.org.camden.ups.rateservice").init(application.key, application.username, application.password)>
				<!--- Use this to show package types--->

				<cfset packages = arrayNew(1)>
				<cfset arrayAppend(packages, st.getPackageStruct(weight=#GetCartWeight.CartWeight#,packagetype="02", declaredvalue=0))>
				<cfset rates = st.getRateInformation(shipperpostalcode=78734,packages=packages,shiptopostalcode=#pGetCartItems_Result.strCartZip#)>
				<CFQUERY name="GetGround" dbtype="query" >
				SELECT totalcharges FROM rates where servicecode = '03'
				</cfQUERY>
				<CFSET ShippingCharge = getGround.TotalCharges >
				<CFCATCH>

				<CFSET ShippingCharge = '9.66'>

				</CFCATCH>
				</CFTRY>

			</cfcase>

			<!---Will Call (Austin)--->
			<cfcase value="2,3">
				<CFSET ShippingCharge=0>
			</cfcase>

			<!---United States Post Office--->
			<cfcase value="4">
				<!--- not in user --->
			</cfcase>

			<!--- Body Align or Briarnet Custom Rates Autoship shipped via USPS--->
			<cfcase value="5">
				<CFSET ShippingCharge=1.50>
			</cfcase>

			<!--- Body Align or Briarnet Custom Rates shipped via USPS--->
			<cfcase value="7">
				<!--- nothing to set --->
			</cfcase>
		</cfswitch>

		<cfstoredproc procedure="dbo.pUpdate_CartShipAmount" debug="yes" datasource="#application.datasource#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
		<cfif ShippingCharge gt ''>
			<!--- if we send something then this amount will trump ship procedure rate --->
			<cfprocparam cfsqltype="CF_SQL_decimal" scale="2" variable="ShipRate" type="in" value="#ShippingCharge#" >
		<cfelse>
			<!--- if we send null then Procedure will Get Shipping Rate --->
			<cfprocparam cfsqltype="CF_SQL_decimal" variable="ShipRate" type="in" null="true" >
		</cfif>
			<cfprocparam cfsqltype="CF_SQL_int" variable="intShipMethodID" type="in" value="#this.ShipMethodID#" >
		</cfstoredproc>

		<!--- Update Cart Total --->
		<cfstoredproc procedure="dbo.pUpdate_CartTotal" debug="yes" datasource="#application.datasource#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
		</cfstoredproc>
</CFIF>

<!--- END: Shipping Mess --->
<cfif session.cartid eq 0>
  <cfset session.cartid=pAddtoCart_Result.intCartID>
</cfif>

<cfif form.CartTypeID eq 11>
	<!---autoship case--->
	<CFLOCATION url="/#url.u#/checkout/payment/" addToken="no">
<cfelseif form.CartTypeID eq 2 and form.productid eq "1070">
	<CFLOCATION url="/#url.u#/checkout/payment/" addToken="no">
<cfelse>
	<CFLOCATION url="/#url.u#/checkout/" addToken="no">
</cfif>
<CFTRY><CFCATCH>
	<CFLOCATION url="/#url.u#/?e=-2" addToken="no"><CFABORT>
</CFCATCH>
</CFTRY>