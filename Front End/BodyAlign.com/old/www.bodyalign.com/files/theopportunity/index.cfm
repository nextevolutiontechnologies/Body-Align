<!--- At this point we need to show packages in the DB. --->
<cfset this.activeNav="the opportunity">

<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">

<!--- Getting Page Content --->
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_Result">
	<CFIF application.BrandID eq 2>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="51">
		<CFELSE>
			<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="13">
		</CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc>

<!--- Getting Product (Enrollment Kits) List --->
<cfstoredproc procedure="pGetProductList_NEW" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetProductList_Result">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strCategory" type="in" Value="Enrollment">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="CustomerID" type="in" value=0>
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMemberID" type="in" Value="#session.memberid#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">	
</cfstoredproc>
<cfquery name="pGetProductList_Result" dbtype="query"> 
 select * from pGetProductList_Result order by amtYourPrice
</cfquery>

<header class="image-bg-fluid-height">
<div class="container opportunity-heading text-center">
<!--- Display Page Content --->
<cfoutput query="pGetPageContent_Result">
	#strContentText1#
	#strContentText2#
</CFOUTPUT>
<!--- END Display Page Content --->
</div>
</header>
<div class="container-fluid opportunity-contain">
<div class="row">
<!--- Display Product List --->
<cfset colvar = 12/pGetProductList_Result.recordcount>
<CFOUTPUT query="pGetProductList_Result">
<div class="col-md-#colvar# #strProductCSS# text-center">
	<img src="/common/product/en/#strProductIMG3#" alt="#strProductText3#">
	<h1>#strProduct#</h1>
	<h2>#DollarFormat(amtRetail)#</h2>
	<!--- we need to fix this hack --->
	<cfif application.brandID eq 2>
		#strProductText1#
	<cfelse>
		#strProductText2#
	</cfif>
	<form id="bus#intProductID#" name="bus#intProductID#" action="/#url.u#/process/theopportunity/" method="post">
	<input type="hidden" name="pid" value="#intProductID#">
	<input type="hidden" name="ShipFlatRate" value="#amtShipRate#">
	<CFIF strProductList gt '' and ListFirst(strProductList) eq 2>
	<h4>Select Wristband Size</h4>
	<cfloop index = "ListElement" list = "#ReplaceNoCase(strProductList,ListFirst(strProductList) & ',', "")#" delimiters=":"> 
		<cfquery NAME="getProductOptions" datasource="#application.datasource#">   	
			<!--- select * from vGetProductList_New where intProductID in (#ListElement#) and intLangID=#session.Lang#
			order by intOrderBy --->
			select intProductID, max(strProduct) as strProduct, max(intOrderBy) as intOrderBy from vGetProductList_New 
			where intProductID in (#ListElement#) and intLangID=#session.Lang# and intBrandID=#application.BrandID#    group by intProductID order by intOrderBy
		</cfquery>
		<div class="form-group wrist-band">
			<label class="sr-only" for="intStartBand1">Wristband Size:</label>
			<select class="form-control req-select text-center" name="intSelectedProducts" id="intSelectedProducts">
			<cfloop query="getProductOptions">
				<option value="#intProductID#">#strProduct#</option>
			</cfloop>
			</select>
		</div>	
	</cfloop> 
	</CFIF> 
	<br><input type="submit" class="btn btn-lg btn-color" value="Join Now">
	</form>
	<br/>
</div>
</CFOUTPUT>
<!--- END Display Product List --->
</div><!-- /.row -->
</div><!-- /.container-fluid -->
<cfinclude template="/public/video-presentation.cfm">
<CFINCLUDE template="/public/footer.cfm">