<CFINCLUDE template="/public/global_header.cfm">
<CFINCLUDE template="/public/header.cfm">
<cfoutput>
<section class="content-1-5 content-block">
<div class="container">
<div id="header">
<div id="body">
<div class="row">
<div class="col-md-6">
<h1 class="page-header">FREE AFFILIATE ENROLLMENT
</h1>
</div>
<div class="col-md-6 text-right">
<cfoutput>
<ol class="breadcrumb breadcrumb-2">
<li>
<a href="/#url.u#/">Home</a>
</li>
<li> <a href="/#url.u#/checkout">Checkout</a></li>
<li class="active">Payment</li>
</ol>

</cfoutput>
</div>
</div><!--end of row-->

</div>
</div><!--end of container-->
</div><!--end of header-->
 
 
<div class="container">
<p><strong>Your Body Aligner:</strong> <cfif isdefined("pGetMemberWebsite_results.strfullname")><cfoutput>#pGetMemberWebsite_results.strfullname#</cfoutput></cfif></p>
<form id="payment" class="customer-details mb80 mb-xs-40" action="<cfoutput>#application.protocol##HTTP_HOST#</cfoutput>/<cfoutput>#url.u#</cfoutput>/checkout/payment/process/" method="post">
<div class="row">
<div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
<div class="row">
 <br />
<div class="input-with-label col-sm-6 form-group text-left">
<h5 style="margin-bottom: 0px;">
<cfif pGetCartItems_Result.intCarttypeID eq 2>
Enrollment
<cfelseif pGetCartItems_Result.intCarttypeID eq 11>
Enrollment
<cfelse>
SHIPPING
</cfif></h5>
</div>
<div class="input-with-label col-sm-6 form-group text-right">
<span class="save-info-ckbox">Save Address for use later:</span>
<input type="checkbox" name="isShippingonFile" value="1"/>
</div>
</div><!-- /.row -->
<div class="row">

<div class="input-with-label col-sm-4 form-group text-left">
<span>First Name:</span>
<input type="text" placeholder="First Name" id="strCartFirstName" name="strCartFirstName" value="#pGetCartItems_Result.strCartFirstName#" maxlength="40" />
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>Last Name:</span>
<input type="text" placeholder="Last Name" id="strCartLastName" name="strCartLastName" value="#pGetCartItems_Result.strCartLastName#"  maxlength="50" />
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>Email Address:</span>
<input type="email" placeholder="Email Address" name="strEmail"  maxlength="200" id="strEmail" value="#pGetCartItems_Result.strEmail#"/>
</div>

</div><!-- /.row -->


<div class="row">

<div class="input-with-label col-sm-4 form-group text-left">
<span>Street Address:</span>
<input type="text" placeholder="Street Address" id="strCartAddress1" name="strCartAddress1" value="#pGetCartItems_Result.strCartAddress#" maxlength="100" />
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>Address 2:</span>
<input type="text" placeholder="Address 2" id="strCartAddress2" name="strCartAddress2" value="#pGetCartItems_Result.strCartAddress2#" maxlength="100"/>
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>City:</span>
<input type="text" placeholder="City" name="strCartCity" id="strCartCity"  maxlength="100"  value="#pGetCartItems_Result.strCartCity#"/>
</div>

