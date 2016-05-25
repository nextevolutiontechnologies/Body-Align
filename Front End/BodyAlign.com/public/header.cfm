<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
<div class="container ccont">
<!-- Brand and toggle get grouped for better mobile display -->
<div class="navbar-header">
<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
<span class="sr-only">Toggle navigation</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<a class="navbar-brand" href="/"><img src="/files/img/logo.png" /></a>
<div class="clearfix"></div>
</div>
<!-- Collect the nav links, forms, and other content for toggling -->
<div class="collapse navbar-collapse cpull-right" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav">
<li>
<a href="/<cfoutput>#url.u#</cfoutput>/">HOME</a>
</li>
<li>
<a href="/<cfoutput>#url.u#</cfoutput>/about/" title="Click Here to learn About Us">ABOUT US</a>
</li>
<li>
<a href="/<cfoutput>#url.u#</cfoutput>/science/" title="Click Here to learn about our Science"> SCIENCE</a>
</li>
<li>
<a href="/<cfoutput>#url.u#</cfoutput>/products/" title="Click Here to see our Products"> PRODUCTS</a>
</li>
<li>
<a href="/<cfoutput>#url.u#</cfoutput>/body-aligner/" title="Click Here to learn about becoming a Body Aligner"> BODY ALIGNER</a>
</li>
<li>
<a href="/<cfoutput>#url.u#</cfoutput>/contact/" title="Click Here to Contact Us"> CONTACT US</a>
</li>
<li>
<a href="/<cfoutput>#url.u#</cfoutput>/join/" title="Click Here to Join Us"> JOIN US</a>
</li>
<li>
<a href="http://member.bodyalign.com" target="_blank" title="Click Here to Login"> MEMBER LOGIN</a>
</li>
<cfif isdefined("pGetCartItems_Result.intCartTypeid") and pGetCartItems_Result.intCartTypeid eq 1 and pGetCartItems_Result.recordcount gt 0 and pGetCartItems_Result.quantity gt 0>
<li class="cart-full">
<a href="/<cfoutput>#url.u#</cfoutput>/checkout/"> <i class="fa fa-shopping-cart"></i></a>
</li>
<cfelse>
<li><a href="" onclick="return false;"><i class="fa fa-shopping-cart"></i></a></li>
</cfif>
<!---<li class="dropdown">
<a href="#" data-toggle="dropdown" class="dropdown-toggle">ENGLISH <b class="caret"></b></a>
<ul class="dropdown-menu">
<li><a href="#">SPANISH</a></li>
</ul>
</li>--->
</ul>
</div>
<!-- /.navbar-collapse -->
</div>
<!-- /.container -->
</nav>