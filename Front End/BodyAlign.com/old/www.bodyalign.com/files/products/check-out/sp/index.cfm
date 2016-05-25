<div class="col-sm-4 well new-customer">
<form id="new-customer" enctype="application/x-www-form-urlencoded" method="post" action="<CFOUTPUT>#Application.Protocol##CGI.Server_Name#/#url.u#</CFOUTPUT>/process/check-out/login/" role="form">
<h4 class="first-child">Subtotal de la Orden: <CFOUTPUT>#DollarFormat(orderSubtotal)#</CFOUTPUT></h4>
<p>Impuesto, Costos de Correo, y Especiales van a ser aplicados a la salida.</p>

<a class="btn btn-color btn-sm" href="/<CFOUTPUT>#url.u#</CFOUTPUT>/products/">&laquo; Contin&uacute;e comprando</a>
<hr>
<div class="row">
<div class="col-md-8">
<h4 class="first-child">Clientes Nuevos</h4>
</div>
<div class="col-md-4">
<CFIF not isdefined("session.itemcount") or session.itemcount eq 0>
<a class="btn btn-sm btn-color">Contin&uacute;e &raquo;</a>
<CFELSE>
<a class="btn btn-sm btn-color" href="<CFOUTPUT>#Application.Protocol##CGI.Server_Name#/#url.u#/</CFOUTPUT>products/check-out/customer/">Contin&uacute;e &raquo;</a>
</CFIF>
</div>
</div><!-- / .row -->
<hr>
<h4 class="first-child">Clientes Soy </h4>
<p>Si usted es un cliente de regreso, por favor reg&iacute;strese con su&#8230;</p>
<CFIF isDefined("e") and e eq -1>
<div class="col-sm-12 bg-danger">
<p style="padding-top: 10px;">Ha entrado un nombre de usante o clave incorrecta.</p> 
</div><br><br><br>
</CFIF>
<CFOUTPUT>
<div class="form-group">
<label for="email" class="sr-only">Correo Electr&oacute;nico:</label>
<input class="form-control" type="email" name="email" id="email" placeholder="Correo Electr&oacute;nico" />
</div>
<div class="form-group">
<label for="password" class="sr-only">Clave:</label>
<input class="form-control" type="password" name="password" id="password" placeholder="Clave" />
</div>
</CFOUTPUT>
<CFIF not isdefined("session.itemcount") or session.itemcount eq 0>
<input type="submit" name="submit1" class="btn btn-sm btn-color" value="Contin&uacute;e &raquo;" disabled/>
<CFELSE>
<input type="submit" name="submit1" class="btn btn-sm btn-color" value="Contin&uacute;e &raquo;" />
</CFIF>
</form>
<hr>
<div class="panel-group" id="accordion">
<div class="panel panel-default">
<div class="panel-heading">
<h4 class="panel-title">
Perdi&oacute; su clave? <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#panel1">Haga un clic aqu&iacute; para recuperarla</a>
</h4>
</div>
<!--- Why is this hardcoded to these error? removed isDefined and Paramed at the top. --->
<CFIF e eq -3 or e eq 2>
<div id="panel1" class="panel-collapse collapse in">
<CFELSE>
<div id="panel1" class="panel-collapse collapse">
</CFIF>
<div class="panel-body">
<h4 class="first-child">Se le olvid&oacute; la clave?</h4>
<CFIF e eq -3>
<div class="col-sm-12 bg-danger">
<p style="padding-top: 10px;">
Ha entrado un correo electr&oacute;nico o c&oacute;digo postal incorrecto.
</p> 
</div><br><br><br>
</CFIF>
<CFIF e eq 2>
<div class="col-sm-12 bg-danger">
<p style="padding-top: 10px;">
Su clave se le ha env&iacute;ado a su correo electr&oacute;nico.
</p> 
</div><br><br><br>
</CFIF>
<CFOUTPUT>
<form method="post" action="/#url.u#/process/check-out/forgot-password/">
<div class="form-group">
<label for="email" class="sr-only">Correo Electr&oacute;nico:</label>
<input class="form-control" type="email" name="email" id="email" placeholder="Correo Electr&oacute;nico" />
</div>
<div class="form-group">
<label for="zip-code" class="sr-only">C&oacute;digo Postal:</label>
<input class="form-control" type="text" name="zipcode" id="zip-code" placeholder="C&oacute;digo Postal" />
</div>
<input type="submit" name="submit1" class="btn btn-sm btn-color" value="Contin&uacute;e" />
</form>
</CFOUTPUT>
</div>
</div>
</div>
</div><!--- div accordion close --->
</div>
<div class="col-sm-8 shopping-cart">
<div class="row">
<div class="col-sm-12">
<table class="table table-bordered">
<thead>
<tr>
<CFOUTPUT>
<th>#pGetCartItems_Result.itemcount#  Art&iacute;culos a comprar</th>
<th>Precio</th>
<th>Cantidad</th>
<th>Acci&oacute;n</th>
</CFOUTPUT>
</tr>
</thead>
<CFIF pGetCartItems_Result.intProductID neq ''>
<tbody>
<CFOUTPUT query="pGetCartItems_Result">
<tr>
<CFIF intgroupProductID eq '' or  intProductID eq intgroupProductID >
<form name="ProductUpdate#currentrow#" action="/#url.u#/process/check-out/addtocart/update/" method="post">
<input type="hidden" name="intProductID" value="#intProductID#">
</CFIF>
<td><img src="/common/product/#session.langcode#/#strProductImg1#" class="img-responsive" alt="#strProduct#">
<div class="item">#strProduct#</div>
</td>
<td>

<CFIF amtYourPrice LT AmtUnit>
	<span class="old">#DollarFormat(AmtUnit)#</span>
	<BR><span class="new">#DollarFormat(amtYourPrice)#</span>
	<BR> #NumberFormat(amtDetailDiscountRate*100, "__")# % off
<CFELSE>
	<span class="new">#DollarFormat(AmtUnit)#</span>
</cfif>
</td>
<td><input type="number" name="pcs" value="#Quantity#" min="0" class="form-control qty"></td>
<CFIF intgroupProductID eq '' or intProductID eq intgroupProductID>
<td><input type="submit" name="update" class="btn btn-sm btn-default botMarg5" value="Revisi&oacute;n"><br><input type="submit" name="remove" class="btn btn-sm  btn-default" value="Remover"></td>
</form>
<CFELSE>
<td>&nbsp;</td>
</CFIF>
</tr>
</CFOUTPUT>
</tbody>
</CFIF>
</table>
</div>
</div> <!-- / .row -->
</div>