</div><!-- /.row -->
<div class="row">
<div class="input-with-label col-sm-4 form-group text-left">
<span>State:</span>
<div class="select-option">
<i class="ti-angle-down"></i>
<select name="intCartStateID">
<option value="" >Select a State</option>
<cfloop query="GetStateList" >
<option value="#intStateID#" <CFIF pGetCartItems_Result.INTCARTSTATEID  eq GetStateList.intStateID>selected</CFIF>>#strstate#</option>
</cfloop>
</select>
</div>
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>Zip/Postal Code:</span>
<cfif pGetCartItems_Result.intCartTypeID eq 11 or pGetCartItems_Result.amtTotal eq 0>
<input type="text" placeholder="Zip/Postal Code" id="strCartZip" name="strCartZip" value="#pGetCartItems_Result.strCartZip#" maxlength="15" />
<cfelse>
<input type="hidden" name="dupstrCartZip" value="#pGetCartItems_Result.strCartZip#">
<input type="text" placeholder="Zip/Postal Code" id="strCartZip" name="strCartZip" value="#pGetCartItems_Result.strCartZip#" maxlength="15" disabled />
<div class="update-ship-zip"><a href="/#url.u#/checkout/">Update Shipping Zip</a> <br><b>(may change shipping amount)</b></div>
</cfif>
</div>

</div><!-- /.row -->
<cfif pGetCartItems_Result.intProductID neq "1070" >
<div class="row">
<div class="input-with-label col-sm-3 form-group text-left">
<h5 style="margin-bottom: 0px;">PAYMENT</h5>
</div>
<div class="input-with-label col-sm-9 form-group text-right">
<span class="save-info-ckbox">Keep Payment Information secure for later use:</span>
<input type="checkbox" name="isBillingOnFile" value="1"/>
</div>
</div><!-- /.row -->
<div class="row">
<div class="input-with-label col-sm-4 form-group text-left">
<span>Credit Card ##:</span>
<input type="text" placeholder="Credit Card ##" id="CCNUMBER" name="CCNUMBER"  maxlength="16" />
</div>

<div class="input-with-label col-sm-4 form-group text-left">
<span>Name on Card:</span>
<input type="text" placeholder="Name on Card" id="strBillName" name="strBillName" value="<cfoutput>#pGetCartItems_Result.strNameOnCard#</cfoutput>" maxlength="100" />
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>CW or CV2</span>
<input type="text" placeholder="ccv" name="ccv" id="ccv"  maxlength="4"   />
</div>

</div><!-- /.row -->
<div class="row">

<div class="input-with-label col-sm-4 form-group text-left">
<span>Exp Year:</span>
<div class="select-option">
<i class="ti-angle-down"></i>
<select name="STREXPYEAR" id="STREXPYEAR">
<option value="">Exp Year</option>
<cfloop from="2016" to="2036" index="i">
<option value="#i#">#i#</option>
</cfloop>
</select>
</div>
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>Exp Month:</span>
<div class="select-option">
<i class="ti-angle-down"></i>
<select  name="STREXPMONTH" id="STREXPMONTH">
<option value="">Exp Month</option>
<option value="01">Jan</option>
<option value="02">Feb</option>
<option value="03">Mar</option>
<option value="04">Apr</option>
<option value="05">May</option>
<option value="06">June</option>
<option value="07">July</option>
<option value="08">Aug</option>
<option value="09">Sep</option>
<option value="10">Oct</option>
<option value="11">Nov</option>
<option value="12">Dec</option>
</select>
</div>
</div>

</div><!-- /.row -->
</cfif>
<cfif pGetCartItems_Result.intCarttypeID eq 2>
<div class="row">
<div class="input-with-label col-sm-12 form-group text-left">
<h5 style="margin-bottom: 0px;">SIGN UP</h5>
</div>
</div><!-- /.rwo -->
<div class="row">

<div class="input-with-label col-sm-4 form-group text-left">
<span>Co-Applicant Name:</span>
<input type="text" placeholder="Co-Applicant Name" id="strCoAppName" name="strCoAppName" value="" maxlength="100" />
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>SSN##:</span>
<input type="text"  placeholder="SSN##" onbluerb="this.replace(/ /g, '');" id="strSsn" name="strSsn" value="" maxlength="20" />
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>EIN##:</span>
<input type="text"  placeholder="EIN##" onbluerb="this.replace(/ /g, '');" id="STRFEDERALID" name="STRFEDERALID" value="" maxlength="20" />
</div>




