<CFOUTPUT>
<form id="dist-agreement" role="form"  data-toggle="validator" method="post" action="/#url.u#/process/theopportunity/information/">
	<input type="hidden" name="intSponsorMemberID" value="#session.MemberID#">
<div class="row">
<div class="col-lg-12">
<CFIF isDefined("e") and e eq 5><p><span style="color:red;">Obligatorios</span></p></CFIF>
<CFIF isDefined("e") and e eq 3><p><span style="color:red;">N&##249;mero Duplicado</span></p></CFIF>
<CFIF isDefined("e") and e eq 4><p><span style="color:red;">Usuario Duplicado</span></p></CFIF>
<p class="text-right sr-only"><strong><span class="red">*</span> Obligatorios</strong></p>
<h3 class="sub-heading">INFORMACI&##211;N DEL PATROCINADOR</h3>
<CFIF session.memberID EQ 1>
<p>(Si T&##249; no tienes un patrocinador, con gusto te podemos asignar uno).</p>
</cfif>
</div>
</div>
<div class="row">
<CFIF session.memberID EQ 1>
<div class="form-group col-sm-4">
<label class="sr-only" for="sponsorname">NOMBRE:</label>
<input type="text" class="form-control input-sm isreq" id="sponsorname" name="strSponsorname" value="#pGetMemberWebsite_Results.strFullName#" placeholder="NOMBRE:">
</div>
<CFELSE>
<div class="form-group col-sm-4">
<label class="sr-only" for="sponsorname">NOMBRE:</label>
#pGetMemberWebsite_Results.strFullName#
</div>
<div class="form-group col-sm-4">
<label class="sr-only" for="sponsorname">No. De Distribuidor:</label>
#pGetMemberWebsite_Results.intMemberID#
</div>	
</cfif>
</div>
<div class="row">
<div class="col-lg-12">
<h3 class="sub-heading">INFORMACI&##211;N DEL SOLICITANTE</h3>
</div>
<cfswitch expression="#e#"> 
<cfcase value="3"> 
<p class="w500 red">
El Seguro social ya existe en el Sistema, favor de verificarlo y enviarlo nuevamente.
</p> 
</cfcase> 
<cfcase value="4"> 
<p class="w500 red">
El Nombre de Usuario ya existe, Favor de cambiarlo y enviarlo nuevamente.
</p> 
</cfcase> 
<cfcase value="2"> 
<p class="w500 red">
Error Favor de tratar nuevamente.
</p> 
</cfcase> 
</cfswitch>
</div>
<div class="row">
<div class="col-sm-4">
<div class="form-group">
<label class="sr-only" for="name"><span class="red">*</span> Nombre:</label>
<input type="text" class="form-control input-sm isreq" id="fname" name="strFName" value="#pGetCartItems_Result.strCartFirstName#"  placeholder="Nombre:">

</div>
<div class="form-group">
<label class="sr-only" for="name"><span class="red">*</span> Apellido:</label>
<input type="text" class="form-control input-sm isreq" id="lname" name="strLName" value="#pGetCartItems_Result.strCartLastName#" placeholder="Apellido:">
</div>
<div class="form-group">
<label class="sr-only" for="email"><span class="red">*</span> Correo  Electr&##242;nico:</label>
<input type="email" class="form-control input-sm isreq" id="email" name="stremail" value="#pGetCartItems_Result.strEmail#" placeholder="Correo  Electr&##242;nico:">
</div>
<div class="form-group">
<label class="sr-only" for="phone"><span class="red">*</span> N&##249;mero de Tel&##232;fono:</label>
<input type="text" class="form-control input-sm isreq" id="phone" name="strPhone" value="#pGetCartItems_Result.strPhone#" placeholder="N&##249;mero de Tel&##232;fono:">
</div>
<div class="form-group">
<label class="sr-only" for="coapplicant">Nombre del Co-Aplicante:</label>
<input type="text" class="form-control input-sm" id="coapplicant" name="strCoAppName" value="#pGetAdditionalInfo_Result.strCoAppName#" placeholder="Nombre del Co-Aplicante:">
</div>
</div>
<div class="col-sm-4">
<div class="form-group">
<label class="sr-only" for="mailaddress"><span class="red">*</span> Direcci&##242;n de env&##236;o:</label>
<input type="text" class="form-control input-sm isreq" id="mailaddress" name="strAddress" value="#pGetCartItems_Result.strCartAddress#" placeholder="Direcci&##242;n de env&##236;o:">
</div>
<div class="form-group">
<label class="sr-only" for="city"><span class="red">*</span> Ciudad:</label>
<input type="text" class="form-control input-sm isreq" id="city" name="strCity" value="#pGetCartItems_Result.strCartCity#" placeholder="Ciudad:">
</div>
<div class="form-group">
<label class="sr-only" for="state"><span class="red">*</span> Estado:</label>
<select id="state" name="intStateid" class="form-control input-sm req-select">

<option value="">Estado</option>
<CFLOOP query="GetStateList">
<option value="#intStateID#" <CFIF intStateid eq pGetCartItems_Result.intCartStateID>selected</CFIF>>#strState#</option>
</CFLOOP>
</select>
</div>
<div class="form-group">
<label class="sr-only" for="zip"><span class="red">*</span> C&##242;digo Postal:</label>
<input type="text" class="form-control input-sm isreq" id="zip" name="strZipcode" value="#pGetCartItems_Result.strCartZip#" placeholder="C&##242;digo Postal:">
</div>
</div>
<div class="col-sm-4">
<div class="form-group">
<label class="sr-only" for="ssn"><span class="red">*</span> Seguro Social:</label>
<input type="text" class="form-control input-sm isreq" id="ssn" name="strSsn" value="#pGetAdditionalInfo_Result.strSSN#" placeholder="Seguro Social:">
</div>
<div class="form-group">
<label class="sr-only" for="fedid">N&##249;mero de Identificaci&##242;n Federal:</label>
<input type="text" class="form-control input-sm" id="fedid" name="strfederalid" value="#pGetAdditionalInfo_Result.strFederalID#" placeholder="N&##249;mero de Identificaci&##242;n Federal:">
</div>
<div class="form-group">
<label class="sr-only" for="dob">Fecha de Nacimiento:</label>
<div id="dp-ex-4" class="input-group date" data-date="12-02-1998" data-date-format="mm/dd/yyyy" data-date-autoclose="true" data-date-start-view="2">
       <input class="form-control" type="text" placeholder="mm/dd/yyyy" id="dtDateOfBirth" name="dtDateOfBirth" <CFIF pGetAdditionalInfo_Result.dtDateOfBirth gt ''>value="#DateFormat(pGetAdditionalInfo_Result.dtDateOfBirth,"mm/dd/yyyy")#"</CFIF>>
		<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
    </div>
</div>
<div class="form-group">
<label class="sr-only" for="dob">Nombre de Usuario:</label>
<input type="text" class="form-control input-sm isreq" id="strUserName" name="strUserName" <CFIF pGetAdditionalInfo_Result.strUserName gt ''>value="#pGetAdditionalInfo_Result.strUserName#"</CFIF>placeholder="Nombre de Usuario:">
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
<button type="reset" class="btn btn-primary btn-sm">Borrar Contenido</button>
<button type="submit" class="btn btn-primary btn-sm">CONTINUE &raquo;</button>
</p>

</div>
</div>
</form>
</CFOUTPUT>