<cfoutput>  
<div class="col-sm-7 shopping-cart">
<a class="btn btn-color btn-sm" href="/<CFOUTPUT>#url.u#</CFOUTPUT>/products/">&laquo;  Contin&uacute;e comprando</a>
<h3><cfoutput>#pGetPageContent_Info.strContentText2#</cfoutput></h3>
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
<img src="/common/product/#session.langcode#/#strProductImg1#" class="img-responsive" alt="#strProduct#">
<div class="item">
#strProduct#
</div>
</td>
<td class="text-center">#Quantity#</td>
<td class="text-right">
<CFIF amtYourPrice LT AmtUnit>
	<span class="old">#DollarFormat(AmtUnit)#</span>
	<BR><span class="new">#DollarFormat(amtYourPrice)#</span>
	<BR> #NumberFormat(amtDetailDiscountRate*100, "__")# % off
<CFELSE>
	<span class="new">#DollarFormat(AmtUnit)#</span>
</cfif></td>
<td class="text-right">#DollarFormat(subtotal)#</td>
</tr>
</cfloop>
<tr>
<td colspan="4">
<ul class="text-right checkout">
<li><strong>Subtotal</strong>: <cfoutput>#dollarformat(pGetCartItems_Result.AMTSUBTOTAL)#</cfoutput></li>
<li><strong>Env&iacute;o</strong>: #dollarformat(pGetCartItems_Result.AMTSHIPPING)#
</li>
<li><strong>Impuesto</strong>: #dollarformat(pGetCartItems_Result.AMTTAX)#
</li>
<li class="lead"><strong>Total de Orden</strong>: #dollarformat(pGetCartItems_Result.AMTTOTAL)#
</li>
</ul>
</td>
</tr>
</tbody>
</table>
</div>

</CFOUTPUT>
<CFOUTPUT>
<form id="CustomerForm" name="pvcheckout" enctype="application/x-www-form-urlencoded" method="post" action="/#url.u#/process/check-out/payment/" role="form">
<input id="whichBn" type="hidden" name="whichBn" value="">
<input id="pmtselected" type="hidden" name="pmtselected">
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
<span id="STRCITY">#pGetCartItems_Result.STRCARTCITY#</span>, <span id="STRSTATECODE">#pGetCartItems_Result.STRCARTSTATECODE#</span><span id="STRZIPCODE"> #pGetCartItems_Result.STRCARTZIP#</span>               
<br>
<span id="">#pGetCartItems_Result.strphone#</span>
</span>
<a href="/#url.u#/products/check-out/customer/?editshipping=1" class="btn btn-green btn-sm pull-right">&laquo; Edite el Env&iacute;o</a>
</p>
<hr>

<h3>Informaci&oacute;n de Pago</h3>
<!--- <cfif getCustomerBilling.recordcount gt 0>
<div class="form-group">
<label for="selectedCard">Select Credit Card:</label>

<select id="intcustomerbillingID" name="intCustomerBillingID" class="form-control req-select" onChange="getformdate();">
<option value="0">Select Card</option>
<cfloop query="getCustomerBilling">
<option value="#intCustomerBillingID#" <cfif currentrow eq pGetCustomerInfo_Result.recordcount>selected</cfif>>Card #strfirst6# #strlast4#</option>
</cfloop>                   
</select>
</div>
</cfif> --->
<CFIF isDefined("getDataOnFile") and getDataOnFile.RecordCount gt 0> 
<ul class="nav nav-pills nav-primary" id="myTab2">
<li class="dropdown active">
<a data-toggle="dropdown" class="dropdown-toggle" id="myTabDrop2" href="javascript:;">
Seleccione Metodo de Pago <b class="caret"></b>
</a>
<ul aria-labelledby="myTabDrop1" role="menu" class="dropdown-menu" id="pmtselection">
<li class="active"><a data-toggle="tab" tabindex="-1" href="##credit-card">Tarjeta de Cr&eacute;dito</a></li>  

	<li><a data-toggle="tab" tabindex="-1" href="##pay-at-pickup">Tarjetas en Archivo</a></li>


</ul>
</li>
</ul>
</CFIF>
<hr>
<div class="tab-content" id="myTab2Content">
<div id="credit-card" class="tab-pane fade in active">
<div class="form-group text-right">
<label for="savePaymentInfo">Guarde su Infomaci&oacute;n de Pago</label>&nbsp; 
<input name="savePaymentInfo" type="checkbox" value="1" />
</div>

<div class="form-group">
<label class="sr-only" for="ccnumber">Tarjeta de Cr&eacute;dito ##:</label>
<input type="text" class="form-control isreq" id="ccnumber" name="ccnumber" maxlength="16" placeholder="Tarjeta de Cr&eacute;dito ##:">
</div>
<div class="form-group">
<label class="sr-only" for="nameoncard">Nombre en la Tarjeta:</label>
<input type="text" class="form-control isreq" id="strbillname" name="strbillName" placeholder="Nombre en la Tarjeta:" value="#GetBillInfo.strNameOnCard#">
</div>

