<CFINCLUDE template="/public/global-header.cfm">
<CFINCLUDE template="/public/menu.cfm">
<CFPARAM name="thisProduct" default="#url.f#" >
<cfstoredproc procedure="pGetProductInfo_NEW" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetProductInfo_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value = "0">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#Session.MemberID#">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" Value="#thisProduct#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc>
<cfoutput query="pGetProductInfo_Result">

<section class="content-1-5 content-block">
<div class="container">
<!-- Page Heading -->
<div class="row">
<div class="col-lg-12">
<h1 class="page-header">#strProduct#</h1>
</div>
</div>

</section>

<section>
<div class="container">
<div class="product-single">
<div class="row mb24 mb-xs-48">
<div class="col-md-5 col-sm-6">
<div class="image-slider slider-thumb-controls controls-inside">
<ul class="slides">
<li style="list-style-type:none;">
<img alt="Image" src="/files/img/products/#replacenocase(strURLFriendly,'*','',)#.png" />
</li>
</ul>
</div><!--end of image slider-->
</div>
<div class="col-md-5 col-md-offset-1 col-sm-6">
<div class="description">
<h4 class="uppercase">#strProduct#</h4>
<div class="mb32 mb-xs-24">
<span class="number price">#amtRetail#</span>
</div>
<!---#strProductText1#--->
<div class="col-md-6">
<h2>Ultimate Wellness Wristband </h2>
<h3>Your Personal Wellness Foundation</h3>
<article>
                        <ul>
                             <li>Feel better physically</li>
                             <li>Have sharper mental focus</li>
                             <li>Maintain balanced energy all day</li>
                             <li>Improve your physical and athletic performance</li>
                             <li>Get rid of annoying pain</li>
                         </ul>
</article>
</div>

</div>
 

<hr class="mb48 mb-xs-24">
<form class="add-to-cart" action="/#url.u#/checkout/addtocart/" method="post" id="addcart" >
<input type="hidden" name="Productid" value="#intProductID#" placeholder="ProductID" />
<input type="hidden" name="CustID" value="0" />
<input type="hidden" name="unit" value="#amtRetail#" />
<input type="hidden" name="intCartTypeID" value="1" />
<input type="number" name="nqty" placeholder="QTY" min="1"/>
<input type="submit" value="Add To Cart" />
</form>
</div>
</div><!--end of row-->

<div class="row">
	<div class="col-sm-12">
		<div class="tabbed-content text-tabs product-tabs">
			<cftry>
			<cfinclude template="#strURLFriendly#_#session.langcode#.html" >
			<cfcatch >
			
			No File Exist yet
			</cfcatch>
			</cftry>
		</div>
	</div>
</div><!--end of row-->
</div><!--end of product single-->
</div><!--end of container-->
</section>
</cfoutput>
<CFINCLUDE template="/public/footer.cfm">