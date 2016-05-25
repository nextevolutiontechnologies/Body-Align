

		<CFQUERY name="getDataOnFile" datasource="#application.datasource#">
			select intCustomerBIllingID as ID, intCustomerID, strLast4, strFirst6, strCCExp, strPayTOken, 
			strNameOnCard,strAddress, strAddress2, strCity, intStateID, strZip from CUSTOMER_BILLING
			WHERE intCustomerBIllingID=#form.billingIDOnFile#
		</CFQUERY>
		







	<CFIF session.CustID neq getDataOnFile.intCustomerID><cflocation url="/#url.u#/products/check-out/payment/?e=-2" addtoken="no"><CFABORT></CFIF>




<CFIF getDataOnFile.strPayToken lte 0><cflocation url="/#url.u#/products/check-out/payment/?e=-2" addtoken="no"><CFABORT></CFIF>


<CFSET form.STRBILLNAME=getDataOnFile.strNameOnCard>
<CFSET form.strExpMonth=LEFT(getDataOnFile.strCCExp,2)>
<CFSET form.strExpYear=RIGHT(getDataOnFile.strCCExp,4)>
<CFSET form.STRBILLSTREET=getDataOnFile.strAddress>
<CFSET form.STRBILLCITY = getDataOnFile.strCity>
<CFSET form.STRBILLCITY = getDataOnFile.strCity>
<CFSET form.INTBILLSTATE=getDataOnFile.intStateID>
<CFSET form.STRBILLZIPCODE=getDataOnFile.strZip>
<CFSET strLast4=getDataOnFile.strLast4>
<CFSET strFirst6=getDataOnFile.strFirst6>
<CFSET strPayToken=getDataOnFile.strPayToken>