<div class="form-group">
	<div class="row">
		<div class="col-md-6">
		<label class="sr-only" for="strExpMonth"><span class="red">*</span> Mes de Expiraci&oacute;n:</label>
		<select id="strExpMonth" name="strExpMonth" class="form-control input-sm isreq req-select">
		<option value="" >Mes de Expiraci&oacute;n:</option>
		
		<option value="01" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "01">SELECTED</cfif>>Jan</option>
		<option value="02" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "02">SELECTED</cfif>>Feb</option>
		<option value="03" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "03">SELECTED</cfif>>Mar</option>
		<option value="04" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "04">SELECTED</cfif>>Apr</option>
		<option value="05" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "05">SELECTED</cfif>>May</option>
		<option value="06" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "06">SELECTED</cfif>>Jun</option>
		<option value="07" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "07">SELECTED</cfif>>Jul</option>
		<option value="08" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "08">SELECTED</cfif>>Aug</option>
		<option value="09" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "09">SELECTED</cfif>>Sep</option>
		<option value="10" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "10">SELECTED</cfif>>Oct</option>
		<option value="11" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "11">SELECTED</cfif>>Nov</option>
		<option value="12" <CFIF LEFT(GetBillInfo.strCCExp,2) EQ "12">SELECTED</cfif>>Dec</option>
		</select>
      </div>
	
	<!--- <div class="form-group">--->
		<div class="col-md-6">
		<label class="sr-only" for="strExpYear"><span class="red">*</span> A&ntilde;o de Expiraci&oacute;n:</label>
		<select id="strExpYear" name="strExpYear" class="form-control input-sm isreq req-select">
		<option value="" >A&ntilde;o de Expiraci&oacute;n:</option>
		<CFSET thisYear = DateFormat(Now(),"yyyy")>
		<CFSET EndYear = ThisYear + 20>
		<CFLOOP from="#Thisyear#" to="#EndYear#" index="strYear" >
		<option value="#strYear#" <CFIF RIGHT(GetBillInfo.strCCExp,4) EQ strYear>SELECTED</cfif>>#strYear#</option>
		</CFLOOP>
		</select>
		</div>
	</div>
	</div>
	
<div class="form-group">
<label class="sr-only" for="ccv">CCV ##:</label>
<input type="text" class="form-control isreq" id="ccv" name="ccv" maxlength="4" placeholder="CCV ##:">
</div>
<div class="form-group">
<label class="sr-only" for="mailaddress"><span class="red">*</span> Direcci&oacute;n de Env&iacute;o:</label>
<input type="text" class="form-control isreq" id="strbillstreet" name="strBillStreet" placeholder="Direcci&oacute;n de Env&iacute;o:"  value="#GetBillInfo.strBillingAddress#">
</div>
<div class="form-group">
<label class="sr-only" for="city2"><span class="red">*</span> Ciudad:</label>
<input type="text" class="form-control isreq" id="strbillcity" name="strBillCity" placeholder="Ciudad:" value="#GetBillInfo.strBillingCity#">
</div>
<div class="form-group">
<label class="sr-only" for="state2"><span class="red">*</span> Estado:</label>
<select id="intbillstate" name="intBillState" class="form-control isreq req-select">
<option value="" selected>Estado</option>
<CFLOOP query="GetStateList">
<option value="#intStateID#" <CFIF GetBillInfo.intBillingStateID eq GetStateList.intStateID>selected</CFIF>>#strState#</option>
</CFLOOP>
</select>
</div>
<div class="form-group">
<label class="sr-only" for="strzip"><span class="red">*</span> C&oacute;digo Postal:</label>
<input type="text" class="form-control isreq" id="STRZIPCODE" name="strBillZipCode" placeholder="C&oacute;digo Postal:" value="#GetBillInfo.strBillingZip#">
</div>
<div class="form-group">
<label class="sr-only" for="email"><span class="red">*</span> Su correo Eletr&oacute;nico:</label>
<input type="email" class="form-control isreq" id="stremail" name="strEmail" placeholder="Su correo Eletr&oacute;nico:" value="#GetBillInfo.strEmail#">
</div>
</div>


<div id="pay-at-pickup" class="tab-pane fade">
<h3>Tarjetas en Archivo</h3>
<CFIF isDefined("getDataOnFile") and getDataOnFile.RecordCount gt 0>
<div class="form-group">
	<div class="alert alert-info">
           <label class="control-label">
                Seleccione su tarjeta</label>
		<CFLOOP query="getDataOnFile">
			<label class="radio">
              <input value="#ID#" type="radio" name="billingidonfile" <CFIF CURRENTROW eq 1>checked</CFIF>>XXXX XXXX XXXX #strLast4#
			</label>
		</CFLOOP>
    </div>
</div>
<div class="form-group">
	<label for="ccv" class="sr-only">CCV ##:</label>
	<input type="text" placeholder="CCV ##:" maxlength="4" name="ccv1" id="ccv1" class="form-control input-sm isreq" data-bv-field="ccv">
</div>
</CFIF>
</div>
</div>


<div class="form-group text-right xs-margRight20">
<button type="submit" id="submit-btn" name="submit-btn" class="btn btn-color"> Completa esta Orden &raquo;</button>
</div>
</form>
</CFOUTPUT>