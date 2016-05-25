<CFINCLUDE template="/public/global_header.cfm">
<CFINCLUDE template="/public/header.cfm">
<cfoutput>

<cfif pGetCartItems_Result.recordcount eq 1 and pGetCartItems_Result.quantity eq 0 or pGetCartItems_Result.quantity eq ''>
<section class="page-title page-title-4 bg-secondary">
<cflocation url="/" addtoken="false" >
</section>
</cfif>
<div id="wrap">
<section class="content-1-5 content-block">
<div class="container">
<div id="header">
<div id="body">
<div class="row">
<div class="col-md-6">
<h1 class="page-header">CHECKOUT
</h1>
</div>
<div class="col-md-6 text-right">
<cfoutput>
<ol class="breadcrumb breadcrumb-2">
<li>
<a href="/#url.u#/">Home</a>
</li>
<li class="active">CHECKOUT</li>
</ol>
</cfoutput>
</div>
</div><!--end of row-->

</div>
</div><!--end header -->
</div><!--end of container-->
</section>

<section>
<div class="container">
<div class="row">
<div class="col-md-9 col-md-offset-0 col-sm-10 col-sm-offset-1">
<table class="table cart mb48">
<thead>
<tr>
<th>Product</th>
<th>Description</th>
<th>Quantity</th>
<th>Price</th>
</tr>
</thead>
<tbody>

<cfloop query="pGetCartItems_Result">
<tr>
<td>
<a href="##"><img alt="Product" class="product-thumb" src="/files/img/products/#strURLFriendly#.png" /></a>
</td>
<td>
<span>#strProduct#</span>
</td>
<td>
<form method="post" action="/#url.u#/checkout/updateremove/" id="ProductUpdate#currentrow#" name="ProductUpdate#currentrow#" >
<input type="hidden" value="#intProductID#" name="intProductID">
<input type="hidden" value="#intCart_DetailID#" name="intCartDetailID">
<cfif pGetCartItems_Result.intCartTypeID eq 1>
<input style="width: 80px; font-size: 13px;margin:0px auto;" value="#quantity#" min="1" class="form-control cart-qty" type="number" id="pcs#currentrow#" name="pcs"/>
<button type="submit" name="Remove" class="qty-btn">Remove</button><button type="submit" name="Update" class="qty-btn" >Update</button>
<cfelse>
<input type="hidden" name="pcs" value="1">
<input style="width: 80px; font-size: 13px;margin:0px auto;" value="#quantity#" min="1" max="1" class="form-control cart-qty" disabled type="text" id="pcs#currentrow#" name="pcs"/>
</cfif>
</form>
</td>
<td>
<span>#dollarformat(subTotal)#</span>
</td>
</tr>
</cfloop>

</tbody>
</table>
<!---<form class="thirds text-center mb-xs-24" id="form-coupon">
<h5 class="uppercase">Add a coupon code</h5>
<input type="text" placeholder="Coupon Code" name="coupon" id="coupon"/>
<input class="hollow" type="submit" value="Apply" />
</form>--->
</div><!--end of items-->
<div class="col-md-3 col-md-offset-0 col-sm-10 col-sm-offset-1">
<form action="/#url.u#/checkout/shipandTax/" id="formZip" name="formZip" class="bv-form" method="post" >
<div class="mb-xs-24">
<h5 class="uppercase">Calculate Shipping</h5>
<div id="shipping-message"></div>
<div class="select-option form-group">
<input type="text" id="strCartZip" placeholder="Zip/Postal Code"  name="strCartZip" value="#trim(pGetCartItems_Result.strCartZip)#" required onchange="$('##sec-total').hide();" maxlength="10"/>
</div><!--end select-->
<button type="submit" class="hollow" >Calculate Shipping</button>
</div>
</form>
<div class="mb24" >

<h5 class="uppercase">Your Order Total</h5>
<table class="table">
<tbody>
<tr>
<th scope="row">Cart Subtotal</th>
<td>#dollarformat(pGetCartItems_Result.amtSubtotal)#</td>
</tr>
<tr>
<th scope="row">Shipping</th>
<td>#dollarformat(pGetCartItems_Result.amtShipping)#</td>
</tr>
<tr>
<th scope="row">Tax</th>
<td>#dollarformat(pGetCartItems_Result.amtTax)#</td>
</tr>
<tr>
<th scope="row">Order Total</th>
<td>
<strong>#dollarformat(pGetCartItems_Result.amtTotal)#</strong>
</td>
</tr>
</tbody>
</table>
<cfif pGetCartItems_Result.strCartZip gt ""  and not isdefined("url.qu")>
<span id="sec-total" >
<a href="/#url.u#/checkout/payment/" class="submit-btn" >Proceed To Payment</a>
</span>
</cfif>
</div>
</div><!--end of totals-->
</div>
</div><!--end of container-->
</section>
</div>
</cfoutput>
<CFINCLUDE template="js.cfm">
<CFINCLUDE template="/public/footer.cfm">
<CFINCLUDE template="/public/global_footer.cfm">
