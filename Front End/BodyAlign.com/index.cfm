<!--- Code to allow for custom stuff - add custom stuff between cfsavecontenttags --->
<CFSAVECONTENT variable="customhead">
<script type="text/javascript" src="/global/js/jquery.js"></script>
<script type="text/javascript" src="/files/js/jquery.themepunch.tools.min.js"></script>
<script type="text/javascript" src="/files/js/jquery.themepunch.revolution.min.js"></script>
<!-- SLIDER REVOLUTION 5.0 EXTENSIONS  (Load Extensions only on Local File Systems !  The following part can be removed on Server for On Demand Loading) -->
<script type="text/javascript" src="/files/js/extensions/revolution.extension.actions.min.js"></script>
<script type="text/javascript" src="/files/js/extensions/revolution.extension.carousel.min.js"></script>
<script type="text/javascript" src="/files/js/extensions/revolution.extension.kenburn.min.js"></script>
<script type="text/javascript" src="/files/js/extensions/revolution.extension.layeranimation.min.js"></script>
<script type="text/javascript" src="/files/js/extensions/revolution.extension.migration.min.js"></script>
<script type="text/javascript" src="/files/js/extensions/revolution.extension.navigation.min.js"></script>
<script type="text/javascript" src="/files/js/extensions/revolution.extension.parallax.min.js"></script>
<script type="text/javascript" src="/files/js/extensions/revolution.extension.slideanims.min.js"></script>
<script type="text/javascript" src="/files/js/extensions/revolution.extension.video.min.js"></script>
</CFSAVECONTENT>
<CFSAVECONTENT variable="customfoot">

</CFSAVECONTENT>


<CFINCLUDE template="/public/global_header.cfm">
<CFINCLUDE template="/public/header.cfm">
<div id=myCarousel class="carousel slide col-md-10 col-lg-10">
<article class=content>
<div id=rev_slider_8_1_wrapper class="rev_slider_wrapper fullwidthbanner-container" data-alias=facebook-feed8 style="margin:0px auto;background-color:#dddddd;padding:0px;margin-top:0px;margin-bottom:0px;">
<div id=rev_slider_8_1 class="rev_slider fullwidthabanner" style="display:none;" data-version=5.0.7>
<ul>
<li data-index=rs-28 data-start="1000" data-speed="800" data-transition="notransition" data-slotamount="default" data-easein="Linear.easeNone" data-easeout="default" data-masterspeed="1500" data-thumb="/files/img/home/slider1.jpg" data-rotate="0" data-fstransition="notransition" data-fsmasterspeed="1500" data-fsslotamount="7" data-saveperformance="off"  data-description="slide1" data-title="slide1" data-link="/<cfoutput>#url.u#</cfoutput>/body-aligner/">
<img src="/files/img/home/slider1.jpg" alt="slide1" title="slide1" width=1920 height=1080 data-lazyload="/files/img/home/slider1.jpg" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" class="rev-slidebg" data-no-retina>
</li>
<li data-index=rs-303 data-transition=notransition data-slotamount=default data-easein=Linear.easeNone data-easeout=default data-masterspeed=1500 data-thumb="/files/img/home/slider2.jpg" data-rotate=0 data-saveperformance=off data-description="slide2" data-link="/<cfoutput>#url.u#</cfoutput>/products/">
<img src="/files/img/home/slider2.jpg" alt="slide2" width=1920 height=1280 data-lazyload="/files/img/home/slider2.jpg" data-bgposition="center center" data-bgfit=cover data-bgrepeat=no-repeat class=rev-slidebg data-no-retina>
</li>
<li data-index=rs-302 data-transition=notransition data-slotamount=default data-easein=Linear.easeNone data-easeout=default data-masterspeed=1500 data-thumb="/files/img/home/slider3.jpg" data-rotate=0 data-saveperformance=off   data-description="slide3" data-link="/<cfoutput>#url.u#</cfoutput>/products/argi-align-cardio.ba">
<img src="/files/img/home/slider3.jpg" alt="slide3" width=1920 height=1280 data-lazyload="/files/img/home/slider3.jpg" data-bgposition="center center" data-bgfit=cover data-bgrepeat=no-repeat class=rev-slidebg data-no-retina>
</li>
<li data-index=rs-301 data-transition=notransition data-slotamount=default data-easein=Linear.easeNone data-easeout=default data-masterspeed=1500 data-thumb="/files/img/home/slider4.jpg" data-rotate=0 data-saveperformance=off  data-description="slide4" data-link="/<cfoutput>#url.u#</cfoutput>/science/">
<img src="/files/img/home/slider4.jpg" alt="slide4" width=1920 height=1280 data-lazyload="/files/img/home/slider4.jpg" data-bgposition="center center" data-bgfit=cover data-bgrepeat=no-repeat class=rev-slidebg data-no-retina>
</li>
<li data-index=rs-300 data-transition=notransition data-slotamount=default data-easein=Linear.easeNone data-easeout=default data-masterspeed=1500 data-thumb="/files/img/home/slider5.jpg" data-rotate=0 data-saveperformance=off  data-description="slide5" data-link="/<cfoutput>#url.u#</cfoutput>/body-aligner/">
<img src="/files/img/home/slider5.jpg" alt="slide5" width=300 height=200 data-lazyload="/files/img/home/slider5.jpg" data-bgposition="center center" data-bgfit=cover data-bgrepeat=no-repeat class=rev-slidebg data-no-retina>
</li>
</ul>
<div class="tp-bannertimer tp-bottom" style="visibility: hidden !important;"></div>
</div>
</div>
</article>
</div>
<div class="col-md-2 col-lg-2 boxes cpadding">
<div class="list-box nopadding margin-bottom">
<a href="/<cfoutput>#url.u#</cfoutput>/science/"><div class=list-image style="background:url('/files/img/home/b1.jpg');"></div></a>
</div>
<div class="list-box nopadding margin-bottom">
<a href="/<cfoutput>#url.u#</cfoutput>/products/"><div class=list-image style="background:url('/files/img/home/b2.jpg');"></div></a>
</div>
<div class="list-box nopadding margin-bottom">
<a href="/<cfoutput>#url.u#</cfoutput>/body-aligner/"><div class=list-image style="background:url('/files/img/home/b3.jpg');"></div></a>
</div>
<div class="list-box nopadding margin-bottom">
<a href="/<cfoutput>#url.u#</cfoutput>/contact/"><div class=list-image style="background:url('/files/img/home/b4.jpg');"></div></a>
</div>
</div>
<div class="clearfix"></div>
<CFINCLUDE template="/public/footer.cfm">
<CFINCLUDE template="/public/global_footer_home.cfm">