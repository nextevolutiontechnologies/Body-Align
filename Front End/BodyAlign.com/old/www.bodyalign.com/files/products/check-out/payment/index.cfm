<CFPARAM name="session.CustID" default="0">
<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">

<!--- payment infor translation --->
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_Info">
	<CFIF application.BrandID eq 2>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="62">
	<CFELSE>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="25">
	</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc> 

<!--- This get Data thats "On File" --->
<cfstoredproc procedure="pGetCustomerAddress" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="getCustomerAddress" >
	<cfprocparam  variable="intCustomerID" cfsqltype="cf_sql_integer"  value="#session.CustID#">   
</cfstoredproc>
<!--- This get Data thats "On File" --->
<cfstoredproc procedure="pGetCustomerBilling" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="getCustomerBilling" >
	<cfprocparam  variable="intCustomerID" cfsqltype="cf_sql_integer"  value="#session.CustID#">   
</cfstoredproc>
<!--- This get Cart information --->
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetCartItems_Result">	
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>

<CFQUERY name="GetBillInfo" dbtype="query" >
 SELECT intMemberID,[strNameOnCard],[strExp] [STRCCEXP],[strBillingAddress],[strBillingCity],[intBillingStateID] ,[strBillingZip],[strCartXip] ,[strEmail],[strPhone],[strLast4],[strFirst6],[isShippingonFile],[isBillingOnFile]
 FROM	pGetCartItems_Result
</CFQUERY>
<CFIF GetBillInfo.strBillingAddress EQ ''>
<CFQUERY name="GetBillInfo" dbtype="query" >
 SELECT  intMemberID,[strCartFirstName] + ' ' +[strCartLastName] [strNameOnCard],STREXP [STRCCEXP],[strCartAddress] + ' ' + [strCartAddress2] [strBillingAddress],[strCartCity][strBillingCity],[intCartStateID][intBillingStateID],[strCartZip][strBillingZip],[strEmail],[strLast4],[strFirst6],[isShippingonFile],[isBillingOnFile]
 FROM	pGetCartItems_Result
</CFQUERY>
</CFIF>

<CFQUERY name="getDataOnFile" datasource="#application.datasource#">
			select intCustomerBIllingID as ID, intCustomerID, strLast4, strFirst6, strCCExp, strPayTOken, 
			strNameOnCard,strAddress, strAddress2, strCity, intStateID, strZip from CUSTOMER_BILLING
			WHERE intCustomerID=#pGetCartItems_Result.intCustomerID#
</CFQUERY>
			
<cfajaximport>

<script language="javascript">
function getformdate(){
submitForm();
}
function submitForm(){
ColdFusion.Ajax.submitForm('pvcheckout', '/files/process/check-out/ajax/payment/', callback, errorHandler);
}

function callback(text) {
var myobj=JSON.parse(text);

if (!jQuery.isEmptyObject(myobj.SHIPPING))
{
var myobj_shipping=myobj.SHIPPING[0];
$('#INTCUSTOMERADDRESSID').val(myobj_shipping.INTCUSTOMERADDRESSID);

$('#STRADDRESS1').text(myobj_shipping.STRADDRESS1);
$('#STRADDRESS2').text(myobj_shipping.STRADDRESS2);
$('#STRCITY').text(myobj_shipping.STRCITY);
$('#STRFIRSTNAME').text(myobj_shipping.STRFIRSTNAME);
$('#STRLASTNAME').text(myobj_shipping.STRLASTNAME);
$('#STRZIPCODE').text(myobj_shipping.STRZIPCODE);

}
else {
$('#INTCUSTOMERADDRESSID').text('');
$('#INTSTATEID').text('');
$('#STRADDRESS1').text('');
$('#STRADDRESS2').text('');
$('#STRCITY').text('');
$('#STRFIRSTNAME').text('');
$('#STRLASTNAME').text('');
$('#STRZIPCODE').text('');
}

if (!jQuery.isEmptyObject(myobj.PAYMENT)) {
var myreobj=myobj.PAYMENT[0];
$('#intcustomerbillingID').val(myreobj.INTCUSTOMERBILLINGID);
$('#strbillstreet').val(myreobj.STRADDRESS);
$('#strbillname').val(myreobj.STRBILLINGNAME);
$('#strccexp').val(myreobj.STRCCEXP);
$('#strbillcity').val(myreobj.STRCITY);
$('#intbillstate').val(myreobj.INTSTATEID);
$('#ccnumber').val('xxxxxxxxxxxx'+myreobj.STRLAST4);
$('#strbillzipCode').val(myreobj.STRZIP);

}
else {
$('#intcustomerbillingID').val('');
$('#strbillstreet').val('');
$('#strbillname').val('');
$('#strccexp').val('');
$('#strbillcity').val('');
$('#intbillstate').val('');
$('#ccnumber').val('');
$('#strbillzipCode').val('');
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
<div class="col-sm-4">
<h3 class="primary-font"><!--- Payment ---><cfoutput>#pGetPageContent_Info.strContentText1#</cfoutput></h3>
</div>
</div>
</div>
</div>			
<div class="container">     
<div class="row">

<CFINCLUDE template="/files/products/check-out/payment/#session.langcode#/index.cfm">

</div> <!-- / .row -->

</div> <!-- / .container -->

</div> <!-- / .wrapper -->

<CFINCLUDE template="/public/footer.cfm">

<script type="text/javascript">
<!--- because dropdown select using hiding divs for the same form,
possible situation that all fields available and hard to tell what type of payment it is.
the hidden field pmtselected - will determine exactly which type of payment has been selected. --->
$(document).ready(function() { 
 
   	$('#pmtselection li').on('click', function(){
   		//alert($(this).text())
    	$('#pmtselected').val($(this).text());
    	if($(this).text()=='Credit Card')
    	{$("#pay-at-pickup").attr("class", "tab-pane fade");}
    	if($(this).text()=='Cards On file')
    	{$("#credit-card").attr("class", "tab-pane fade");}
    	
	});
    
});
</script> 