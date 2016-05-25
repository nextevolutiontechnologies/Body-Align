<cfparam name="form.saveShipInfo" default="0">
<cfparam name="form.saveBillingInfo" default="0">
<CFPARAM name="session.CustID" default="0">
<CFPARAM name="intShipMethod" default="1">
<CFPARAM name="this.ShipMethodID" default="1">
<CFPARAM name="ShippingCharge" default="">


<!--- <CFQUERY name="GetTotalCartWeight" datasource="#application.datasource#" >
	SELECT [Powervida].[dbo].[fGetTotalCartWeight] (771)
</cfquery>

<CFSET application.key = '5CDCC4D0A67945F5'>
<CFSET application.username = 'powervida333'>
<CFSET application.password = 'powervida4417'>
<cfset st = createObject("component", "common.cfups.org.camden.ups.rateservice").init(application.key, application.username, application.password)>
<cfset packages = arrayNew(1)>
<cfset arrayAppend(packages, st.getPackageStruct(weight=11,packagetype="02", declaredvalue=0))>
<cfset rates = st.getRateInformation(shipperpostalcode=78734,packages=packages,shiptopostalcode=#form.STRZIPCODE#,service=03)>

<CFOUTPUT query="rates" maxrows="1">
	<CFQUERY name="GetTotalCartWeight" datasource="#application.datasource#" >
	UPDATE xCart SET amtShipping = #rates.totalcharges# Where intCartID = #session.cartID# 
</cfquery>

</cfoutput> --->

<cfstoredproc procedure="pUPSERT_CART" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pUPSERT_CART_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="#session.CustID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartFirstName" type="in" value="#form.STRFIRSTNAME#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartLastName" type="in" value="#form.STRLASTNAME#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartAddress" type="in" value="#form.STRADDRESS1#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartAddress2" type="in" value="#form.STRADDRESS2#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartCity" type="in" value="#form.STRCITY#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartStateID" type="in" value="#form.INTSTATEID#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartZip" type="in" value="#form.STRZIPCODE#">
	
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strNameOnCard" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strExp" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingAddress" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingCity" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBillingStateID" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingZip" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartXip" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strEmail" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPhone" type="in" value="#form.strPhone#">
	<cfprocparam cfsqltype="CF_SQL_bit" variable="isShippingonFile" type="in"  value="#form.saveShipInfo#">
	<cfprocparam cfsqltype="CF_SQL_bit" variable="isBillingOnFile" type="in"  value="0">
</cfstoredproc>
	<CFIF  Application.brandID eq 2>
			<CFSET this.ShipMethodID = 7 >
	</CFIF>
	<CFIF  Application.brandID eq 1>
			<CFSET this.ShipMethodID = 1>
	</CFIF>
	<CFIF  Application.brandID eq 1 and form.INTSTATEID eq 63>
			<CFSET this.ShipMethodID = 6>
	</CFIF>
	<!--- shipping charges --->
	
	  	 <!--- Need to get the weight of package here.. --->
		 <!--- this should be looked at so that its part of the cart results, we need to store with order in case things change later. --->
		 <CFQUERY name="GetCartWeight" datasource="#Application.Datasource#" >
		 	 SELECT IsNull([dbo].[fGetTotalCartWeight] (#session.CartID#),0) as CartWeight
		 </CFQUERY>
		 <CFQUERY name="GetItemCount" datasource="#Application.Datasource#" >
			SELECT sum(Quantity) TotalItemCount from dbo.xCart_Detail WHERE intCartID = #session.CartID#
		</CFQUERY>
		<!--- <CFQUERY name="GetShippingBrand" dbtype="query">
			SELECT MIN(intBrandID) intBrandID from pGetCartItems_Result WHERE intCartID = #session.CartID#
		</CFQUERY> --->
		 <CFTRY>  	
	  	  <!--- this should be in utils.. .but for now lets get it done --->
	  	<!--- <CFSET application.key = '5CDCC4D0A67945F5'>
		<CFSET application.username = 'powervida333'>
		<CFSET application.password = 'powervida4417'>
		<cfset st = createObject("component", "common.cfups.org.camden.ups.rateservice").init(application.key, application.username, application.password)>
		<!--- Use this to show package types--->
			
		<cfset packages = arrayNew(1)>
		<cfset arrayAppend(packages, st.getPackageStruct(weight=#GetCartWeight.CartWeight#,width=9,length=9,height=9,packagetype="02", declaredvalue=0))>
		<cfset rates = st.getRateInformation(shipperpostalcode=78734,packages=packages,shiptopostalcode=#form.STRZIPCODE#)>
		
		<!--- create a query body --->
		
		
		
		<CFQUERY name="GetGround" dbtype="query" > 
			SELECT TOTALCHARGES FROM rates where servicecode = '03'
		</CFQUERY>
		<CFSET ShippingCharge = getGround.TotalCharges + 3>
		 <CFCATCH>
			<CFSET ShippingCharge = '15.95'>
		</CFCATCH>
	     </CFTRY>
	
  
  	<cfif Application.brandID eq 2>
		
  		<cfstoredproc procedure="dbo.pUpdate_CartShipAmount" debug="yes" datasource="#application.datasource#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
				<cfprocparam cfsqltype="CF_SQL_decimal" variable="ShipRate" type="in" null="true" >
		</cfstoredproc>
		
	<cfelse> 
  	<CFQUERY name="GetGround" datasource="#application.datasource#" > 
		UPDATE dbo.xCart
		SET amtShipping = #ShippingCharge#,intShipMethodID = #intShipMethod#
		WHERE intCartID = #session.CartID#
	</cfQUERY>
	</cfif>
  	<cfstoredproc procedure="dbo.pUpdate_CartTotal" debug="yes" datasource="#application.datasource#">
    	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
    </cfstoredproc> --->
<!--- end shipping charges --->
<!--- start shipping charges --->
	<cfswitch expression="#this.ShipMethodID#">
			<!--- United Parcel Service Only --->
			<cfcase value="1">
			
				<CFTRY>  	
				<!--- this should be in utils.. .but for now lets get it done --->
				<CFSET application.key = '5CDCC4D0A67945F5'>
				<CFSET application.username = 'powervida333'>
				<CFSET application.password = 'powervida4417'>
				<cfset st = createObject("component", "common.cfups.org.camden.ups.rateservice").init(application.key, application.username, application.password)>
				<!--- Use this to show package types--->
				
				<cfset packages = arrayNew(1)>
				<cfset arrayAppend(packages, st.getPackageStruct(weight=#GetCartWeight.CartWeight#,packagetype="02", declaredvalue=0))>
				<cfset rates = st.getRateInformation(shipperpostalcode=78734,packages=packages,shiptopostalcode=#form.STRZIPCODE#)>
				<CFQUERY name="GetGround" dbtype="query" > 
				SELECT totalcharges FROM rates where servicecode = '03'
				</cfQUERY>
				<CFSET ShippingCharge = getGround.TotalCharges >
				<CFCATCH>
				<CFSET ShippingCharge = '15.66'>
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
			
			<!--- Body Align Custom Rates Autoship shipped via USPS--->
			<cfcase value="5">
				<CFSET ShippingCharge=1.50>
			</cfcase>
			
			<!--- Body Align Custom Rates shipped via USPS--->
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
		<CFCATCH>
			<CFSET ShippingCharge = '15.95'>
		</CFCATCH>
	     </CFTRY>
	
<!--- end shipping charges --->

<cflocation url="/#url.u#/products/check-out/payment/" addtoken="no">
<CFABORT>