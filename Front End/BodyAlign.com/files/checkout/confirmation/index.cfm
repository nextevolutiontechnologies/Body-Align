<CFINCLUDE template="/public/global_header.cfm">
<CFINCLUDE template="/public/header.cfm">

<!---<cfstoredproc procedure="pGetOrderInfo" debug="yes" datasource="#application.datasource#">
    <cfprocresult name="pGetOrderInfo_Result">
	<cfprocparam cfsqltype="CF_SQL_integer" null="yes" >
    <cfprocparam cfsqltype="CF_SQL_varchar" variable="strOrderGUID" type="in" value="#url.o#">
</cfstoredproc>--->
<div id="wrap">
<section class="fullscreen">
        <div class="container v-align-transform">
        <div id="header">
<div id="body">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <div class="feature text-center">
                        <i class="ti-check-box icon icon-lg mb24 mb-xs-0"></i>
                        <h1 class="large">Your order has been completed!</h1>
                        <p class="mb40 mb-xs-24">You will receive a confirmation email shortly.
                            <a href="<cfoutput>/#url.u#/</cfoutput>">Back to home page</a>
                        </p>
                     <!---   <cfloop query="pGetOrderInfo_Result">
                        	<cfoutput>#strProduct#<br></cfoutput>
                        </cfloop>--->
                        <ul class="list-inline social-list">
                            <li>
                                <a href="#">
                                    <i class="icon icon-sm ti-twitter-alt"></i>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <i class="icon icon-sm ti-facebook"></i>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <i class="icon icon-sm ti-dribbble"></i>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <i class="icon icon-sm ti-vimeo-alt"></i>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--end of row-->
            <div class="embelish-icons">
                <i class="ti-pencil-alt"></i>
                <i class="ti-check"></i>
                <i class="ti-envelope"></i>
                <i class="ti-announcement"></i>
                <i class="ti-signal"></i>
                <i class="ti-pulse"></i>
                <i class="ti-marker"></i>
                <i class="ti-layout"></i>
                <i class="ti-ruler-alt-2"></i>
                <i class="ti-eye"></i>
                <i class="ti-signal"></i>
                <i class="ti-pulse"></i>
            </div>
        </div>
        <!--end of container-->
         </div>
        </div>
    </section>
 </div>
<CFINCLUDE template="/public/footer.cfm">
<CFINCLUDE template="/public/global_footer.cfm">