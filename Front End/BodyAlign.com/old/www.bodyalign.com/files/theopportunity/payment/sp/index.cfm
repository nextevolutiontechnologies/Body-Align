<CFOUTPUT>
<form id="paymentinfo" name="paymentinfo" enctype="application/x-www-form-urlencoded" method="post" action="#application.Protocol##cgi.seRVER_NAME#/#url.u#/process/theopportunity/payment/" role="form">
	  
<div class="col-sm-7 shopping-cart">
<h3>#pGetPageContent_Result.strContentText2#</h3>
<table class="table table-bordered">
<thead>
<tr>
<th>Art&iacute;culos a comprar</th>
<th class="text-center">Cantidad</th>
<th class="text-right">Precio</th>
<th class="text-right">Total</th>
</tr>
</thead>
<tbody>
<cfloop query="pGetCartItems_Result">            
<tr>
<td>
<!---<img class="img-responsive" src="/img/products/#strProductIMG#" alt="#strProduct#">--->

<div class="item">
<!--- <img class="img-responsive" src="/img/products/default-kit.jpg" alt="Default Kit"> --->
<img class="img-responsive" src="/common/product/#session.langcode#/#STRPRODUCTIMG1#" alt="#strProduct#">

#strProduct#
</div>
</td>
<td class="text-center">#Quantity#</td>
<td class="text-right">#DollarFormat(AmtUnit)#</td>
<td class="text-right">#DollarFormat(AmtUnit*Quantity)#</td>
</tr>
</cfloop>
<tr>
<td colspan="4">
<ul class="text-right checkout">
<li><strong>Subtotal</strong>: <cfoutput>#dollarformat(pGetCartItems_Result.subtotal)#</cfoutput></li>
<li><strong>Env&iacute;o</strong>: #dollarformat(pGetCartItems_Result.AMTSHIPPING)#
</li>
<li><strong>Impuesto</strong>: #dollarformat(pGetCartItems_Result.AMTTAX)#
</li>
<li class="lead"><strong>Total de la Orden</strong>: #dollarformat(pGetCartItems_Result.AMTTOTAL)#
</li>
</ul>
</td>
</tr>
</tbody>
</table>
</div>
<input id="whichBn" type="hidden" name="whichBn" value="">
<div class="col-sm-5 well">
<h3 class="first-child">Informaci&oacute;n de Env&iacute;o</h3>
<p class="clearfix">
<span class="pull-left">
<span id="STRFIRSTNAME">#pGetCartItems_Result.STRCARTFIRSTNAME#</span>
<span id="STRLASTNAME">#pGetCartItems_Result.STRCARTLASTNAME#</span>
<br>
<span id="STRADDRESS1">#pGetCartItems_Result.STRCARTADDRESS#</span>
<br>
<CFIF pGetCartItems_Result.STRCARTADDRESS2 GT ''>
<span id="STRADDRESS2">#pGetCartItems_Result.STRCARTADDRESS2#</span>
<br>
</cfif>
<span id="STRSTATE">#pGetCartItems_Result.STRCARTCITY#</span>, <span id="STRSTATECODE">#pGetCartItems_Result.STRCARTSTATECODE#</span><span id="STRZIPCODE"> #pGetCartItems_Result.STRCARTZIP#</span>               
<br>
<span id="">#pGetCartItems_Result.strphone#</span>
</span>
<a href="/#url.u#/theopportunity/information/?editshipping=1" class="btn btn-green btn-sm pull-right">&laquo; Edite el Env&iacute;o</a>
</p>
<hr>
<CFSWITCH expression="#url.e#" >
<CFCASE value="1">
<div class="alert alert-success">
<button type="button" class="close" data-dismiss="alert">X</button>
<strong>Felicitaciones!</strong> Completo con &eacute;x&iacute;to sus datos de contacto.
</div>
</CFCASE>
<CFCASE value="-1">
<div class="alert alert-danger">
<button type="button" class="close" data-dismiss="alert">X</button>
<strong>Pago rechazado</strong>
</div>
</CFCASE> 
</cfswitch>
<h3>Informaci&oacute;n de Pago</h3>
<div class="form-group text-right">
<label for="savePaymentInfo">Guarde la Informaci&oacute;n de Pago</label>&nbsp; 
<input name="savePaymentInfo" type="checkbox" value="1" />
</div>
<div class="form-group">
<label class="sr-only" for="ccnumber">## de Tarjeta de Cr&eacute;dito:</label>
<input type="text" class="form-control isreq" id="ccnumber" name="ccnumber" maxlength="16" placeholder="## de Tarjeta de Cr&eacute;dito:">
</div>
<div class="form-group">
<label class="sr-only" for="nameoncard">Nombre en la Tarjeta:</label>
<input type="text" class="form-control isreq" id="strbillname" name="strbillName" maxlength="200" placeholder="Nombre en la Tarjeta:" value="#GetBillingInfo.strNameonCard#">
</div>
<div class="form-group">
<label class="sr-only" for="strExpMonth"><span class="red">*</span> Mes de Expiraci&oacute;n:</label>
<select id="strExpMonth" name="strExpMonth" class="form-control input-sm isreq req-select">
<option value="" >Mes de Expiraci&oacute;n:</option>

