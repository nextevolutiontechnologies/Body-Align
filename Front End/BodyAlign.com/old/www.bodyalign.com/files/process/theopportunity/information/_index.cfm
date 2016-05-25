<CFPARAM name="session.eCartID" default="0">
<CFPARAM name="form.intCompID" default="0">
<CFPARAM name="session.AddInfoID" default="0">
<CFPARAM name="intShipMethod" default="1">

<!--- check all form fields --->
<!---

<CFIF form.intRepID eq	-1 and isNumeric(strSponsorRepID)>
	<!--- check if this repid already exists --->
	<cfstoredproc procedure="pGetMemberInfoByRepID" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pGetMemberInfoByRepID_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intRepID" type="in" value="#strSponsorRepID#">	
	</cfstoredproc>	
    <CFIF pGetMemberInfoByRepID_Result.RecordCount gt 0>
		<CFSET This.repID=pGetMemberInfoByRepID_Result.intRepID>
	</CFIF>
</CFIF>
<CFIF form.intRepID gt 0>
	<CFSET This.repID=form.intRepID>
</CFIF>
<!--- if sponsorRepID not exists or does not match records in our system, than insert/update potential sponsor table--->

<CFIF form.intrepID eq -1 and (not isDefined("pGetMemberInfoByRepID_Result.RecordCount") or  pGetMemberInfoByRepID_Result.RecordCount eq 0)>
	<cfstoredproc procedure="pUPSERT_PotentialSponsor" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pUPSERT_PotentialSponsor_Result">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intSignupID" type="in" value="#session.AddInfoID#">	
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strRepID" type="in" value="#form.strSponsorRepID#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strName" type="in" value="#form.strSponsorName#">
	</cfstoredproc>	
<CFOUTPUT>#pUPSERT_PotentialSponsor_Result.intPotentialSponsorID#</CFOUTPUT>
</CFIF>
--->
<!--- Check SSN dup --->

<cfstoredproc procedure="pCheckMemberDupSSN" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pCheckMemberDupSSN_Result">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strSSN" type="in" value="#form.strSSN#">
</cfstoredproc>

<!--- Check Username dup --->

<cfstoredproc procedure="pCheckMemberDupUserName" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pCheckMemberDupUserName_Result">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strUserName" type="in" value="#form.strUserName#">
</cfstoredproc>

<cfstoredproc procedure="pUPSERT_CART" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pUPSERT_CART_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCID" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intMemberID" type="in" value="#session.memberID#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartFirstName" type="in" value="#form.strFName#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartLastName" type="in" value="#form.strLName#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartAddress" type="in" value="#form.strAddress#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartAddress2" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartCity" type="in" value="#form.strCity#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartStateID" type="in" value="#form.intstateid#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartZip" type="in" value="#form.strZipCode#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strNameOnCard" type="in" null="true" >
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strExp" type="in" null="true" >
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingAddress" type="in" null="true" >
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingCity" type="in" null="true" >
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intBillingStateID" type="in" null="true" >
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strBillingZip" type="in" null="true" >
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartXip" type="in" null="true" >
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strEmail" type="in" value="#form.strEmail#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strPhone" type="in" value="#form.strPhone#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="isShippingonFilee" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="isBillingOnFile" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strLast4" type="in" null="true">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strFirst6" type="in" null="true">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtDiscountRate" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtTaxRate" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtDiscount" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtShipping" type="in" value="0">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="amtTax" type="in" value="0">
	<!--- order type enrollment --->
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="intCartTypeID" type="in" value="2">
</cfstoredproc>
<CFIF session.eCartID eq 0>
	<CFSET session.eCartID=pUPSERT_CART_Result.intCartID>
</CFIF>

<cfstoredproc procedure="pUPSERT_AdditionalInfo" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pUPSERT_AdditionalInfo_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intAddInfoID" type="in" value="#session.AddInfoID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
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
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">	
</cfstoredproc>
<CFDUMP var="#pGetCartItems_Result#" >

