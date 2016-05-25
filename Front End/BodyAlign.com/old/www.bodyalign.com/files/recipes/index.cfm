<cfquery name="GetPageContent" datasource="#Application.datasource#" >
SELECT TOP 1000 cc.[intContentID]
,[intContentTypeID]
,[strContent]
,dbo.udf_friendlyURL(Lower([strContent])) as FriendlyURL
,ccl.[strContentText1]
,ccl.[strContentText2]
,ccl.[strContentText3]
,cc.[strContentCSS]
,cc.[strContentLink]
,ccl.[strContentImg1]
,ccl.[strContentImg2]
,ccl.[strContentImg3]

FROM [dbo].[CONTENT] cc with (nolock) inner join [dbo].[CONTENT_LANG] ccl with (nolock) on cc.intcontentID = ccl.intContentID
WHERE intLanguageID = #session.lang# and isActive = 1 and intContentTypeID = 20 and intBrandID = #application.BrandID#
</cfquery>
<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">
<!-- Wrapper -->
<div class="wrapper">
<div class="container recipes">
<h2 class="headline text-color">
<span class="border-color">VidaShake Recipes</span>
</h2>
<cfoutput>
<div class="row">
<cfloop query="GetPageContent">
<div class="col-md-3 col-xs-4">
<img class="img-responsive" src="/common/img/recipes/#session.langcode#/#strContentImg1#" alt="#strContentText1#">
</div>
<div class="col-md-3 col-xs-8">
<h3>#strContentText1# - <small><cfif session.lang EQ 2>Para 1 porci&##243;n<cfelse>Makes 1 serving</cfif></small></h3> 
#strContentText2#
<p>            
<em>#strContentText3#</em>
</p>  
</div>
<cfif NOT (GetPageContent.CurrentRow MOD 2)>
<div class="clearfix visible-sm visible-xs"></div>
</div> <!-- / .row -->
<cfif GetPageContent.currentrow NEQ GetPageContent.recordcount> 
<div class="row">
</cfif>	
</cfif>
</cfloop>
</cfoutput>
</div> <!-- / .container -->

</div> <!-- / .wrapper -->

<CFINCLUDE template="/public/footer.cfm">