<div class="col-sm-4">
<h3 class="primary-font"><cfoutput>#pGetPageContent_ResultCustomerInformation.strContentText1#</cfoutput></h3>
</div>
</div>
</div>
</div>			
<div class="container">
<CFOUTPUT>
<a class="btn btn-color btn-sm continue-shopping" href="/<CFOUTPUT>#url.u#</CFOUTPUT>/products/">&laquo; Contin&uacute;e comprando</a>
<div class="row">
<div class="col-sm-7 shopping-cart">
<h3><!--- Your Shopping Cart --->#pGetPageContent_ResultCustomerInformation.strContentText2#</h3>
<table class="table table-bordered">
<thead>
<tr>
<th>#pGetCartItems_Result.ItemCount# Art&iacute;culos a comprar</th>
<th class="text-center">Cantidad</th>
<th class="text-right">Precio</th>
<th class="text-right">Total</th>
</tr>
</thead>
<tbody>
<CFLOOP query="pGetCartItems_Result">
<tr>
<td>
<img src="/common/product/#session.langcode#/#strProductImg1#" class="img-responsive" alt="#strProduct#">
<div class="item">
#strProduct#
</div>
</td>
<td class="text-center">#Quantity#<!---<input type="number" name="pcs" value="#Quantity#" class="form-control center-block qty" disabled>---></td>
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
</CFLOOP>
<tr>
<td colspan="4">
<ul class="text-right checkout">
<li class="lead"><strong>Subtotal</strong>: #dollarformat(pGetCartItems_Result.amtTotal)#</li>
</ul>
</td>
</tr>
</tbody>
</table>
</div>
</CFOUTPUT>
<CFOUTPUT>
<form name="CustomerForm" id="CustomerForm" action="/#url.u#/process/check-out/shipping/" method="post">
<div class="col-sm-5 well">
<h3 class="first-child">Informaci&oacute;n de Env&iacute;o</h3>
<div class="form-group text-right">
<label for="saveShipInfo">Guarde la informaci&oacute;n de Envio</label>&nbsp; 
<input name="saveShipInfo" type="checkbox" value="1" <CFIF isDefined("GetCartInfo.isShippingOnFile") and GetCartInfo.isShippingOnFile eq 1>checked</CFIF>/>
</div>
<cfif AddressDropdownList.recordcount gt 0 and session.CustID gt 0>
<div class="form-group">
<label for="selectAddr">Seccione la Dirrecc&iacute;on de Env&iacute;o:</label>
<select id="selectCustomerAddr" name="selectCustomerAddr" class="form-control req-select" onChange="getformdate('shipping');">
<option value="0">Nueva Direcci&oacute;n</option>                  
<cfloop query="AddressDropdownList">
<option value="#intAddressID#">#strAddress#</option>
</cfloop>
</select>
</div>
</cfif>
<div class="form-group">
<label class="sr-only" for="name"><span class="red">*</span> Nombre:</label>
<input type="text" class="form-control isreq" id="strFirstName" name="strFirstName" placeholder="Nombre:" value="#GetCartInfo.STRCARTFIRSTNAME#">
</div>
<div class="form-group">
<label class="sr-only" for="name"><span class="red">*</span> Apellido:</label>
<input type="text" class="form-control isreq" id="strLastName" name="strLastName" placeholder="Apellido:" value="#GetCartInfo.STRCARTLASTNAME#">
</div>
<div class="form-group">
<label class="sr-only" for="address1"><span class="red">*</span> Primera Direcci&oacute;n:</label>
<input type="text" class="form-control isreq" id="STRADDRESS1" name="strAddress1" placeholder="Primera Direcci&oacute;n:" value="#GetCartInfo.STRCARTADDRESS#">
</div>
<div class="form-group">
<label class="sr-only" for="address2"><span class="red">*</span> Segunda Direcci&oacute;n:</label>
<input type="text" class="form-control" id="STRADDRESS2" name="strAddress2" placeholder="Segunda Direcci&oacute;n:" value="#GetCartInfo.STRCARTADDRESS2#">
</div>
<div class="form-group">
<label class="sr-only" for="city"><span class="red">*</span> Ciudad:</label>
<input type="text" class="form-control isreq" id="STRCITY" name="strCity" placeholder="Ciudad:"  value="#GetCartInfo.STRCARTCITY#">
</div>
<div class="form-group">
<label class="sr-only" for="state"><span class="red">*</span> Estado:</label>
<select id="intStateID" name="intStateID" class="form-control req-select">
<option value="">Estado</option>
<CFLOOP query="GetStateList">
<option value="#intStateID#" <CFIF GetCartInfo.INTCARTSTATEID  eq GetStateList.intStateID>selected</CFIF>>#strState#</option>
</CFLOOP>
</select>
</div>
<div class="form-group">
<label class="sr-only" for="zip"><span class="red">*</span> C&oacute;digo Postal:</label>
<input type="text" class="form-control isreq" id="STRZIPCODE" name="strZipCode" placeholder="C&oacute;digo Postal:" value="#GetCartInfo.STRCARTZIP#">
</div>
<div class="form-group">
<label class="sr-only" for="phone"><span class="red">*</span> Tel&eacute;fono:</label>
<input type="text" class="form-control" id="strPhone" name="strPhone" placeholder="Tel&eacute;fono:" value="#GetCartInfo.strPhone#">
</div>           
</div>
<div class="form-group text-right xs-margRight20">
<button type="submit" id="submit-btn" name="submit-btn" class="btn btn-color"> Continue a Pagar &raquo;</button>
</div>
</form>
</CFOUTPUT>