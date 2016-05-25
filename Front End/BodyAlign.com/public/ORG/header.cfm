	<div class="nav-container">
            <a id="top"></a>
            <!--- Only show absolute transparent classes on home page --->
            <nav <CFIF url.f EQ '/'>class="absolute transparent"</cfif>>
                <div class="nav-bar">
                    <div class="module left">
                        <a href="<cfoutput>/#url.u#/</cfoutput>">
                            <img class="logo logo-light" alt="Foundry" src="/files/img/logo-dark.png" />
                            <img class="logo logo-dark" alt="Foundry" src="/files/img/logo-dark.png" />
                        </a>
                    </div>
                    <div class="module widget-handle mobile-toggle right visible-sm visible-xs">
                        <i class="ti-menu"></i>
                    </div>
                    <div class="module-group right">
                        <div class="module left">
                            <ul class="menu">
                                <li><a href="/<cfoutput>#url.u#</cfoutput>/">Home</a></li>
                            	<li class="has-dropdown"><a href="/<cfoutput>#url.u#</cfoutput>/theopportunity/">The Opportunity</a>
                                    <ul>
                                    <li><a href="/<cfoutput>#url.u#</cfoutput>/theopportunity/">Get Started</a></li>
                                    <li><a href="/files/pdf/powervida-compensationplan-en.pdf" target="_blank">Comp Plan</a></li>
                                	</ul>
                              	</li>
                                <li><a href="/<cfoutput>#url.u#</cfoutput>/the-company/">The Company</a></li>
                                <li class="has-dropdown"><a href="/<cfoutput>#url.u#</cfoutput>/products">Our Products</a>
                                    <ul>
                                        <li class="has-dropdown"><a href="/<cfoutput>#url.u#</cfoutput>/products/!active/">Active</a>
                                            <ul>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/powervida.pv">PowerVida</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/vida-brew.pv">VidaBrew</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/vidablast.pv">VidaBlast</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/vidashake.pv">Vida Shake</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/energy-pack.pv">Energy Pack</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/weight-control-pack.pv">Weight Control Pack</a></li>
                                            </ul>
                                      	</li>
                                        <li class="has-dropdown"><a href="/<cfoutput>#url.u#</cfoutput>/products/!refresh"> Refresh</a>
                                            <ul>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/AloeVida.pv">AloeVida</a>
                                            </ul>
                                        </li>
                                        <li>
                                      	<li class="has-dropdown"><a href="/<cfoutput>#url.u#</cfoutput>/products/!revitalize"> Revitalize</a>
                                         		<ul>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/Collagen.pv">Collagen</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/PowerSilver.pv">PowerSilver</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/VidaVitamin.pv">VidaVitamin</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/Beauty-Pack.pv">Beauty Pack</a></li>
                                                <li><a href="/<cfoutput>#url.u#</cfoutput>/products/Health-Pack.pv">Health Pack</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="/<cfoutput>#url.u#</cfoutput>/relax/">Relax</a></li>
                                		</ul>
                              	</li>
                                <li><a href="/<cfoutput>#url.u#</cfoutput>/contact/">Contact Us</a></li>
                          	</ul>
                        </div><!--end of menu module-->
                        <div class="module widget-handle search-widget-handle left">
                        	<ul class="menu">
                           <li><a href="https://member.powervida.com" target="_blank">Member Login</a></li>
						   </ul>
                        </div>
                        <div class="module widget-handle cart-widget-handle left">
                        	<cfoutput>

                            <div class="cart">
                                <i class="ti-bag"></i>
                                <cfif pGetCartItems_Result.intCartTypeid eq 1>
                                <span class="label number">
                                	<cfif pGetCartItems_Result.recordcount gt 0 and pGetCartItems_Result.quantity gt 0 >#pGetCartItems_Result.recordcount#<cfelse>0</cfif></span>
                                <span class="title">Shopping Cart</span>
                                </cfif>
                            </div>

                            <cfif pGetCartItems_Result.recordcount gt 0 and pGetCartItems_Result.quantity gt 0 and pGetCartItems_Result.intCartTypeid eq 1>
                            <div class="function">
                                <div class="widget">
                                    <h6 class="title">Shopping Cart</h6>
                                    <hr>
                                    <ul class="cart-overview">
                                    	<cfloop query="pGetCartItems_Result">
                                    		<li>
                                            <a href="##">
                                                <img alt="Product" src="/files/img/products/#strURLFriendly#.png"/>
                                                <div class="description">
                                                    <span class="product-title">#strProduct#</span>
                                                    <span class="price number">#dollarformat(subTotal)#</span>
                                                </div>
                                            </a>
                                        </li>
                                    	</cfloop>

                                    </ul>

                                    <hr>
                                    <div class="cart-controls">
                                        <a class="btn btn-sm btn-filled" href="/<cfoutput>#url.u#</cfoutput>/checkout/">Checkout</a>
                                        <div class="list-inline pull-right">
                                            <span class="cart-total">Total: </span>
                                            <span class="number">#pGetCartItems_Result.amtTotal#</span>
                                        </div>
                                    </div>


                                </div><!--end of widget-->
                            </div>
                            </cfif>
                            </cfoutput>
                        </div>
                        <div class="module widget-handle language left">
                            <ul class="menu">
                                <li class="has-dropdown">
                                	<a href="##" id="dropdownlan" data-toggle="dropdown">
<cfif session.countryCode eq 'MX'>
	 <CFIF session.lang eq 2> Esp<CFELSE> Ingles</CFIF>
<cfelse>
	<CFIF session.lang eq 2> Spanish<CFELSE> English</CFIF>
</cfif>
</a>
<ul >
<li ><a  tabindex="-1" href="/public/choose-language/?lang=1&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><CFIF session.lang EQ 2> Ingles<CFELSE> English</CFIF></a></li>
<li ><a  tabindex="-1" href="/public/choose-language/?lang=2&returnURL=<cfoutput>#cgi.HTTP_REFERER#</cfoutput>"><CFIF session.lang EQ 2> Esp<CFELSE> Spanish</CFIF></a></li>
</ul>

                                </li>
                            </ul>
                        </div>
                    </div><!--end of module group-->
                </div>
            </nav>
        </div>
    <div class="main-container">