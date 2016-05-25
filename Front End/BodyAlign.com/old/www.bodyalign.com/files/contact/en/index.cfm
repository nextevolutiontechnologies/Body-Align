<CFOUTPUT>
<!--- This is used to keep hacks away from form. JM --->
<cfset csrftoken= CSRFGenerateToken()/> 
<form id="contact-form" role="form" data-toggle="validator" method="post" action="/#url.u#/process/contact/" >
	<input name="csrftoken" type="hidden" value="#csrfToken#">
<div class="form-group">
<label for="strFirstname">First name</label>
<input type="text" class="form-control isreq" id="strFirstname" name="strFirstname" placeholder="Enter First name">
</div>
<div class="form-group">
<label for="strLastname">Last name</label>
<input type="text" class="form-control isreq" id="strLastname" name="strLastname" placeholder="Enter Last name">
</div>
<div class="form-group">
<label for="strEmail">Your email address</label>
<input type="email" class="form-control isreq" id="strEmail" name="strEmail" placeholder="Enter email">
</div>
<div class="form-group">
<label for="strMessage">Your message</label>
<textarea class="form-control" rows="3" id="strMessage" name="strMessage" placeholder="Enter message"></textarea>
</div>
<button type="submit" class="btn btn-lg btn-color"><cfoutput>Send Contact Request</cfoutput></button>
</form>
</CFOUTPUT>