<CFPARAM name="session.eCArtID" default="0" >
<CFPARAM name="url.e" default="0" type="numeric" >
<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetCartItems_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.eCartID#">
</cfstoredproc>
<!--- 
this can be tied into procedure, we are trying insure we have an 
address to pre fill since we took a shipping address already.  JM
--->
<CFQUERY name="GetBillingInfo" dbtype="query" >
 SELECT [strNameOnCard],[strExp],[strBillingAddress],[strBillingCity],[intBillingStateID] ,[strBillingZip],[strCartXip] ,[strEmail],[strPhone],[strLast4],[strFirst6],[isShippingonFile],[isBillingOnFile]
 FROM	pGetCartItems_Result
</CFQUERY>
<CFIF GetBillingInfo.strBillingAddress EQ ''>
<CFQUERY name="GetBillingInfo" dbtype="query" >
 SELECT [strCartFirstName] + ' ' +[strCartLastName] [strNameOnCard],[strExp],[strCartAddress]  [strBillingAddress],[strCartCity][strBillingCity],[intCartStateID][intBillingStateID],[strCartZip][strBillingZip],[strEmail],[strLast4],[strFirst6],[isShippingonFile],[isBillingOnFile]
 FROM	pGetCartItems_Result
</CFQUERY>

</CFIF>

<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_Result">
	<CFIF application.BrandID eq 2>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="53">
		<CFELSE>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="15">
		</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc>  

<!--- End of address hack --->
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
					<h3 class="primary-font"><cfoutput>#pGetPageContent_Result.strContentText1#</cfoutput></h3>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		
			<cfinclude template="/files/theopportunity/payment/#session.langcode#/index.cfm">
		 <!-- / .col -->
	</div> <!-- / .container -->
</div> <!-- / .wrapper -->
<CFINCLUDE template="/public/footer.cfm">