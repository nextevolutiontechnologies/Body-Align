<cfset this.activeNav="products">
<CFPARAM name="prid" default="1000">
<CFPARAM name="thisProduct" default="#url.f#" >
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#"  cachedwithin="#CreateTimespan(0,1,0,0)#">		
	<cfprocresult name="pGetPageContent_Result">
	<CFIF application.BrandID eq 2>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="56">
	<CFELSE>
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="18">
	</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc> 

<cfstoredproc procedure="pGetProductInfo_NEW" debug="yes" datasource="#application.datasource#">		
<cfprocresult name="pGetProductInfo_Result">	
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intProductID" type="in" value = "0">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" value="#Session.MemberID#">
<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strProduct" type="in" Value="#thisProduct#">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc>
<CFIF pGetProductInfo_Result.Recordcount eq 0>
	<CFOUTPUT>
	<CFINCLUDE  template="/common/error/404-error-product/#application.brandname#/index.cfm" ><CFABORT>
	</CFOUTPUT>
</CFIF>
<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">

<!-- Wrapper -->
<div class="wrapper product-details" style="padding-top: 0px;">
	<!-- Topic Header -->
	<div class="topic">
		<div class="container">
<CFPARAM name="url.e" default="0" >
<CFSWITCH expression="#url.e#" >
<CFCASE value="1">
			<div class="alert alert-success">
<button type="button" class="close" data-dismiss="alert">X</button>
<CFIF session.lang EQ 2><strong>Success!</strong> Item added to cart!<CFELSE><strong>Success!</strong> Item added to cart!</CFIF>
			</div>
</CFCASE>
<CFCASE value="-1">
		<div class="alert alert-danger">
<button type="button" class="close" data-dismiss="alert">X</button>
<CFIF session.lang EQ 2><strong>Shoot!</strong> That did not work out at all!<CFELSE><strong>Shoot!</strong> That did not work out at all!</CFIF>
		</div>
</CFCASE> 
<CFCASE value="-2">
	<div class="alert alert-danger">
<button type="button" class="close" data-dismiss="alert">X</button>
You must select not more than 4 Disc Options
		</div>
</CFCASE>
</cfswitch>
</div><!-- /.container -->
</div><!-- /.topic -->
<CFOUTPUT query="pGetProductInfo_Result" >

<div class="container-fluid">
<div class="row">
<div class="col-sm-12" style="background: url(/common/product/#session.langcode#/#strProductImg2#) no-repeat center top;">
<img src="/common/product/#session.langcode#/#strProductImg1#" class="img-responsive animated slideInDown" alt="#strProduct#" style="margin: 0 auto;">
</div>
</div><!-- /.container-fluid -->
</div>
<div class="container">
<div class="row">
<div class="col-sm-3">
<!-- Button trigger modal -->
<CFIF pGetProductInfo_Result.INTPRODUCTID NEQ 1050 and pGetProductInfo_Result.INTPRODUCTID NEQ 1055 and pGetProductInfo_Result.INTPRODUCTID NEQ 1060 and application.brandID eq 1>
<button type="button" class="btn btn-lg btn-color center-block-button" data-toggle="modal" data-target="##myModal">
  Nutrition Facts
</button>
</CFIF>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nutrition Facts</h4>
      </div>
      <div class="modal-body">
        <CFIF strProductImg3 gt ''<!--- and strProductFile gt ''--->>
        <a href="/common/product/#session.langcode#/#strProductFile#?r=newstuff" target="_blank">
        <img src="/common/product/#session.langcode#/#strProductImg3#?r=newstuff" class="img-responsive main text-center" alt="#strProduct# Nutritional Facts">
        </a>
        </CFIF>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</div>
