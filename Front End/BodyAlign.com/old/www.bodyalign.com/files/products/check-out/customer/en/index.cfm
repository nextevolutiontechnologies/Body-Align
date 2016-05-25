<div class="col-sm-4">
<h3 class="primary-font"><cfoutput>#pGetPageContent_ResultCustomerInformation.strContentText1#</cfoutput></h3>
</div>
</div>
</div>
</div>			
<div class="container">
<CFOUTPUT>
<a class="btn btn-color btn-sm continue-shopping" href="/<CFOUTPUT>#url.u#</CFOUTPUT>/products/">&laquo; Continue Shopping</a>
<div class="row">
<div class="col-sm-7 shopping-cart">
<h3>#pGetPageContent_ResultCustomerInformation.strContentText2#</h3>
<table class="table table-bordered">
<thead>
<tr>
<th>items to buy</th>
<th class="text-center"> Quantity </th>
<th class="text-right">Price</th>
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
<cfoutput>
<form name="CustomerForm" id="CustomerForm" action="/#url.u#/process/check-out/shipping/" method="post">
<div class="col-sm-5 well">
<h3 class="first-child">Shipping Information</h3>
<div class="form-group text-right">
<label for="saveShipInfo">Save Shipping Information</label>&nbsp; 
<input name="saveShipInfo" type="checkbox" value="1" <CFIF isDefined("GetCartInfo.isShippingOnFile") and GetCartInfo.isShippingOnFile eq 1>checked</CFIF>/>
</div>
<cfif AddressDropdownList.recordcount gt 0 and session.CustID gt 0>
<div class="form-group">
<label for="selectAddr">Select Shipping Address:</label>
<select id="selectCustomerAddr" name="selectCustomerAddr" class="form-control req-select" onChange="getformdate('shipping');">
<option value="0">New Address</option>                  
<cfloop query="AddressDropdownList">
<option value="#intAddressID#">#strAddress#</option>
</cfloop>
</select>
</div>
</cfif>
<div class="form-group">
<label class="sr-only" for="name"><span class="red">*</span> First Name:</label>
<input type="text" class="form-control isreq" id="strFirstName" name="strFirstName" placeholder="First Name:" value="#GetCartInfo.STRCARTFIRSTNAME#">
</div>
<div class="form-group">
<label class="sr-only" for="name"><span class="red">*</span> Last Name:</label>
<input type="text" class="form-control isreq" id="strLastName" name="strLastName" placeholder="Last Name:" value="#GetCartInfo.STRCARTLASTNAME#">
</div>
<div class="form-group">
<label class="sr-only" for="address1"><span class="red">*</span> Address 1:</label>
<input type="text" class="form-control isreq" id="STRADDRESS1" name="strAddress1" placeholder="Address 1:" value="#GetCartInfo.STRCARTADDRESS#">
</div>
<div class="form-group">
<label class="sr-only" for="address2"><span class="red">*</span> Address 2:</label>
<input type="text" class="form-control" id="STRADDRESS2" name="strAddress2" placeholder="Address 2:" value="#GetCartInfo.STRCARTADDRESS2#">
</div>
<div class="form-group">
<label class="sr-only" for="city"><span class="red">*</span> City:</label>
<input type="text" class="form-control isreq" id="STRCITY" name="strCity" placeholder="City:"  value="#GetCartInfo.STRCARTCITY#">
</div>
<div class="form-group">
<label class="sr-only" for="state"><span class="red">*</span> State:</label>
<select id="intStateID" name="intStateID" class="form-control req-select">
<option value="">State</option>
<CFLOOP query="GetStateList">
<option value="#intStateID#" <CFIF GetCartInfo.INTCARTSTATEID  eq GetStateList.intStateID>selected</CFIF>>#strState#</option>
</CFLOOP>
</select>
</div>
<div class="form-group">
<label class="sr-only" for="zip"><span class="red">*</span> Zip/Postal Code:</label>
<input type="text" class="form-control isreq" id="STRZIPCODE" name="strZipCode" placeholder="Zip/Postal Code:" value="#GetCartInfo.STRCARTZIP#">
</div>
<div class="form-group">
<label class="sr-only" for="phone"><span class="red">*</span> Phone:</label>
<input type="text" class="form-control" id="strPhone" name="strPhone" placeholder="Phone:" value="#GetCartInfo.strPhone#">
</div>           
</div>
<div class="form-group text-right xs-margRight20">
<button type="submit" id="submit-btn" name="submit-btn" class="btn btn-color"> Continue to Payment &raquo;</button>
</div>
</form>
</cfoutput>