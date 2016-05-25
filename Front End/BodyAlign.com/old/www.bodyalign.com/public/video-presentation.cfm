<cfstoredproc procedure="dbo.pGetPageContent" debug="yes" datasource="#application.datasource#" cachedwithin="#CreateTimespan(0,1,0,0)#">		
	<cfprocresult name="pGetVideoContent_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentID" type="in" Value="17">
	<cfprocparam cfsqltype="CF_SQL_VARCHAR" variable="strContent" type="in" null="yes">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
</cfstoredproc>
<!-- Large modal -->
<div id="homeModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
<div class="vertical-alignment-helper">
<div class="modal-dialog modal-lg vertical-align-center">
<div class="modal-content">
<div class="modal-header" style="position: relative;">
<a href="/public/choose-language/?lang=1&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>" role="button">English</a> | 
<a href="/public/choose-language/?lang=2&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>" role="button">Spanish</a>
<div style="position: absolute; right: 40px; top: 10px;">          
<span class='st_sharethis_large' displayText='ShareThis' st_summary="Come and see the great Products and Opportunity at PowerVida!" st_url="http://www.powervida.com/<CFOUTPUT>#url.u#</CFOUTPUT>/?lang=2" st_image="http://www.powervida.com//img/<CFOUTPUT>#session.langcode#</CFOUTPUT>/products-home.jpg"></span>
<span class='st_facebook_large' displayText='Facebook' st_summary="Come and see the great Products and Opportunity at PowerVida!" st_url="http://www.powervida.com/<CFOUTPUT>#url.u#</CFOUTPUT>/" st_title="http://www.powervida.com//img/<CFOUTPUT>#session.langcode#</CFOUTPUT>/products-home.jpg"></span>
<span class='st_twitter_large' displayText='Tweet' st_summary="Come and see the great Products and Opportunity at PowerVida!" st_url="http://www.powervida.com/<CFOUTPUT>#url.u#</CFOUTPUT>/" st_image="http://www.powervida.com//img/<CFOUTPUT>#session.langcode#</CFOUTPUT>/products-home.jpg"></span>
<span class='st_linkedin_large' displayText='LinkedIn' st_summary="Come and see the great Products and Opportunity at PowerVida!" st_url="http://www.powervida.com/<CFOUTPUT>#url.u#</CFOUTPUT>/" st_title="http://www.powervida.com//img/<CFOUTPUT>#session.langcode#</CFOUTPUT>/products-home.jpg"></span>
<span class='st_pinterest_large' displayText='Pinterest' st_summary="Come and see the great Products and Opportunity at PowerVida!" st_url="http://www.powervida.com/<CFOUTPUT>#url.u#</CFOUTPUT>/" st_title="http://www.powervida.com//img/<CFOUTPUT>#session.langcode#</CFOUTPUT>/products-home.jpg"></span>
<span class='st_email_large' displayText='Email' st_summary="Come and see the great Products and Opportunity at PowerVida!" st_url="http://www.powervida.com/<CFOUTPUT>#url.u#</CFOUTPUT>/" st_title="Sharing PowerVida" st_image="http://www.powervida.com//img/<CFOUTPUT>#session.langcode#</CFOUTPUT>/products-home.jpg"></span>
</div>            
<button aria-label="Close" data-dismiss="modal" class="close" type="button"><span aria-hidden="true">X</span></button>
</div>
<div class="flex-video">
<cfoutput>
<iframe src="#pGetVideoContent_Result.strContentImg1#" width="100%" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</cfoutput>
</div> 
</div>
</div>
</div>
</div>