<div class="col-sm-6">
<h1 style="color: ##749B46; text-align: center;">#strProduct#</h1>
</div>
<div class="col-sm-3">
<form method="post" action="/#url.u#/process/check-out/addToCart/" id="upsertCartForm">
<!--- productid will send only if strProductList is null or MIX and MAtch product, means strProductList started with 0 --->
<CFIF pGetProductInfo_Result.STRPRODUCTLIST is '' or ListFirst(pGetProductInfo_Result.STRPRODUCTLIST) eq 0>
<input type="hidden" name="intProductId" value="#intProductID#">
</CFIF>
<input type="hidden" name="amtUnit" value="#amtRetail#">
<CFIF strProductList gt ''>
<div class="price-block">
<p class="price">
<CFQUERY name="getProductOptions" datasource="#application.datasource#">
	<!--- select * from vGetProductList_New where intProductID in (#strProductList#) and intLangID=#session.Lang#
	order by intOrderBy --->
	select intProductID, max(strProduct) as strProduct, max(intOrderBy) as intOrderBy from vGetProductList_New 
	where intProductID in (#strProductList#) and intLangID=#session.Lang# and intBrandID=#application.BrandID#    group by intProductID order by intOrderBy
</CFQUERY>

	
	<CFIF ListFirst(strProductList) eq 0>
		<!--- Mix and Match --->
		<label class="sr-only" for="intProductID">Select Items:</label>
		<cfloop  query="getProductOptions">
		<input type="checkbox" name="ProductIDList" value="#getProductOptions.intProductID#">&nbsp;&nbsp;#getProductOptions.strProduct# <!--- <span class="new">#DollarFormat(amtRetail)#</span> --->
		<BR>
		</cfloop>
	<CFELSE>
	     <!--- choose size option --->
	 
	    <div class="form-group wrist-band" style="display: inline;">
		<h4>Select Size</h4>
		<label class="sr-only" for="intProductID">Select Size:</label>
		<select class="form-control req-select text-center" name="intProductID" id="intProductID" >
		<cfloop  query="getProductOptions">
			<option value='#getProductOptions.intProductID#'> #getProductOptions.strProduct#</option>
		</cfloop>
		</select>
		</div>
	</CFIF>
	</p>
	</div>
<cfelseif strOptionList gt ''>
<div class="price-block">
	<p class="price">
<!--- choose size option --->
    <div class="form-group wrist-band" style="display: inline;">
	<h4>Select Option</h4>
	<input type="hidden" name="strProductName" value="#strProduct#">
	<label class="sr-only" for="strProductOption">Select Size:</label>
	<select class="form-control req-select text-center" name="strOptionList" id="strOptionList" >
	<cfloop  list="#strOptionList#" index="ThisOption">
		<option value='#ThisOption#'> #ThisOption#</option>
	</cfloop>
	</select>
	</div>
	</p>
	</div>
</CFIF>
<div class="price-block">
<p class="price">
<CFIF amtYourPrice LT amtRetail>
<span class="old">#DollarFormat(amtRetail)#</span>
<span class="new">#DollarFormat(amtYourPrice)#</span><BR>
<span class="pec">@ %#NumberFormat(amtDiscountRate*100, "__")# Off</span>
<CFELSE>
<span class="new">#DollarFormat(amtRetail)#</span>	
</cfif>
<CFIF ListFirst(pGetProductInfo_Result.strProductList) eq 0>
	<input type="hidden" name="pcs" value="1" min="0">
<CFELSE>
<input type="number" name="pcs" value="1" min="0" class="form-control input-sm">
</CFIF>
<button class="btn btn-color btn-sm"><i class="fa fa-shopping-cart" onclick='$("##upsertCartForm").submit();'></i> Add</button>
</p>
</div>
</form>
</div>
</div> 
<div class="row">
<div role="tabpanel">
<!--- Nav tabs --->
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="##home" aria-controls="home" role="tab" data-toggle="tab">Overview</a></li>
	<li role="presentation">
		<a href="##profile" aria-controls="profile" role="tab" data-toggle="tab">
		<!--- this is a hack and needs to be handled 7/30 JM --->
		<cfif application.brandID eq 2>
			Testimonials</a>
		<cfelse>
			<CFIF pGetProductInfo_Result.INTPRODUCTID EQ 1020 OR pGetProductInfo_Result.INTPRODUCTID EQ 1025>Recipes<CFELSE>What's Inside?</CFIF></a>
		</cfif>
		
	</li>
  </ul>
<!--- Tab panes --->
  <div class="tab-content">
    <div role="tabpanel" class="tab-pane active" id="home">
     <div class="col-sm-12">
#paragraphformat(strProductText1)#
  	</div>
  </div>
    <div role="tabpanel" class="tab-pane" id="profile">
    #strProductText2#
    </div>
  </div>
  <div class="row">
  <div class="col-sm-12" style="text-align: center;">
  <br/>
  <br/>
  <h4>Share</h4>
  <span class='st_sharethis_large' displayText='ShareThis' st_summary="#paragraphformat(strProductText3)#" st_url="#application.Protocol##cgi.seRVER_NAME#/#url.u#/products/#STRURLFRIENDLY#.pv/" st_image="#application.Protocol##cgi.seRVER_NAME#/common/product/#session.langcode#/#strProductImg1#"></span>
<span class='st_facebook_large' displayText='Facebook' st_summary="#paragraphformat(strProductText3)#" st_url="#application.Protocol##cgi.seRVER_NAME#/#url.u#/products/#STRURLFRIENDLY#.pv/" st_title="#strProduct#" st_image="#application.Protocol##cgi.seRVER_NAME#/common/product/#session.langcode#/#strProductImg1#"></span>
<span class='st_twitter_large' displayText='Tweet' st_summary="#paragraphformat(strProductText3)#" st_url="#application.Protocol##cgi.seRVER_NAME#/#url.u#/products/#STRURLFRIENDLY#.pv/" st_title="#strProduct#" st_image="#application.Protocol##cgi.seRVER_NAME#/common/product/#session.langcode#/#strProductImg1#"></span>
<span class='st_linkedin_large' displayText='LinkedIn' st_summary="#paragraphformat(strProductText3)#" st_url="#application.Protocol##cgi.seRVER_NAME#/#url.u#/products/#STRURLFRIENDLY#.pv/" st_title="#strProduct#" st_image="#application.Protocol##cgi.seRVER_NAME#/common/product/#session.langcode#/#strProductImg1#"></span>
<span class='st_pinterest_large' displayText='Pinterest' st_summary="#paragraphformat(strProductText3)#" st_url="#application.Protocol##cgi.seRVER_NAME#/#url.u#/products/#STRURLFRIENDLY#.pv/" st_title="#strProduct#" st_image="#application.Protocol##cgi.seRVER_NAME#/common/product/#session.langcode#/#strProductImg1#"></span>
<span class='st_email_large' displayText='Email' st_summary="#paragraphformat(strProductText3)#" st_url="#application.Protocol##cgi.seRVER_NAME#/products/#STRURLFRIENDLY#.pv/" st_title="#strProduct#" st_image="#application.Protocol##cgi.seRVER_NAME#/common/product/#session.langcode#/#strProductImg1#"></span>
</div>
</div>
</div>
</div>
</div> <!-- / .container -->
</CFOUTPUT>
</div> <!-- / .wrapper -->
<CFINCLUDE template="/public/footer.cfm">