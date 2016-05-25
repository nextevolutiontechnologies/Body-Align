<CFINCLUDE template="/public/global_header.cfm">
<CFINCLUDE template="/public/header.cfm">
<cfstoredproc procedure="pGetProductList_Public" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetProductList_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" value="#session.lang#">
</cfstoredproc>
<cfif isDefined("url.p") and url.p GT ''>
<cfquery name="pGetProductList_Result" dbtype="query">
	SELECT * FROM pGetProductList_Result WHERE LOWER(strCategory) = <cfqueryparam cfsqltype="string" value="#lcase(url.p)#" >
</cfquery>
</cfif>
<div id="wrap">
<section class="content-1-5 content-block">
<div class="container">

<!-- Page Heading -->
<div class="row">
<div class="col-lg-12">
<h1 class="page-header">Our Products <cfif isDefined("url.p") and url.p gt ''><cfoutput> - #UCASE(pGetProductList_Result.strCategory)#</cfoutput></cfif>
</h1>
</div>
</div>
</div><!--end of container-->
</section>
 
<div class="container">
<div id="header">
<div id="body">
<div class="row">
<div class="col-md-2 col-sm-4">
<div class="select-option">
<i class="fa fa-angle-down"></i>
<!---<select>
<option selected value="Default">Sort By</option>
<option value="Small">Highest Price</option>
<option value="Medium">Lowest Price</option>
<option value="Larger">Newest Items</option>
</select>--->
</div><!--end select-->
</div>
</div><!--end of row-->
 
<div class="row masonry">
<cfoutput query="pGetProductList_Result">
<div class="col-md-3 col-sm-4 masonry-item col-xs-12">
<div class="image-tile outer-title text-center">
<a href="/#url.u#/products/#strURLFriendly#.ba">
<img alt="#strURLFriendly#" class="product-small" src="/files/img/products/#replacenocase(strURLFriendly,'*','')#.png" />
</a>
<div class="title">
<h5 class="mb0">#strProduct#</h5>
<!---<span class="display-block mb16">$#amtRetail#</span>--->
<p>
<a class="btn btn-color" href="/#url.u#/products/#strURLFriendly#.ba">LEARN MORE</a>
</p>
</div>
</div>
</div><!--end three col-->

</cfoutput>
</div>
</div> 
</div><!--end of row-->
</div><!--end of container-->
</div><!--end of wrap -->
<br /><br />
<CFINCLUDE template="/public/footer.cfm">
<CFINCLUDE template="/public/global_footer.cfm">