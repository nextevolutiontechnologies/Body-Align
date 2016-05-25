<CFINCLUDE template="/public/header.cfm">
<CFINCLUDE template="/public/main-nav.cfm">
<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">		
	<cfprocresult name="pGetPageContent_Result">
  <CFIF application.BrandID eq 2>
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="74">
  <CFELSE>
    <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" value="39">
  </CFIF>
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
  <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc> 
<div class="wrapper">
	<div class="wrapper_inner">
		<div class="content">
			<div class="content_inner  ">
				<div class="container">
					<div class="container_inner clearfix">
						<div class="header-margins">
							<CFOUTPUT><h1>#pGetPageContent_Result.strContentText1#</h1></cfoutput>
              <CFOUTPUT>#pGetPageContent_Result.strContentText2#</cfoutput>
							<div style="margin-top:20px;margin-bottom:20px;" class="separator transparent"></div>
						</div>
					</div>
				</div>
			</div>
    </div><!-- /.content -->
	</div><!--<div class="wrapper_inner">-->
</div><!--<div class="wrapper">-->
<CFINCLUDE template="/public/footer.cfm">