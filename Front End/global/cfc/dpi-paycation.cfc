<cfcomponent displayname="DPI-Paycation" hint="used to connect to DPI system for Paycation">
	<cffunction name="BookingDeskPost" access="public" returnformat="plain" returntype="Any" >
		<cfargument name="intBookingID" type="numeric" Required="yes">
		<cfquery name="GetBookingDesk" datasource="#application.datasource#" >
			SELECT TOP 1 [intBookingID]
		      ,[strBookingNumber]
		      ,[strPassengerEmail]
		      ,[strPassengerName]
		      ,[strPassengerName2]
		      ,[strPassengerName3]
		      ,[strPassengerName4]
		      ,[strPassengerName5]
		      ,[strGroupName]
		      ,[dtTravel]
		      ,[strConfirmationNumber]
		      ,[amtTrip]
		      ,[intBookingStatusID]
		      ,[strPaymentStatus]
		     ,m.strRepID
		      ,[strReferAgentName]
		      ,[strReferAgentID]
		      ,[strNote]
		      ,strVendorName
		      ,[strBookingType]
  			FROM [dbo].[BOOKING] b with (Nolock)
					inner join dbo.MEMBER m with (nolock) on b.intMemberID = m.intMemberID
					inner join dbo.VENDOR v with (nolock) on b.intVendorID = v.intVendorID
			WHERE b.intBookingID = #arguments.intBookingID#
		</cfquery>
		<cfif GetBookingDesk.RecordCount eq 1>
<cfsavecontent variable="XMLDoc">
<cfoutput query="GetBookingDesk" maxrows="1">
<BookingData id="TRVLBOOKING" key="3D2A14EA-37C3-41DB-B429-A6EEA487C498" clientID="#cgi.REMOTE_ADDR#">
<AgentBooking>
<ExternalBookingID>#arguments.intBookingID#</ExternalBookingID>
<ConfID>#strBookingNumber#</ConfID>
<AgentID>#strRepID#</AgentID>
<PassengerEmail>#strPassengerEmail#</PassengerEmail>
<Passenger1Name>#strPassengerName#</Passenger1Name>
<Passenger2Name>#strPassengerName2#</Passenger2Name>
<Passenger3Name>#strPassengerName3#</Passenger3Name>
<Passenger4Name>#strPassengerName4#</Passenger4Name>
<Passenger5Name>#strPassengerName5#</Passenger5Name>
<GroupName>#strGroupName#</GroupName>
<TravelStartDate>#Dateformat(dtTravel,"yyyy-mm-dd")#</TravelStartDate>
<TotalTripAmount>35500.45</TotalTripAmount>
<DepositPaid>2000.00</DepositPaid>
<DepositDate></DepositDate>
<PaymentAmount>0</PaymentAmount>
<NextDueDate></NextDueDate>
<ConfirmationSent>N</ConfirmationSent>
<CommissionRecd>0</CommissionRecd>
<CommissionPercent>0</CommissionPercent>
<CommissionRecdDate></CommissionRecdDate>
<IsCommissionable>0</IsCommissionable>
<TotalCommission>0</TotalCommission>
<CommissionPeriodDate></CommissionPeriodDate>
<CommissionStatus>Open</CommissionStatus>
<SupplierName>#strVendorName#</SupplierName>
<ReferringAgentName></ReferringAgentName>
<ReferringAgentID></ReferringAgentID>
<ReferringAgentCommission>0</ReferringAgentCommission>
<Notes></Notes>
<BookingType>1</BookingType>
</AgentBooking>
</BookingData>
</cfoutput>
</cfsavecontent>

		<cfhttp url="https://uat.secure.paycation.com/webservice/BookingDesk" method="post"  >
			<cfhttpparam type="header" name="content-type" value="text/xml"> 
			<cfhttpparam type="header" name="charset" value="utf-8"> 
			<cfhttpparam type="header" name="Content-Length" value="#len(trim(XMLDoc))#"> 
			<cfhttpparam type="xml" name="body" value="#trim(XMLDoc)#"> 
		</cfhttp>
		
		<cfquery name="UpdateBooking" datasource="#application.datasource#" >
			UPDATE dbo.BOOKING 
			SET strLastAPIReturn = '#cfhttp.fileContent#',dtLastAPIReturn = GETDATE()
			WHERE intBookingID = #arguments.intBookingID#
		</cfquery>
		
		
		<cfreturn cfhttp.StatusCode>
	<cfelse>
		<cfreturn 60666>
		</cfif>
	</cffunction>
</cfcomponent>