<cfparam name="form.strCartZip" default="93103" maxlength="10" >
<cfparam name="this.ShipMethodID" default="1" type="integer" >
<!---<cfset data={}>--->
<cftry>
<!--- Update Cart --->
<cfstoredproc procedure="pUPDATE_CartZip" debug="yes" datasource="#application.datasource#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" Value="#session.CartID#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCartZip" type="in" value="#form.strCartZip#">
</cfstoredproc>

<CFIF form.strCartZip gt '' >
<!--- Get Information Needed for UPS --->
	<CFQUERY name="GetCartWeight" datasource="#Application.Datasource#" >
		SELECT IsNull([dbo].[fGetTotalCartWeight] (#session.CartID#),0) as CartWeight
	</CFQUERY>
	<CFQUERY name="GetItemCount" datasource="#Application.Datasource#" >
		SELECT sum(Quantity) TotalItemCount from dbo.xCart_Detail WHERE intCartID = #session.CartID#
	</CFQUERY>

	<cfswitch expression="#this.ShipMethodID#">
		<!---United States Post Office--->
		<cfcase value="4">
			<!--- not in user --->
		</cfcase>
		<!--- United Parcel Service Only --->
		<cfdefaultcase>
			<CFTRY>

				<!--- this should be in utils.. .but for now lets get it done --->
				<CFSET application.key = '5CDCC4D0A67945F5'>
				<CFSET application.username = 'powervida333'>
				<CFSET application.password = 'powervida4417'>
				<cfset st = createObject("component", "common.cfups.org.camden.ups.rateservice").init(application.key, application.username, application.password)>
				<!--- Use this to show package types--->
				<cfset packages = arrayNew(1)>
				<cfset arrayAppend(packages, st.getPackageStruct(weight= GetCartWeight.CartWeight,packagetype="02", declaredvalue=0))>
				<cfset rates = st.getRateInformation(shipperpostalcode=78734,packages=packages,shiptopostalcode=#form.strCartZip#)>
				<CFQUERY name="GetGround" dbtype="query" >
					SELECT totalcharges FROM rates where servicecode = '03'
				</cfQUERY>
				<CFSET This.ShippingCharge = getGround.TotalCharges >
			<CFCATCH>
				<CFSET This.ShippingCharge = '2.00'>
			</CFCATCH>
			</CFTRY>
		</cfdefaultcase>
	</cfswitch>

	<!--- Update Cart Ship Amount --->
	<cfstoredproc procedure="dbo.pUpdate_CartShipAmount" debug="yes" datasource="#application.datasource#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
	<cfif This.ShippingCharge gt ''>
	<!--- if we send something then this amount will trump ship procedure rate --->
		<cfprocparam cfsqltype="CF_SQL_decimal" scale="2" variable="ShipRate" type="in" value="#This.ShippingCharge#" >
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
<cflocation url="/#url.u#/checkout/" addtoken="false">
<!---<cfset data ={"success": "#session.cartid#"}>--->
<cfcatch>
	<cfset data={"success": 0}>
</cfcatch>
</cftry>
<!---<cfoutput>#SerializeJSON(data)#</cfoutput>--->
