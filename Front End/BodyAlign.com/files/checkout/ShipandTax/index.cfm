<cfparam name="form.strCartZip" default="93103" maxlength="10" >
<cfparam name="this.ShipMethodID" default="7" type="integer" >
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
	<!--- Update Cart Ship Amount --->
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
<cflocation url="/#url.u#/checkout/" addtoken="false">
<!---<cfset data ={"success": "#session.cartid#"}>--->
<cfcatch>
	<cfset data={"success": 0}>
</cfcatch>
</cftry>
<!---<cfoutput>#SerializeJSON(data)#</cfoutput>--->
