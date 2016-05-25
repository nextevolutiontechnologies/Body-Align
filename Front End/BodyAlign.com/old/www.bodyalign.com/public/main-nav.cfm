<CFPARAM name="session.CustFirstName" default="">
<CFOUTPUT>
<div class="navContain navbar-static-top">
<div class="mini-navbar mini-navbar-dark hidden-xs">
<div class="container">
<div class="col-sm-12">
<p class="first-child">#pGetMemberWebsite_Results.strFullName#</p>

<a href="/#url.u#/contact/"><i class="fa fa-envelope"></i> <CFIF session.lang EQ 2>Correo<CFELSE>Email</CFIF><span class="hidden-sm">: <cfif Application.BrandID eq 2>Contact Me<cfelse>#url.u#@#application.emaildomain#</cfif></span></a>

<CFIF pGetMemberWebsite_Results.strPhone gt ''>
<span class="phone">
<i class="fa fa-phone-square"></i> #pGetMemberWebsite_Results.strPhone#
</span>
</CFIF>
<a href="http://#Application.BackOfficeURL#/"><CFIF session.lang EQ 2>Acceso de Miembro<CFELSE>Member Login</CFIF> <i class="fa fa-sign-in"></i></a>
<!---SHOPPING CART INDICATOR--->     	
<a href="/#url.u#/products/check-out/" class="cart-btn-main pull-right" title="<CFIF session.lang EQ 2>VEA SU CARRITO DE COMPRA<CFELSE>View Your Shopping Cart</CFIF>">
<cfif session.lang EQ 2>
	<CFIF isDefined("Session.ItemCount") and Session.ItemCount GT 0> #session.ItemCount# Art&iacute;culos
		<CFIF isDefined("Session.custID") and Session.CustID GT 0>
		(#session.CustFirstName#, Pedido Ahora)
		<CFELSE>
		(Pedido Ahora)
		</CFIF>        
	<CFELSE>
	0 Productos <CFIF isDefined("Session.custID") and Session.CustID GT 0>(Entrar)<CFELSE>(Fuera de Sistemes)</CFIF>
	</CFIF>
<cfelse>
<CFIF isDefined("Session.ItemCount") and Session.ItemCount GT 0> #session.ItemCount# items
	<CFIF isDefined("Session.custID") and Session.CustID GT 0>
	(#session.CustFirstName#, Checkout Now)
	<CFELSE>
	(Checkout Now)
	</CFIF>        
<CFELSE>
0 items <CFIF isDefined("Session.custID") and Session.CustID GT 0>(Logged In)<CFELSE>(Not Logged In)</CFIF>
</CFIF>	
</cfif>
<i class="fa fa-shopping-cart pull-right cartIcon"></i>
</a>     
<!---END SHOPPING CART INDICATOR--->
<div class="dropdown pull-right">
<a href="##" class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">
<cfif session.countryCode eq 'MX'><img src="/common/img/flag_mx.gif" height="17">
	 <CFIF session.lang eq 2> Spanish<CFELSE> English</CFIF>
<cfelse><img src="/common/img/flag_us.gif" height="17"> 
	<CFIF session.lang eq 2> Spanish<CFELSE> English</CFIF>
</cfif>
<span class="caret"></span>
</a>
<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
<li role="presentation"><a role="menuitem" tabindex="-1" href="/public/choose-language/?lang=1&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><img src="/common/img/flag_us.gif" width="35"> <CFIF session.lang EQ 2> Ingles<CFELSE> English</CFIF></a></li>
<li role="presentation"><a role="menuitem" tabindex="-1" href="/public/choose-language/?lang=2&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><img src="/common/img/flag_us.gif" width="35"> <CFIF session.lang EQ 2> Espa&##241;ol<CFELSE> Spanish</CFIF></a></li>
<li role="presentation"><a role="menuitem" tabindex="-1" href="/public/choose-language/?lang=1&cntry=2&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><img src="/common/img/flag_mx.gif" width="35"> <CFIF session.lang EQ 2> Ingles<CFELSE> English</CFIF></a></li>
<li role="presentation"><a role="menuitem" tabindex="-1" href="/public/choose-language/?lang=2&cntry=2&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><img src="/common/img/flag_mx.gif" width="35"> <CFIF session.lang EQ 2> Espa&##241;ol<CFELSE> Spanish</CFIF></a></li> 
</ul>
</div>
</div>
</div>
</div>
<div class="navbar navbar-white " role="navigation" style="z-index: 1020;">
<div class="container">
<!-- Navbar Header -->
<div class="navbar-header">
<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
<span class="sr-only">Toggle navigation</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<a class="navbar-brand" href="/#url.u#/"><img src="/files/img/<CFOUTPUT>#application.brandname#</CFOUTPUT>/main-logo.png" alt="<CFOUTPUT>#application.brandname#</CFOUTPUT> Logo" /></a><br>
</div>
<!-- / Navbar Header -->
<!-- Navbar Links -->
<cfparam name="this.ActiveNav" default="" >

	<CFQUERY name="GetMainMenu" datasource="#application.datasource#" >
	SELECT mi.intMenuItemID,mi.strMenuItemURL,mil.strMenuItem,m.strMenuCSS,mi.strMenuItemIcon,strMenuItemCSS
	FROM MENU_ITEM mi with (nolock)
	INNER JOIN MENU m with (nolock) on  mi.intMenuID = m.intMenuID
	INNER JOIN MENU_ITEM_LANG mil with (nolock) on mil.intLanguageID = #session.lang#
	and mi.intMenuItemID = mil.intMenuItemID
	WHERE <CFIF application.brandid eq 2> mi.intMenuID = 120 <CFELSE> mi.intMenuID = 40</cfif>
	 and m.intBrandID='#application.BrandID#'
	 Order by mi.intOrderBy
	</CFQUERY>

<div class="navbar-collapse collapse">
<ul class="nav navbar-nav navbar-right">
<CFLOOP query="GetMainMenu" >
<CFOUTPUT><li <cfif this.activenav EQ strMenuItem> class="active"</cfif>><a href="/#url.u##strMenuItemURL#" class="bg-hover-color">#strMenuItem#</a></li></CFOUTPUT>
</CFLOOP>
<!---SHOPPING CART INDICATOR--->
<li class="visible-xs">
<a href="/#url.u#/products/check-out/" class="bg-hover-color" title="<CFIF session.lang EQ 2>VEA SU CARRITO DE COMPRA<CFELSE>View Your Shopping Cart</CFIF>">
<cfif session.lang EQ 2>
	<CFIF isDefined("Session.ItemCount") and Session.ItemCount GT 0> #session.ItemCount# Art&iacute;culos
		<CFIF isDefined("Session.custID") and Session.CustID GT 0>
		(#session.CustFirstName#, Pedido Ahora)
		<CFELSE>
		(Pedido Ahora)
		</CFIF>        
	<CFELSE>
	0 Art&iacute;culos <CFIF isDefined("Session.custID") and Session.CustID GT 0>(has ingresado)<CFELSE>(No has iniciado sesi&oacute;n)</CFIF>
	</CFIF>
<CFELSE>
	<CFIF isDefined("Session.ItemCount") and Session.ItemCount GT 0> #session.ItemCount# items
	<CFIF isDefined("Session.custID") and Session.CustID GT 0>(#session.CustFirstName#, Checkout Now)<CFELSE>(Checkout Now)</CFIF>        
	<CFELSE>
	0 items <CFIF isDefined("Session.custID") and Session.CustID GT 0>(Logged In)<CFELSE>(Not Logged In)</CFIF>
</CFIF>

</CFIF>
<i class="fa fa-shopping-cart cartIcon"></i>
</a>
</li>
<!---END SHOPPING CART INDICATOR--->
<li class="dropdown visible-xs">
<a href="##" class="dropdown-toggle bg-hover-color" data-toggle="dropdown"><cfif session.lang eq 2><img src="/common/img/flag_mx.gif" height="17"> Spanish<cfelse><img src="/common/img/flag_us.gif" height="17"> English</cfif><span class="caret"></span></a>
<ul class="dropdown-menu">

<li role="presentation"><a class="bg-hover-color" role="menuitem" tabindex="-1" href="/public/choose-language/?lang=1&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><img src="/common/img/flag_us.gif" width="35"> <CFIF session.lang EQ 2> Ingles<CFELSE> English</CFIF></a></li>
<li role="presentation"><a class="bg-hover-color" role="menuitem" tabindex="-1" href="/public/choose-language/?lang=2&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><img src="/common/img/flag_us.gif" width="35"> <CFIF session.lang EQ 2> Espa&##241;ol<CFELSE> Spanish</CFIF></a></li>
<li role="presentation"><a class="bg-hover-color" role="menuitem" tabindex="-1" href="/public/choose-language/?lang=1&cntry=2&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><img src="/common/img/flag_mx.gif" width="35"> <CFIF session.lang EQ 2> Ingles<CFELSE> English</CFIF></a></li>
<li role="presentation"><a class="bg-hover-color" role="menuitem" tabindex="-1" href="/public/choose-language/?lang=2&cntry=2&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><img src="/common/img/flag_mx.gif" width="35"> <CFIF session.lang EQ 2> Espa&##241;ol<CFELSE> Spanish</CFIF></a></li> 
</ul>
</li>
</ul>
</div> <!-- / Navbar Links -->
</div> <!-- / container -->
</div> <!-- / navbar -->
</div><!-- /.navContain -->
</CFOUTPUT>