<option value="01" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "01">SELECTED</cfif>>Jan</option>
<option value="02" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "02">SELECTED</cfif>>Feb</option>
<option value="03" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "03">SELECTED</cfif>>Mar</option>
<option value="04" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "04">SELECTED</cfif>>Apr</option>
<option value="05" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "05">SELECTED</cfif>>May</option>
<option value="06" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "06">SELECTED</cfif>>Jun</option>
<option value="07" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "07">SELECTED</cfif>>Jul</option>
<option value="08" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "08">SELECTED</cfif>>Aug</option>
<option value="09" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "09">SELECTED</cfif>>Sep</option>
<option value="10" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "10">SELECTED</cfif>>Oct</option>
<option value="11" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "11">SELECTED</cfif>>Nov</option>
<option value="12" <CFIF LEFT(GetBillingInfo.strExp,2) EQ "12">SELECTED</cfif>>Dec</option>
</select>
</div>
<div class="form-group">
<label class="sr-only" for="strExpYear"><span class="red">*</span> A&ntilde;o de Expiraci&oacute;n:</label>
<select id="strExpYear" name="strExpYear" class="form-control input-sm isreq req-select">
<option value="" >A&ntilde;o de Expiraci&oacute;n:</option>
<CFSET thisYear = DateFormat(Now(),"yyyy")>
<CFSET EndYear = ThisYear + 20>
<CFLOOP from="#Thisyear#" to="#EndYear#" index="strYear" >
<option value="#strYear#" <CFIF RIGHT(GetBillingInfo.strExp,4) EQ strYear>SELECTED</cfif>>#strYear#</option>
</CFLOOP>
</select>
</div>
<div class="form-group">
<label class="sr-only" for="ccv">CCV ##:</label>
<input type="text" class="form-control isreq" id="ccv" name="ccv" maxlength="4" placeholder="CCV ##:">
</div>
<div class="form-group">
<label class="sr-only" for="mailaddress"><span class="red">*</span> Direcci&oacute;n de Env&Iacute;o:</label>
<input type="text" class="form-control isreq" id="strbillstreet" name="strBillStreet" placeholder="Direcci&oacute;n de Env&Iacute;o:"  value="#GetBillingInfo.strBillingAddress#">
</div>
<div class="form-group">
<label class="sr-only" for="city2"><span class="red">*</span> Ciudad:</label>
<input type="text" class="form-control isreq" id="strbillcity" name="strBillCity" placeholder="Ciudad:" value="#GetBillingInfo.strBillingCity#">
</div>
<div class="form-group">
<label class="sr-only" for="state2"><span class="red">*</span> Estado:</label>
<select id="intbillstate" name="intBillState" class="form-control isreq req-select">
<option value="" selected>Estado:</option>
<CFLOOP query="GetStateList">
<option value="#intStateID#" <CFIF GetBillingInfo.intBillingStateID eq GetStateList.intStateID>selected</CFIF>>#strState#</option>
</CFLOOP>
</select>
</div>
<div class="form-group">
<label class="sr-only" for="strzip"><span class="red">*</span> C&oacute;digo Postal:</label>
<input type="text" class="form-control isreq" id="STRZIPCODE" name="strBillZipCode" placeholder="C&oacute;digo Postal:" value="#GetBillingInfo.strBillingZip#">
</div>
<div class="form-group">
<label class="sr-only" for="email"><span class="red">*</span> Correo Electr&oacute;nico:</label>
<input type="email" class="form-control isreq" id="stremail" name="strEmail" placeholder="Correo Electr&oacute;nico:" value="#GetBillingInfo.strEmail#">
</div>

</div>

<div class="form-group text-right xs-margRight20">
<button type="submit" id="submit-btn" name="submit-btn" class="btn btn-color">Complete la Inscripci&oacute;n &raquo;</button>
</div>
</form>
</CFOUTPUT>