<CFPARAM name="session.CartID" default="0">
<CFPARAM name="this.ItemDiscount" default="0" max=".5" type="numeric">
<CFPARAM name="qty" default="0">



<CFTRY>
	<CFIF isDefined("form.ProductIDList") and form.ProductIDList gt ''  and ListLen(form.ProductIDList) gt 4>
		<CFLOCATION url="#ReplaceNoCase(CGI.HTTP_REFERER,'?e=-2','')#?e=-2" addToken="no"><CFABORT>
	</CFIF>
<cfstoredproc procedure="pAddToCart" debug="yes" datasource="#application.datasource#">
  <cfprocresult name="pAddtoCart_Result">
  <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
  <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="0">
  <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
  <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#form.intProductID#">
  <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="Quantity" type="in" value="#form.PCS#">
  <cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtUnit" type="in" value="#form.amtUnit#" scale="2">
<CFIF isDefined("form.ProductIDList") and form.ProductIDList gt '' >
	 <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="Insert">
<CFELSE>
  <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="add">
</CFIF>
  <cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="priceType" type="in" value="Retail">
  <cfif isDefined("form.strOptionList") and form.strOptionList NEQ ''>
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" value="#form.strProductName#-#form.strOptionList#">
		<cfelse>
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" null="yes">
		</cfif>
  <cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscountRate" type="in" value="#this.ItemDiscount#" scale="2">
  <cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscount" type="in" value="0" scale="2">
  <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartTypeID" type="in" value="1">
 <CFIF isDefined("form.ProductIDList") and form.ProductIDList gt '' >
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intGroupProductID" type="in" value="#form.intProductID#">
</CFIF> 
</cfstoredproc>
<cfif session.cartid eq 0>
  <cfset session.cartid=pAddtoCart_Result.intCartID>        
</cfif>
<CFIF isDefined("form.ProductIDList") and form.ProductIDList gt '' >
	<CFIF ListLen(form.ProductIDList) lte 4>	
	<!--- <CFINVOKE component="common.cfc.SiteUtilities" method="GetItemsQuantity_MixandMatch" returnVariable="GetItemsQuantity_MixandMatch_results">
		<cfinvokeargument name="intNumberSelectedCheckboxes" value="#ListLen(form.ProductIDList)#">
	</CFINVOKE> --->
	<cfquery name="GetItemsQuantity_MixandMatch_results" datasource="#application.datasource#">
		SELECT RETURNRESULT FROM [dbo].[GetItemsQuantity_MixandMatch] (
   			'#ListLen(form.ProductIDList)#',DEFAULT,DEFAULT
 		)
	</cfquery>
	<CFSET qty=GetItemsQuantity_MixandMatch_results.RETURNRESULT>
	<CFIF qty eq 0>
		<CFLOCATION url="/#url.u#/products/?e=-2" addToken="no"><CFABORT>
	</CFIF>
	<CFELSE>
	<CFLOCATION url="#ReplaceNoCase(CGI.HTTP_REFERER,'?e=-2','')#?e=-2" addToken="no"><CFABORT>
		<!--- <CFLOCATION url="/#url.u#/products/?e=-2" addToken="no"><CFABORT> --->
	</CFIF> 
	<cfloop index = "pidSelectedElement" list = "#form.ProductIDList#"> 
		<cfstoredproc procedure="pAddToCart" debug="yes" datasource="#application.datasource#">
  		<cfprocresult name="pAddtoCart_Result">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#session.MemberID#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="0">
 		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value="#pidSelectedElement#">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="Quantity" type="in" value="#qty#">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtUnit" type="in" value="0.00" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="action" type="in" value="Insert">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="priceType" type="in" value="override">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" null="yes">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscountRate" type="in" value="#this.ItemDiscount#" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_DECIMAL" variable="amtDiscount" type="in" value="0" scale="2">
  		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartTypeID" type="in" value="1">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intGroupProductID" type="in" value="#form.intProductID#">
		</cfstoredproc>
		<cfif session.cartid eq 0>
 			 <cfset session.cartid=pAddtoCart_Result.intCartID>        
		</cfif>
	</cfloop>
</CFIF>

<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">
  <cfprocresult name="pGetCartItems_Result">
  <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">           
</cfstoredproc>
<cfset session.ItemCount = "#pGetCartItems_Result.itemcount#">
<!--- This needs to be dynamic using url.u to send it back to the correct place.--->
<CFLOCATION url="/#url.u#/products/?e=1" addToken="no">
<CFCATCH><cfoutput>#CFCATCH.MESSAGE# #CFCATCH.detail#</cfoutput><cfabort>
	<CFLOCATION url="/#url.u#/products/?e=-1" addToken="no">
</CFCATCH>
</CFTRY>




