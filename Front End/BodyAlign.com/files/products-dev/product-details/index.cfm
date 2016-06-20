<CFINCLUDE template="/public/global_header.cfm">
<CFINCLUDE template="/public/header.cfm">
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
<div class="col-md-6">
<h1 class="page-header">#strProduct#</h1>
</div>
<div class="col-md-6 text-right">
<cfoutput>
<ol class="breadcrumb breadcrumb-2">
<li>
<a href="/#url.u#/products">Productss</a>
</li>
<li class="active">#strProduct#</li>
</ol>

</cfoutput>
</div>
</div>
</div><!--end container-->
</section>
<section class="product-single-section">
<div class="container">
<div class="product-single">
<div class="row mb24 mb-xs-48">
<div class="col-md-5 col-sm-6">

<div class="image-slider slider-thumb-controls controls-inside">
<ul class="slides">
<li style="list-style-type:none;">
<img alt="Image" src="/files/img/products/#replacenocase(strURLFriendly,'*','')#.png"/>
</li>
</ul>
</div><!--end of image slider-->
</div>
<div class="col-md-6 col-md-offset-1 col-sm-6">
<div class="description">
<!---<h4 class="uppercase">#strProduct#</h4>--->
<article>
#strProductText1#
</article>
</div>
</div>
<div class="col-md-5 col-md-offset-1 col-sm-6">
<div class="mb32 mb-xs-24">
<span class="number price">$#amtRetail#</span>
</div>
<hr class="mb48 mb-xs-24">
<img src="http://www.bodyalign.com/files/img/products/moneyback-guarantee.png" align="right" width="130">
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
</div>
</div><!--end of product single-->
</div><!--end of container-->
</section>



</cfoutput>
<CFINCLUDE template="/public/footer.cfm">
<CFINCLUDE template="/public/global_footer_product.cfm">