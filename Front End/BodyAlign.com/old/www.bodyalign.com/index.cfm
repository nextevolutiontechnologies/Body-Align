<cfset this.activenav = 'home'>
<CFSAVECONTENT variable="customfoot">
</CFSAVECONTENT>
<CFINCLUDE template="/public/header.cfm">
<CFINCLUDE template="/public/main-nav.cfm">
<!-- Wrapper -->
<!--- <CFQUERY name="GetSpecialMenu" datasource="#application.datasource#" >
SELECT mi.intMenuItemID,mi.strMenuItemURL,mil.strMenuItem,m.strMenuCSS,mi.strMenuItemIcon,strMenuItemCSS
, [dbo].[udf_friendlyURL] (lower(m.strMenu)) as ImgFolder ,[dbo].[udf_friendlyURL] (lower(mi.strMenuItem)) as imgName
FROM MENU_ITEM mi with (nolock)
INNER JOIN MENU m with (nolock) on  mi.intMenuID = m.intMenuID
INNER JOIN MENU_ITEM_LANG mil with (nolock) on mil.intLanguageID = #session.lang#
and mi.intMenuItemID = mil.intMenuItemID
WHERE mi.intMenuID = 60 and mi.isActive=1 and m.isActive=1
</CFQUERY> --->
<cfstoredproc procedure="dbo.pGetMenuList" debug="yes" datasource="#application.datasource#" >		
	<cfprocresult name="GetSpecialMenu">
	<cfif application.BrandID eq 2>
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMenuID" type="in" Value="140">
	<cfelse>
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intMenuID" type="in" Value="60">	
	</cfif>
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLanguageID" type="in" Value="#session.lang#">
	<cfprocparam cfsqltype="CF_SQL_bit" variable="isActive" type="in" value="yes">
</cfstoredproc>
<div class="wrapper">
<cfinclude template="/public/slider.cfm">
<div class="container-fluid row-4-boxes">
	<CFLOOP query="GetSpecialMenu">
	<div class="col-md-3 col-sm-6">
	<a href="/<CFOUTPUT>#url.u##strMenuItemURL#</CFOUTPUT>">
	<img class="img-responsive" src="/common/menu/<cfoutput>#ImgFolder#</CFOUTPUT>/<CFOUTPUT>#session.langcode#</CFOUTPUT>/<cfoutput>#strImageName#</cfoutput>" alt="View Body Align <cfoutput>#strMenuItem#</cfoutput>">
	</a>
	</div>
	</cfloop>
</div>
</div> <!-- / .wrapper -->
<cfinclude template="/public/video-presentation.cfm">
<CFINCLUDE template="/public/footer.cfm">