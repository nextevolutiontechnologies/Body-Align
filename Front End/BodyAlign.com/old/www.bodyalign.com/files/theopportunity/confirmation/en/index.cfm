<CFOUTPUT>
<form name="CustomerForm" id="CustomerForm" action="/files/process/shop-now/complete/" method="post">
<table class="table table-bordered">
<thead>
<tr>
<th>items to buy</th>
<th class="text-center"> Quantity</th>
<th class="text-right"> Price</th>
<th class="text-right"> Total</th>
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
<td class="text-center"><!---<input type="number" name="pcs" value="#Quantity#" class="form-control center-block qty" disabled>--->
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
<li><strong> Shipping</strong>:  #dollarformat(pGetOrderInfo_Result.amtShipping)#</li>
<li><strong> Tax</strong>:  #dollarformat(pGetOrderInfo_Result.amtTax)#</li>
<li class="lead"><strong> Order Total</strong>:  #dollarformat(pGetOrderInfo_Result.amtOrderTotal)#</li>
</ul>
</td>
</tr>
</tbody>
</table>
</div>
<div class="col-sm-5 well">
<h3 class="first-child">Shipping Information</h3>                
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
<h3>Payment Information</h3>
<p>
<strong> Credit Card ##:</strong>
<br>
XXXX XXXX XXXX #pGetOrderInfo_Result.strLast4#
<br>
<strong> Name on Card:</strong>
<br>
#pGetOrderInfo_Result.STRNAMEONCARD#
<br>
<strong>Exp Date(MM/YY):</strong>
<br>
#pGetOrderInfo_Result.STREXP#
<br>
<br>
<br>
<strong> Mailing Address:</strong>
<br>
#pGetOrderInfo_Result.STRBILLINGADDRESS# #pGetOrderInfo_Result.STRBILLINGADDRESS2#
<br>
#pGetOrderInfo_Result.STRBILLINGCITY# #pGetOrderInfo_Result.STRBILLINGSTATE# #pGetOrderInfo_Result.STRBILLINGZIP#
<br>
</p>
</form>
</CFOUTPUT>