<CFIF  pGetCartItems_Result.amtTotal eq 0>
	<cfstoredproc procedure="pCreateMemberFromCart" debug="yes" datasource="#application.datasource#">		
		<cfprocresult name="pCreateMemberFromCart_Result">	
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intChangeMemberID" type="in" value="0">
		<!--- type - affiliate --->
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberTypeID" type="in" value="500">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" value="#application.BrandID#">
	</cfstoredproc>
	<CFIF pCreateMemberFromCart_Result.intMemberID GT 0>
		
		<CFSET session.MemberID = pCreateMemberFromCart_Result.intMemberID>
		<CFSET session.eCartID = 0>
		<CFSET session.Itemcount = 0>
		<CFINVOKE component="common.cfc.SendEmailAPI" method="SendEnrollmentConfirmation" returnVariable="SendEmail_results">
			<cfinvokeargument name="OrderID" value="0">
			<cfinvokeargument name="MemberID" value="#session.MemberID#">
			<cfinvokeargument name="intBrandID" value="#application.BrandID#">
		</CFINVOKE>
		<CFQUERY name="GetNewMemberUsername" datasource="#Application.Datasource#" >
			SELECT strUsername FROM dbo.Member WHERE intMemberID = #session.MemberID#
		</CFQUERY>
		<cflocation url="/#GetNewMemberUsername.strUsername#/theopportunity/confirmation/" addtoken="no">
		<CFABORT>
		
	<CFELSE>
		<cflocation url="/#url.u#/theopportunity/information/?e=-10" addtoken="no">
		<CFABORT>
	</cfif>
<CFELSE>
<!--- shipping charges --->
	<CFIF Application.BrandID NEQ 2>
		<CFIF form.intstateID eq '63'>
			<CFSET ShippingCharge = '17.90'>
			<CFSET intShipMethod=6>
		<CFELSE>
		  	 <!--- Need to get the weight of package here.. --->
			 <!--- this should be looked at so that its part of the cart results, we need to store with order in case things change later. --->
			 <CFQUERY name="GetCartWeight" datasource="#Application.Datasource#" >
			 	 SELECT IsNull([dbo].[fGetTotalCartWeight] (#session.eCartID#),0) as CartWeight
			 </CFQUERY>
			 <CFTRY>  	
		  	  <!--- this should be in utils.. .but for now lets get it done --->
		  	<CFSET application.key = '5CDCC4D0A67945F5'>
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
		</CFIF>
	  
	  	<CFQUERY name="GetGround" datasource="#application.datasource#" > 
			UPDATE dbo.xCart
			SET amtShipping = #ShippingCharge#,intShipMethodID = #intShipMethod#
			WHERE intCartID = #session.eCartID#
		</cfQUERY>
	<cfelse> 
			
  		<cfstoredproc procedure="dbo.pUpdate_CartShipAmount" debug="yes" datasource="#application.datasource#">
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
				<cfprocparam cfsqltype="CF_SQL_decimal" variable="ShipRate" type="in" null="true" >
		</cfstoredproc>
			
		
		
	</CFIF>
  	<cfstoredproc procedure="dbo.pUpdate_CartTotal" debug="yes" datasource="#application.datasource#">
    	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
    </cfstoredproc>
  
<!--- end shipping charges --->
<CFIF pCheckMemberDupSSN_Result.intMemberID eq 0 and pUPSERT_AdditionalInfo_Result.intAddInfoID gt 0 and pCheckMemberDupUserName_Result.intMemberID eq 0>
<CFLOCATION url="/#url.u#/theopportunity/payment/" addToken="no">
<CFELSEIF pUPSERT_AdditionalInfo_Result.intAddInfoID eq 0>
<CFLOCATION url="/#url.u#/theopportunity/information/?e=2" addToken="no">
<CFELSEIF pCheckMemberDupSSN_Result.intMemberID gt 0>
<CFLOCATION url="/#url.u#/theopportunity/information/?e=3" addToken="no">
<CFELSEIF pCheckMemberDupUserName_Result.intMemberID gt 0>
<CFLOCATION url="/#url.u#/theopportunity/information/?e=4" addToken="no">
</CFIF>
</CFIF>
