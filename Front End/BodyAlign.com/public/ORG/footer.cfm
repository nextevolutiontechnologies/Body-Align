			<footer class="footer-1 bg-dark">
                <div class="container">
                    <div class="row">
                        <div class="col-md-3 col-sm-6">
                            <img alt="Logo" class="logo" src="/files/img/logo-light.png" />
							</br>
							</br>
							<h5><strong><cfif isdefined("pGetMemberWebsite_results.strfullname")><cfoutput>#pGetMemberWebsite_results.strfullname#</cfoutput></cfif></strong><br>
                            <cfif isdefined("pGetMemberWebsite_results.strEmail")><cfoutput>#pGetMemberWebsite_results.strEmail#</cfoutput></cfif></h5>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="widget">
                                <h6 class="title">Contact Us</h6>
                                <hr>
                                  <p><strong>POWERVIDA</strong><br>
                                  4417 Hudson Bend Road<BR> 
                                  Austin, TX 78734<br><br>
                                  888-348-6373 <strong>US</strong><br>787-985-7095 <strong>PR</strong><br>
</p>
                            </div><!--end of widget-->
                        </div>
                        <div class="col-md-3 col-sm-6">
                          <div class="widget">
                                <h6 class="title">Get Social</h6>
                                <hr>
                            <p>Stay in touch with us:</p>
                            <a href="https://www.facebook.com/powervidanow" target="_blank"><img src="/files/img/facebook.png" alt="" width="75"/></a>
                            </div><!--end of widget-->
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="widget">
                                <h6 class="title">Subscribe</h6>
                                <hr>
                                <p>Enter your e-mail below to subscribe to our free newsletter.
                                  We promise not to bother you often!</p>
                                  <input type="text" name="strSubscribe" placeholder="Email Address"><br>
                                  <a class="btn btn-sm btn-filled" href="#">Submit</a>
                          		</div>
                            </div>
                            <div class="col-sm-12">
                            <span class="sub">&copy; Powervida <cfoutput>#dateformat(now(),"YYYY")#</cfoutput>. <a href="/<cfoutput>#url.u#</cfoutput>/privacy-policy/">Privacy Policy</a> | <a href="/<cfoutput>#url.u#</cfoutput>/termsandconditions">Terms &amp; Conditions</a> | <a href="https://member.powervida.com" target="_blank">Member Login</a></span>
                        </div>
                    </div><!--end of row-->
                </div>
            </footer>
        </div><!--end of main-contaianer-->
        