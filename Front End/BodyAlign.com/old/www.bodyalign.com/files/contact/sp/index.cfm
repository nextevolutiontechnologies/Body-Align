<CFOUTPUT>
<!--- This is used to keep hacks away from form. JM --->
<cfset csrftoken= CSRFGenerateToken()/> 
<form id="contact-form" role="form" data-toggle="validator" method="post" action="/#url.u#/process/contact/" >
	<input name="csrftoken" type="hidden" value="#csrfToken#">
<div class="form-group">
<label for="strFirstname">Nombre</label>
<input type="text" class="form-control isreq" id="strFirstname" name="strFirstname" placeholder="Enter Nombre">
</div>
<div class="form-group">
<label for="strLastname">Apellido</label>
<input type="text" class="form-control isreq" id="strLastname" name="strLastname" placeholder="Enter Apellido">
</div>
<div class="form-group">
<label for="strEmail">Correo electr&oacute;nico</label>
<input type="email" class="form-control isreq" id="strEmail" name="strEmail" placeholder="EnterCorreo electr&oacute;nico">
</div>
<div class="form-group">
<label for="strMessage">Tu mensaje</label>
<textarea class="form-control" rows="3" id="strMessage" name="strMessage" placeholder="Enter message"></textarea>
</div>
<button type="submit" class="btn btn-lg btn-color"><cfoutput>Enviar</cfoutput></button>
</form>
</CFOUTPUT>