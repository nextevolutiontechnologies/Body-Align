<CFOUTPUT>
<form id="dist-agreement" role="form"  data-toggle="validator" method="post" action="/#url.u#/process/theopportunity/information/">
	<input type="hidden" name="intSponsorMemberID" value="#session.MemberID#">
<div class="row">
<div class="col-lg-12">
<CFIF isDefined("e") and e eq 5><p><span style="color:red;">All Fields Required</span></p></CFIF>
<CFIF isDefined("e") and e eq 3><p><span style="color:red;">DUP SSN</span></p></CFIF>
<CFIF isDefined("e") and e eq 4><p><span style="color:red;">DUP username</span></p></CFIF>
<p class="text-right sr-only"><strong><span class="red">*</span> REQUIRED FIELDS</strong></p>
<h3 class="sub-heading">SPONSOR INFORMATION</h3>
<CFIF session.memberID EQ 1>
<p>(If you do not have a sponsor, please allow the Home Office to assign you a sponsor.)</p>
</cfif>
</div>
</div>
<div class="row">
<CFIF session.memberID EQ 1>
<div class="form-group col-sm-4">
<label class="sr-only" for="sponsorname">NAME:</label>
<input type="text" class="form-control input-sm isreq" id="sponsorname" name="strSponsorname" value="#pGetMemberWebsite_Results.strFullName#" placeholder="NAME:">
</div>
<CFELSE>
<div class="form-group col-sm-4">
<label class="sr-only" for="sponsorname">NAME:</label>
#pGetMemberWebsite_Results.strFullName#
</div>
<div class="form-group col-sm-4">
<label class="sr-only" for="sponsorname">RepID ##:</label>
#pGetMemberWebsite_Results.intMemberID#
</div>	
</cfif>
</div>
<div class="row">
<div class="col-lg-12">
<h3 class="sub-heading">APPLICANT INFORMATION</h3>
</div>
<cfswitch expression="#e#"> 
<cfcase value="3"> 
<p class="w500 red">
SSN exist in the system, please correct and submit again.
</p> 
</cfcase> 
<cfcase value="4"> 
<p class="w500 red">
User Name exist in the system, please correct and submit again.
</p> 
</cfcase> 
<cfcase value="2"> 
<p class="w500 red">
Error, please try again.
</p> 
</cfcase> 
</cfswitch>
</div>
<div class="row">
<div class="col-sm-4">
<div class="form-group">
<label class="sr-only" for="name"><span class="red">*</span> First Name:</label>
<input type="text" class="form-control input-sm isreq" id="fname" name="strFName" value="#pGetCartItems_Result.strCartFirstName#"  placeholder="FIRST NAME:">

</div>
<div class="form-group">
<label class="sr-only" for="name"><span class="red">*</span> Last Name:</label>
<input type="text" class="form-control input-sm isreq" id="lname" name="strLName" value="#pGetCartItems_Result.strCartLastName#" placeholder="LAST NAME:">
</div>
<div class="form-group">
<label class="sr-only" for="email"><span class="red">*</span> EMAIL ADDRESS:</label>
<input type="email" class="form-control input-sm isreq" id="email" name="stremail" value="#pGetCartItems_Result.strEmail#" placeholder="EMAIL ADDRESS:">
</div>
<div class="form-group">
<label class="sr-only" for="phone"><span class="red">*</span> CONTACT PHONE:</label>
<input type="text" class="form-control input-sm isreq" id="phone" name="strPhone" value="#pGetCartItems_Result.strPhone#" placeholder="CONTACT PHONE:">
</div>
<div class="form-group">
<label class="sr-only" for="coapplicant">CO-APPLICANT NAME:</label>
<input type="text" class="form-control input-sm" id="coapplicant" name="strCoAppName" value="#pGetAdditionalInfo_Result.strCoAppName#" placeholder="CO-APPLICANT NAME:">
</div>
</div>
<div class="col-sm-4">
<div class="form-group">
<label class="sr-only" for="mailaddress"><span class="red">*</span> MAILING ADDRESS:</label>
<input type="text" class="form-control input-sm isreq" id="mailaddress" name="strAddress" value="#pGetCartItems_Result.strCartAddress#" placeholder="MAILING ADDRESS:">
</div>
<div class="form-group">
<label class="sr-only" for="city"><span class="red">*</span> CITY:</label>
<input type="text" class="form-control input-sm isreq" id="city" name="strCity" value="#pGetCartItems_Result.strCartCity#" placeholder="CITY:">
</div>
<div class="form-group">
<label class="sr-only" for="state"><span class="red">*</span> STATE:</label>
<select id="state" name="intStateid" class="form-control input-sm req-select">

<option value="">STATE</option>
<CFLOOP query="GetStateList">
<option value="#intStateID#" <CFIF intStateid eq pGetCartItems_Result.intCartStateID>selected</CFIF>>#strState#</option>
</CFLOOP>
</select>
</div>
<div class="form-group">
<label class="sr-only" for="zip"><span class="red">*</span> ZIP CODE:</label>
<input type="text" class="form-control input-sm isreq" id="zip" name="strZipcode" value="#pGetCartItems_Result.strCartZip#" placeholder="ZIP CODE:">
</div>
</div>
<div class="col-sm-4">
<div class="form-group">
<label class="sr-only" for="ssn"><span class="red">*</span> SSN ##:</label>
<input type="text" class="form-control input-sm isreq" id="ssn" name="strSsn" value="#pGetAdditionalInfo_Result.strSSN#" placeholder="SSN ##:">
</div>
<div class="form-group">
<label class="sr-only" for="fedid">FEDERAL ID ##:</label>
<input type="text" class="form-control input-sm" id="fedid" name="strfederalid" value="#pGetAdditionalInfo_Result.strFederalID#" placeholder="FEDERAL ID ##:">
</div>
<div class="form-group">
<label class="sr-only" for="dtDateOfBirth">DATE OF BIRTH: mm/dd/yyyy</label>
    <div id="dp-ex-4" class="input-group date" data-date="12-02-1998" data-date-format="mm/dd/yyyy" data-date-autoclose="true" data-date-start-view="2">
       <input class="form-control" type="text" placeholder="mm/dd/yyyy" id="dtDateOfBirth" name="dtDateOfBirth" <CFIF pGetAdditionalInfo_Result.dtDateOfBirth gt ''>value="#DateFormat(pGetAdditionalInfo_Result.dtDateOfBirth,"mm/dd/yyyy")#"</CFIF>>
		<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
    </div>
</div>
<div class="form-group">
<label class="sr-only" for="dob">User Name:</label>
<input type="text" class="form-control input-sm isreq" id="strUserName" name="strUserName" <CFIF pGetAdditionalInfo_Result.strUserName gt ''>value="#pGetAdditionalInfo_Result.strUserName#"</CFIF>placeholder="USER NAME:">
</div>
</div>

</div>
<div class="row">
<div class="col-lg-12">
<p>
<cfoutput>#pGetPageContent_Result.strContentText3#</cfoutput>
</p>
</div>
</div>
<div class="row">
<div class="col-lg-12">

<h4><CFOUTPUT> #pGetCartItems_Result.strProduct# - #DollarFormat(pGetCartItems_Result.amtUnit)#</CFOUTPUT></h4>
<CFOUTPUT>
<input type="hidden" name="intCompID" value="#cid#">
</CFOUTPUT>
</div>
</div>

<p class="text-right">
<button type="reset" class="btn btn-primary btn-sm">RESET FORM</button>
<button type="submit" class="btn btn-primary btn-sm">CONTINUE &raquo;</button>
</p>

</div>
</div>
</form>
</CFOUTPUT>