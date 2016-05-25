<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">

<cfstoredproc procedure="pGetProductList_Public" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetProductList_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" value="#session.lang#">
</cfstoredproc>

<div class="wrapper">
<div class="container shop-item topPad20">

<div class="row">
<div class="col-sm-12">
<h1 class="first-child text-color text-center botMarg30">
<!--- This is one of the categories that may be used, sorta a place hold right now. JM--->
Retail Products
</h1>
</div>
</div>
<div class="row">
<CFOUTPUT query="pGetProductList_Result">
	<div class="col-sm-4 topPad20">
	<div class="shop-product">
	<a href="#STRURLFRIENDLY#.pv"><img src="/common/product/#session.langcode#/#STRPRODUCTIMG1#" class="img-responsive center-block" alt="Product Image"></a>
	<a href="#STRURLFRIENDLY#.pv"><h4 class="primary-font topPad15">#strProduct#</h4></a>
	<p><span class="new">#dollarFormat(amtRetail)#</span></p>
	<p>
	<a href="#STRURLFRIENDLY#.pv" class="btn btn-color">LEARN MORE</a>
	</p>
	</div>
	</div>
	<CFIF pGetProductList_Result.CurrentRow MOD 3 IS 0>
		<div class="clearfix hidden-xs"></div><!--- We need to add this after 3rd product --->
	</CFIF>
</CFOUTPUT>
</div> <!-- / .row -->


</div> <!-- / .container -->
</div> <!-- / .wrapper -->

<CFINCLUDE template="/public/footer.cfm">