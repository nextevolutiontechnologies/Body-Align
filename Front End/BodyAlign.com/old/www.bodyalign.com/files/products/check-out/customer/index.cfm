<CFPARAM name="session.CustID" default="0">
<CFPARAM name="url.editshipping" default="0">

<!--- if user is logged in then send to payment page, unless they are trying to edit a shipping address. 
<CFIF Session.CustID GT 0 and url.editshipping eq 0>
	<CFLOCATION url="/#url.u#/products/check-out/payment/" >
</cfif>
This is sorta a problem 
--->
<CFINCLUDE template="/public/header.cfm">
<CFINCLUDE template="/public/main-nav.cfm">

<!--- shopping cart fields translation ---->
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_ResultCustomerInformation">
	<CFIF application.BrandID eq 2>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="61">
	<CFELSE>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="24">
	</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc> 

<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetCartItems_Result">	
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>
<!--- logic from backoffice powervida new ordering system --->
<CFQUERY name="GetCartInfo" dbtype="query" >
	SELECT * FROM pGetCartItems_Result
</CFQUERY>

<CFIF session.cartID EQ 0 or GetCartInfo.strCartAddress EQ ''>
	
	<cfstoredproc procedure="pGetCustomerInfo" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetCustomerInfo_Result" >
	<CFIF session.CustID eq 0 and isDefined("cookie.customerID")>
	<cfprocparam variable="intCustomerID" cfsqltype="cf_sql_integer"  value="#cookie.customerID#"> 
	<CFELSE>
	<cfprocparam variable="intCustomerID" cfsqltype="cf_sql_integer"  value="#session.CustID#">   
	</CFIF>
</cfstoredproc>
<CFQUERY name="GetCartInfo" dbtype="query" >
	SELECT strFirstName as strCartFirstName,strLastName as strCartLastName,strAddress1 as strCartAddress,strAddress2 as strCartAddress2
	,strCity as strCartCity,intStateID as intCartStateID,strZipcode as strCartZip,strPhone as strPhone,strEmail as strEmail,1 intShipMethodID
	from pGetCustomerInfo_Result
</CFQUERY>
</cfif>

<cfstoredproc procedure="pGetCustomerAddress" debug="yes" datasource="#application.datasource#">		
<cfprocresult name="pGetCustomerAddress_result">	
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCustomerID" type="in" value="#session.CustID#">
</cfstoredproc>				
<cfquery name="AddressDropdownList" dbtype="query">
SELECT intCustomerAddressID as INTADDRESSID,strAddress1 as strAddress,strAddress2,strCity,intStateID,strZipCode,strState,strStateCode,strCountrycode,strFirstName,strLastName			
FROM   pGetCustomerAddress_result
</cfquery>	
<cfajaximport>

<script language="javascript">
function getformdate()
{
submitForm();
}

function submitForm(whichBn)
{

ColdFusion.Ajax.submitForm('CustomerForm', '/<CFOUTPUT>#url.u#</CFOUTPUT>/process/check-out/ajax/', callback, errorHandler);
}

function callback(text)
{

var myobj=JSON.parse(text);
var col=myobj.COLUMNS;

if( ! jQuery.isEmptyObject(myobj.DATA))
{
var col_data=myobj.DATA[0];

for (var i = 0; i < col.length; i++) {              
$('#'+col[i]).val(col_data[i]);               
}
}
else
{ 
for (var i = 0; i < col.length; i++) {              
$('#'+col[i]).val('');               
}
}
}

function errorHandler(code, msg)
{
//alert("Error!!! " + code + ": " + msg);
}
</script>

<!-- Wrapper -->
<div class="wrapper">
<!-- Topic Header -->
<div class="topic">
<div class="container">
<div class="row">

<!--- include form --->
<cfinclude template="/files/products/check-out/customer/#session.langcode#/index.cfm">

</div> <!-- / .row -->
</div> <!-- / .container -->
</div> <!-- / .wrapper -->
<CFINCLUDE template="/public/footer.cfm">