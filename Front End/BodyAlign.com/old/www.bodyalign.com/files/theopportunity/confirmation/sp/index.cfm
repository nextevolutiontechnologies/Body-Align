<CFOUTPUT>
<form name="CustomerForm" id="CustomerForm" action="/files/process/shop-now/complete/" method="post">
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
<CFloop query="pGetOrderInfo_Result">

<tr>
<td>
<cfif FileExists(ExpandPath('/img/products/#strURLFriendly#.jpg'))>
<img class="img-responsive" src="/img/products/#strURLFriendly#.jpg" alt="#strProduct#">
</cfif>
<div class="item">
#strProduct#
</div>
</td>
<td class="text-center">
		#Quantity#</td>
<td class="text-right">#DollarFormat(AmtUnit)#</td>
<td class="text-right">#DollarFormat(AmtUnit*Quantity)#</td>
</tr>
</CFloop>
<tr>
<td colspan="4">
<ul class="text-right checkout">
<li><strong> Subtotal</strong>: #dollarformat(pGetOrderInfo_Result.OrderSUBTOTAL)#
</li>
<li><strong> Envío</strong>:  #dollarformat(pGetOrderInfo_Result.amtShipping)#</li>
<li><strong> Impuesto</strong>:  #dollarformat(pGetOrderInfo_Result.amtTax)#</li>
<li class="lead"><strong> Total de la Orden</strong>:  #dollarformat(pGetOrderInfo_Result.amtOrderTotal)#</li>
</ul>
</td>
</tr>
</tbody>
</table>
</div>
<div class="col-sm-5 well">
<h3 class="first-child">Informaci&oacute;n de Env&iacute;o</h3>                
<p>              
#pGetOrderInfo_Result.STROrderFIRSTNAME# #pGetOrderInfo_Result.STROrderLASTNAME#
<br>               
#pGetOrderInfo_Result.STROrderADDRESS#
<CFIF pGetOrderInfo_Result.STROrderADDRESS2 GT ''>
<br>                 
#pGetOrderInfo_Result.STROrderADDRESS2#
</cfif>
<br>                   
#pGetOrderInfo_Result.STROrderCITY#, #pGetOrderInfo_Result.STROrderSTATECODE# #pGetOrderInfo_Result.STROrderZIP#
<br>              

</p>

<h3>Informaci&oacute;n de Pago</h3>

<p>
<strong>## de Tarjeta de Cr&eacute;dito:</strong>
<br>
XXXX XXXX XXXX #pGetOrderInfo_Result.strLast4#
<br>
<strong>Nombre en la Tarjeta:</strong>
<br>
#pGetOrderInfo_Result.STRNAMEONCARD#
<br>
<strong>Fecha de Expiraci&oacute;n(MM/YY):</strong>
<br>
#pGetOrderInfo_Result.STREXP#
<br>
<br>
<br>
<strong>Direcci&oacute;n de Env&Iacute;o:</strong>
<br>
#pGetOrderInfo_Result.STRBILLINGADDRESS# #pGetOrderInfo_Result.STRBILLINGADDRESS2#
<br>
#pGetOrderInfo_Result.STRBILLINGCITY# #pGetOrderInfo_Result.STRBILLINGSTATE# #pGetOrderInfo_Result.STRBILLINGZIP#
<br>

</p>
</form>
</CFOUTPUT>