<cfoutput>
<div class="container">
<cftry>          
<div class="row">	  
<form name="CustomerForm" id="CustomerForm" action="/files/process/shop-now/complete/" method="post">
<div class="col-sm-7 shopping-cart">
<h3>#pGetPageContent_ResultConfirmation.strContentText2#</h3>
<table class="table table-bordered">
<thead>
<tr>
<th>items to buy</th>
<th class="text-center">Quantity</th>
<th class="text-right">Price</th>
<th class="text-right">Total</th>
</tr>
</thead>
<tbody>
<CFloop query="pGetOrderInfo_Result">
<tr>
<td>
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
<td class="text-right">#DollarFormat(amtItemSubtotal)#</td>
</tr>
</CFloop>
<tr>
<td colspan="4">
<ul class="text-right checkout">
<li><strong>Subtotal</strong>: #dollarformat(pGetOrderInfo_Result.orderSUBTOTAL)#
</li>
<li><strong>Shipping</strong>:  #dollarformat(pGetOrderInfo_Result.amtShipping)#</li>
<li><strong>Tax</strong>:  #dollarformat(pGetOrderInfo_Result.amtTax)#</li>
<li class="lead"><strong>Order Total</strong>:  #dollarformat(pGetOrderInfo_Result.amtOrderTotal)#</li>
</ul>
</td>
</tr>
</tbody>
</table>
</div>
<div class="col-sm-5 well">
<h3 class="first-child">Shipping Information</h3>                
<p>#pGetOrderInfo_Result.strOrderFirstName# #pGetOrderInfo_Result.strOrderLastName#
<br>               
#pGetOrderInfo_Result.strOrderAddress#
<br>
<CFIF pGetOrderInfo_Result.strOrderAddress2 GT ''>
#pGetOrderInfo_Result.strOrderAddress2#
<br></cfif>                     
#pGetOrderInfo_Result.strOrderCity#, #pGetOrderInfo_Result.STROrderSTATECODE# #pGetOrderInfo_Result.STROrderZIP#
<br>              
#pGetOrderInfo_Result.strPhone#
</p>
<h3>Payment Information</h3>
<p>
<strong>Credit Card##:</strong>
<br>
#pGetOrderInfo_Result.strShowCC#
<br>
<strong>Name on Card:</strong>
<br>
#pGetOrderInfo_Result.STRNAMEONCARD#
<br>
<strong>Exp Date(MM/YY):</strong>
<br>
#pGetOrderInfo_Result.STREXP#
<br>
<br>
<strong>Billing Address:</strong>
<br>
#pGetOrderInfo_Result.STRBILLINGADDRESS#
<br>
#pGetOrderInfo_Result.STRBILLINGCITY# #pGetOrderInfo_Result.STRBILLINGSTATE# #pGetOrderInfo_Result.STRBILLINGZIP#
<br>
<strong>Email Address:</strong>
<br>
#pGetOrderInfo_Result.strEmail#
</p>
</div>
</form>
<cflock timeout=20 scope="Session" type="Exclusive">
    <cfset Session.intorderid = 0>
</cflock>
<cflock timeout=20 scope="Session" type="Exclusive">
    <cfset Session.itemcount = 0>
</cflock>
<cflock timeout=20 scope="Session" type="Exclusive">
    <cfset Session.cartid = 0>
</cflock>
<CFIF session.custid gt 0>
<CFCOOKIE name="customerID" value="#session.custid#" expires="NEVER">
</CFIF>
<CFSET session.custid=0>
<cfcatch>
<cfdump var="#cfcatch#">
<cfabort>          
</cfcatch>
</cftry>
</div> <!-- / .row -->
</div> <!-- / .container -->
</CFOUTPUT>