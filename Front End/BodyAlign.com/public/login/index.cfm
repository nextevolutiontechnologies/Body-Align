

<CFIF isDefined("form.strUserName") and isDefined("form.strpassword")>
	<CFINVOKE component="global.cfc.SecureAPI" method="AuthenticateCustomer" returnVariable="AuthenticateCustomer_results">
		<cfinvokeargument name="userName" value="#form.strUserName#">
		<cfinvokeargument name="password" value="#form.strpassword#">
	</CFINVOKE>

	<CFIF AuthenticateCustomer_results gt 0>
	<!--- Check if has not declined order --->
	  <CFQUERY name="getORderData" datasource="#application.datasource#">
	  	select top 1 intORderStatusID, strOrderGUID from [order] with (NOLOCK) where intCustomerID='#AuthenticateCustomer_results#' and intORderTYpeID in (1,5) order by intORderID DESC
	  </CFQUERY>
	  <!--- if has declined order locate to the billing screen --->
	  	<CFIF getOrderData.intOrderStatusID eq 30>
	  		<!---<CFLOCATION url="http://www.mypaycationservices.com/billing/?ordGuid=#getORderData.strOrderGUID#" addToken="no">--->
	  		<CFLOCATION url="/home/relax/" addToken="no">
	  <!--- in case of not declined order --->
	  	<CFELSE>
			<CFSET session.intCustomerID = AuthenticateCustomer_results>
			<cfset This.apikey="M4I9JgESMnqyE4p5SfkbJBEtTKKTHmQc7KlMctBX2WjG10DVGh">
			<cfset This.SharedSec="VAiKlGT1pPkmFtTjyRMqrg==">
			<cfset This.PostURL="https://api.leisureloyalty.com/v3/members">
			<cfset This.SiteID="56">
			<cfset This.datasource='prod_powervida'>
			<cfset dtNow = now() />
			<cfset Data= 'PVC' & AuthenticateCustomer_results & '|' & this.SiteID & '|' & dtNow.getTime()>
			<cfset DataEncrypted = encrypt(Data, this.SharedSec, "AES","base64" )  />
			<cfset DataEncryptedEncoded = URLEncodedFormat(DataEncrypted) />
 			<CFSET retvar = DataEncryptedEncoded>
			<cfheader statuscode="301" statustext="Moved permanently">
			<cfheader name="Location" value="http://platinumtravelclub.leisureloyalty.com/autologin?apiKey=#This.apiKey#&data=#retvar#">
	  	</CFIF>	
	<CFELSE>
	   <!--- check if Username valid, then insert into ACCESS historyhistory table bad login attempt --->
		 
		 <CFLOCATION url="/#SESSION.URL#/relax/?e=-1" addToken="no">
		  	<cfabort>
	</CFIF>
<CFELSE>

	<CFLOCATION url="/#SESSION.URL#/relax//" addToken="no">
	<cfabort>
</CFIF>