</div><!-- /.row -->
<div class="row">
<div class="input-with-label col-sm-4 form-group text-left">
<span>Username:</span>
<input type="text" placeholder="Username" id="strUserName" name="strUserName" value="" onblur="this.replace(/^\s+|\s+$/g,'')" maxlength="100" />
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>Contact Phone:</span>
<input type="text" placeholder="Contact Phone" id="strPhone" name="strPhone" value="" maxlength="100" />
</div>
<div class="col-sm-4 form-group text-left">
<span class="pick-date-payment">DATE OF BIRTH:</span>
<div id="dp-ex-4" class="input-group date" data-date="12-02-1998" data-date-format="mm/dd/yyyy" data-date-autoclose="true" data-date-start-view="2">
<input class="form-control" type="text" placeholder="mm/dd/yyyy" id="dtDateOfBirth" name="dtDateOfBirth">
<span class="input-group-addon" style="border: none;"><i class="fa fa-calendar"></i></span>
</div>
</div>
</div><!-- /.rwo -->
</cfif>
<hr class="visible-xs">
</div>

</div><!--end of row-->
<cfif pGetCartItems_Result.intCarttypeID neq 11 and  pGetCartItems_Result.intCarttypeID neq 2>
<div class="row">
<div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
<div class="row">
<p class="uppercase col-sm-12">
<a role="button"  href="##" onclick="$('##ship-method').show();return false;" aria-expanded="false" aria-controls="ship-method" >
Have a different Payment Address? <i class="ti-angle-down"></i>
</a>
</p>
</div><!-- /.row -->
</div>
<div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1" id="ship-method" style="display:none;">
<div class="row">
<div class="input-with-label col-sm-4 form-group text-left">
<span>Street Address:</span>
<input type="text" placeholder="Street Address" name="strBillingAddress" id="strBillingAddress"  maxlength="100"   value="#pGetCartItems_Result.strBillingAddress#"/>
</div>
<div class="input-with-label col-sm-4 text-left">
<span>Address 2:</span>
<input type="text" placeholder="Address 2" name="strAddress2" id="strAddress2"  maxlength="100"  <!---value="#pGetCartItems_Result.STRCARTADDRESS2#"--->/>
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>City:</span>
<input type="text" placeholder="City" name="strBillingCity" id="strBillingCity"  maxlength="100"  value="#pGetCartItems_Result.strBillingCity#"/>
</div>
</div><!-- /.row -->
<div class="row">
<div class="input-with-label col-sm-4 form-group text-left">
<span>State:</span>
<div class="select-option">
<i class="ti-angle-down"></i>
<select  name="intBillingStateID" id="intBillingStateID" >
<option value="-1" >Select a State</option>
<cfloop query="GetStateList" >
<option value="#intStateID#" <CFIF pGetCartItems_Result.INTCARTSTATEID  eq GetStateList.intStateID>selected</CFIF>>#strstate#</option>
</cfloop>
</select>
</div>
</div>
<div class="input-with-label col-sm-4 form-group text-left">
<span>Zip/Postal Code:</span>
<input type="text" placeholder="Zip/Postal Code" maxlength="15" name="strBillingZip" id="strBillingZip" value="#pGetCartItems_Result.strBillingZip#" />
</div>
</div><!-- /.row -->
</div>
</div>
</cfif>
<div class="row">
<div class="col-md-8 col-md-offset-2">
<!---<div class="text-center">
<h4 class="uppercase">Order Summary</h4>
<hr>
</div>
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
</table>--->
<div class="halves text-center">

<input type="submit" class="pull-right" value="Become and Affiliate" /><br />
<!---<a class="btn btn-lg" href="/<cfoutput>#url.u#</cfoutput>/checkout/">Back To Cart</a> --->
</div>
</div>
</div><!--end of row-->
</form>
</div><!--end of container-->
</section>
</cfoutput>
<br /> <br />
<CFINCLUDE template="/public/footer.cfm">
<CFINCLUDE template="/public/global_footer.cfm">