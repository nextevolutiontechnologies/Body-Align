<div class="col-sm-4 well new-customer">
<form id="new-customer" enctype="application/x-www-form-urlencoded" method="post" action="<CFOUTPUT>#Application.Protocol##CGI.Server_Name#/#url.u#</CFOUTPUT>/process/check-out/login/" role="form">
<h4 class="first-child">Order Subtotal: <CFOUTPUT>#DollarFormat(orderSubtotal)#</CFOUTPUT></h4>
<p>Tax, Shipping Costs, and Specials will be applied during checkout.</p>
<a class="btn btn-color btn-sm" href="/<CFOUTPUT>#url.u#</CFOUTPUT>/products/">&laquo; Continue Shopping</a>
<hr>
<div class="row">
<div class="col-md-8">
<h4 class="first-child">New Customers</h4>
</div>
<div class="col-md-4">
<CFIF not isdefined("session.itemcount") or session.itemcount eq 0>
<a class="btn btn-sm btn-color">Continue &raquo;</a>
<CFELSE>
<a class="btn btn-sm btn-color" href="<CFOUTPUT>#Application.Protocol##CGI.Server_Name#/#url.u#/</CFOUTPUT>products/check-out/customer/">Continue &raquo;</a>
</CFIF>
</div>
</div><!-- / .row -->
<hr>
<h4 class="first-child">Returning Customers</h4>
<p>If you are a Returning Customer, please sign in with your login.</p>
<CFIF isDefined("e") and e eq -1>
<div class="col-sm-12 bg-danger">
<p style="padding-top: 10px;">You have entered an incorrect username or password.</p> 
</div><br><br><br>
</CFIF>
<CFOUTPUT>
<div class="form-group">
<label for="email" class="sr-only">Email Address:</label>
<input class="form-control" type="email" name="email" id="email" placeholder="Email Address" />
</div>
<div class="form-group">
<label for="password" class="sr-only">Password:</label>
<input class="form-control" type="password" name="password" id="password" placeholder="Password" />
</div>
</CFOUTPUT>
<CFIF not isdefined("session.itemcount") or session.itemcount eq 0>
<input type="submit" name="submit1" class="btn btn-sm btn-color" value="Continue &raquo;" disabled/>
<CFELSE>
<input type="submit" name="submit1" class="btn btn-sm btn-color" value="Continue &raquo;" />
</CFIF>
</form>
<hr>
<div class="panel-group" id="accordion">
<div class="panel panel-default">
<div class="panel-heading">
<h4 class="panel-title">
Lost your password? <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#panel1">Click here to recover</a>
</h4>
</div>
<!--- Why is this hardcoded to these error? removed isDefined and Paramed at the top. --->
<CFIF e eq -3 or e eq 2>
<div id="panel1" class="panel-collapse collapse in">
<CFELSE>
<div id="panel1" class="panel-collapse collapse">
</CFIF>
<div class="panel-body">
<h4 class="first-child"><cfoutput>Forgot Password:</cfoutput></h4>
<CFIF e eq -3>
<div class="col-sm-12 bg-danger">
<p style="padding-top: 10px;">
You have entered an incorrect email or postal code.
</p> 
</div><br><br><br>
</CFIF>
<CFIF e eq 2>
<div class="col-sm-12 bg-danger">
<p style="padding-top: 10px;">
Your password has been emailed to you.
</p> 
</div><br><br><br>
</CFIF>
<CFOUTPUT>
<form method="post" action="/#url.u#/process/check-out/forgot-password/">
<div class="form-group">
<label for="email" class="sr-only">Email Address:</label>
<input class="form-control" type="email" name="email" id="email" placeholder="Email Address" />
</div>
<div class="form-group">
<label for="zip-code" class="sr-only">Zip/Postal Code:</label>
<input class="form-control" type="text" name="zipcode" id="zip-code" placeholder="Zip/Postal Code" />
</div>
<input type="submit" name="submit1" class="btn btn-sm btn-color" value="Continue" />
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
<th>#pGetCartItems_Result.itemcount#  items to buy</th>
<th>Price</th>
<th>Quantity</th>
<th> Action</th>
</CFOUTPUT>
</tr>
</thead>
<CFIF pGetCartItems_Result.intProductID neq ''>
<CFSET tVar=''>
<CFSET Qty=0>
<tbody>
<CFLOOP query="pGetCartItems_Result">
	
	
<CFOUTPUT>
	<tr>
<CFIF intgroupProductID eq '' or  intProductID eq intgroupProductID ><!--- (Quantity eq 1  and intgroupProductID gt '') --->

<form name="ProductUpdate#currentrow#" action="/#url.u#/process/check-out/addtocart/update/" method="post">
<input type="hidden" name="intProductID" value="#intProductID#">
<input type="hidden" name="intCartDetailID" value="#intCart_DetailID#">
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
<td><input type="submit" name="update" class="btn btn-sm btn-default botMarg5" value="Update"><br><input type="submit" name="remove" class="btn btn-sm  btn-default" value="Remove"></td>
</form>
<CFELSE>
<td>&nbsp;</td>
</CFIF>
</tr>

</CFOUTPUT>
<CFSET Qty=Quantity>
<CFSET tVar=intgroupProductID>
</CFLOOP>
</tbody>
</CFIF>
</table>
</div>
</div> <!-- / .row -->
</div>