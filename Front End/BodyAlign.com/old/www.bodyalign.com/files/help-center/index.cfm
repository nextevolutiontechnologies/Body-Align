<CFINCLUDE template="/public/header.cfm">  

    <CFINCLUDE template="/public/main-nav.cfm">

    <!-- Wrapper -->
    <div class="wrapper">

      <!-- Topic Header -->
      <div class="color-jumbotron">
        <div class="container">
          <div class="row">
            <div class="col-sm-12">
              <h1 class="text-center">Help Center</h1>
              <h3 class="primary-font text-center">Search our help center for more information:</h3>
              <form class="form-inline text-center" role="form">
                <div class="form-group">
                  <label class="sr-only" for="help-search">Search</label>
                  <input type="text" class="form-control border-color col-sm-12" id="help-search" placeholder="What is your question?" data-original-title="" title="">
                </div>
                <button type="submit" class="btn btn-color"><i class="fa fa-question-circle"></i> Search</button>
              </form>
            </div>
          </div> <!-- / .row -->
        </div> <!-- / .container -->
      </div> <!-- / .color-jumbotron -->
     
      <div class="container">
        <div class="row">
          <div class="col-sm-3">
            <h4 class="primary-font">Categories</h4>
            <hr>
            <ul class="help-cats-p">
              <li><a href="#">Morbi nec sem</a></li>
              <li><a href="#">Integer faucibus</a></li>
              <li><a href="#">Sed lobortis diam</a></li>
              <li><a href="#">Cras pellentesque arcu</a></li>
              <li><a href="#">Donec tincidunt</a></li>
              <li><a href="#">Aliquam at mauris</a></li>
              <li><a href="#">Morbi nec sem</a></li>
              <li><a href="#">Integer faucibus</a></li>
            </ul>
          </div>
          <div class="col-sm-6">
            <h4 class="primary-font">Most Popular Questions</h4>
            <hr>
            <ol class="help-questions-p">
             <CFOUTPUT>
              <li><a href="/#url.u#/help-center/help-item/">Proin pharetra ipsum vel turpis semper dapibus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Vivamus sed magna vulputate, vehicula diam nec, tincidunt purus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Nullam eu turpis in turpis accumsan interdum sit amet vel tortor?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Suspendisse posuere dolor in lobortis rhoncus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Proin pharetra ipsum vel turpis semper dapibus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Vivamus sed magna vulputate, vehicula diam nec, tincidunt purus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Nullam eu turpis in turpis accumsan interdum sit amet vel tortor?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Suspendisse posuere dolor in lobortis rhoncus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Proin pharetra ipsum vel turpis semper dapibus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Vivamus sed magna vulputate, vehicula diam nec, tincidunt purus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Nullam eu turpis in turpis accumsan interdum sit amet vel tortor?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Suspendisse posuere dolor in lobortis rhoncus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Suspendisse posuere dolor in lobortis rhoncus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Proin pharetra ipsum vel turpis semper dapibus?</a></li>
              <li><a href="/#url.u#/help-center/help-item/">Vivamus sed magna vulputate, vehicula diam nec, tincidunt purus?</a></li>
             </CFOUTPUT>
            </ol>

            <!-- Paggination -->
            <ul class="pagination pull-right">
              <li class="disabled"><a href="#">&laquo;</a></li>
              <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
              <li><a href="#">2</a></li>
              <li><a href="#">3</a></li>
              <li><a href="#">4</a></li>
              <li><a href="#">5</a></li>
              <li><a href="#">&raquo;</a></li>
            </ul>
            <div class="clearfix"></div>

          </div>
          <div class="col-sm-3">
            <h4 class="primary-font">Contact Us</h4>
            <hr>
            <p>
              PowerVida, LLC<br>
              4417 Hudson Bend Road<br>
              Austin, TX 78734<br>
              Phone:  (888) 789-5330<br>
            </p>
            <p>
              <a href="/<CFOUTPUT>#url.u#</CFOUTPUT>/contact/" class="btn btn-color"><i class="fa fa-envelope"></i> Contact Us</a>
            </p>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </div> <!-- / .wrapper -->

    <CFINCLUDE template="/public/footer.cfm">