<!-- Jumbotron -->

<cfstoredproc procedure="dbo.pGetContentList" debug="yes" datasource="#application.datasource#" >		
	<cfprocresult name="GetSliders">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intContentTypeID" type="in" Value="15">
	<cfprocparam cfsqltype="CF_SQL_bit" variable="isActive" type="in" value="1">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" Value="#session.lang#">
		<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
</cfstoredproc>
<CFQUERY name="GetSliders" dbtype="query">
	select * from GetSliders order by intOrderBY
</CFQUERY>

<div class="main-slideshow">
<div id="main-slideshow" class="carousel slide" data-ride="carousel" data-interval="11000">
<div class="carousel-inner">
<!-- Slide No 1 -->
<cfoutput query="GetSliders">
<!-- Slide No 1 -->
<div class="item <cfif currentrow eq 1>active</cfif>">
  <div class="jumbotron #LCase(strContentCSS)#" style="background: url(/common/img/slider/#session.langcode#/#strContentImg2#) no-repeat center center;background-size: cover;">
    <div class="color-stripe">
    	<div class="container">
      	<div class="row">
        	<div class="col-md-7 col-sm-6">
            <h1 class="animated slideInLeft">#strContentText1#</h1>
            <p class="lead animated slideInLeft delay-1">
            #strContentText2#
            </p>
          </div>
          <div class="col-md-5 col-sm-6">          	
    				<img class="hidden-xs" src="/common/img/slider/#session.langcode#/#strContentImg1#" alt="#strContentText1#">
          </div>
        </div>
        <a class="btn btn-#strContentCSS# animated slideInLeft delay-2" href="/#url.u##strContentLink#">#strContentText3#</a>
      </div>
    </div>    
  </div>
</div>
</cfoutput>

<!---OPPORTUNITY SLIDES--->

<!---<!-- Slide No 6 -->
<div class="item">
  <div class="jumbotron opportunity1">
    <div class="color-stripe">
    	<div class="container">
      	<div class="row">
        	<div class="col-md-7 col-sm-6">
            <h1 class="animated slideInLeft">Start Living</h1>
            <p class="lead animated slideInLeft delay-1">
            Start LIVING your life to the fullest - and help others do the same! As a PowerVida distributor, you have the opportunity to create residual income for your family while receiving 
            great discounts on products!
            </p>
          </div>
          <div class="col-md-5 col-sm-6">          	
    				<img class="hidden-xs" src="/img/opportunity1-slide-img.png" alt="Powervida Opportunity">
          </div>
        </div>
        <a class="btn btn-purple animated slideInLeft delay-2" href="/<CFOUTPUT>#url.u#</CFOUTPUT>/theopportunity/">Live Life Now</a>
      </div>
    </div>    
  </div>
</div>
<!-- Slide No 7 -->
<div class="item">
  <div class="jumbotron opportunity2">
    <div class="color-stripe">
    	<div class="container">
      	<div class="row">
        	<div class="col-md-7 col-sm-7">
            <h1 class="animated slideInLeft">Become Powerfull</h1>
            <p class="lead animated slideInLeft delay-1">
            At PowerVida, we welcome you to start out on a new adventure. PowerVida offers you an opportunity to create the power life you've always wanted. Begin your adventure with PowerVida 
            TODAY and watch your future begin NOW.
            </p>
          </div>
          <div class="col-md-5 col-sm-5">          	
    				<img class="hidden-xs" src="/img/opportunity2-slide-img.png" alt="Powervida Opportunity">
          </div>
        </div>
        <a class="btn btn-lt-blue animated slideInLeft delay-2" href="/<CFOUTPUT>#url.u#</CFOUTPUT>/theopportunity/">Get Soothed</a>
      </div>
    </div>    
  </div>
</div>--->

<!---END OPPORTUNITY SLIDES--->

</div>
<!-- Controls -->
<a class="slideshow-arrow slideshow-arrow-prev bg-hover-color" href="#main-slideshow" data-slide="prev">
<i class="fa fa-angle-left"></i>
</a>
<a class="slideshow-arrow slideshow-arrow-next bg-hover-color" href="#main-slideshow" data-slide="next">
<i class="fa fa-angle-right"></i>
</a>
</div>
</div> <!-- / Slideshow -->
