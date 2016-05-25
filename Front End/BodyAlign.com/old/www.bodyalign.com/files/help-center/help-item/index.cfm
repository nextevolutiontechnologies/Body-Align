<CFINCLUDE template="/public/header.cfm">  

    <CFINCLUDE template="/public/main-nav.cfm">

    <!-- Wrapper -->
    <div class="wrapper">

      <!-- Topic Header -->
      <div class="color-jumbotron">
        <div class="container">
          <div class="row">
            <div class="col-sm-12">
              <form class="form-inline text-center first-child" role="form">
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
            <h4 class="primary-font">Do you provide support for this item?</h4>
            <hr>
            <p>
              Yes, do not hesitate to contact us if you have any questions or requests regarding this item. 
              <br /><br />
              Sed rutrum quis eros sit amet feugiat. Phasellus vestibulum libero et leo porta, eu scelerisque lacus aliquet. Vivamus euismod tincidunt velit sed malesuada. Pellentesque lacinia est ac lorem placerat tempus. In quis mauris at arcu bibendum fermentum eu quis velit. Pellentesque consequat molestie tortor, eget consectetur leo tristique ac. Quisque egestas arcu sed lectus vulputate, at faucibus quam malesuada. Donec fringilla turpis eros, id accumsan nibh egestas vel. Fusce a magna ut nisl pellentesque tincidunt.
              <br /><br />
              Sed imperdiet varius elit, ut congue arcu lobortis id. Aliquam ultrices ligula eu neque rutrum tincidunt. Pellentesque non metus neque. Donec blandit metus eu venenatis fringilla. Nam ut dui lorem. Nulla euismod a neque eget pulvinar. Proin cursus tristique lectus at iaculis. Phasellus elementum, mi in feugiat pulvinar, dui justo fermentum justo, a dapibus mi ligula nec nunc. Etiam a purus porta, mollis nulla ut, tempus elit. Quisque consectetur bibendum neque, vel tincidunt urna ultricies at. Mauris purus mauris, laoreet dapibus convallis non, tincidunt in elit. Nullam vel ligula nibh. Praesent egestas ullamcorper malesuada. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Quisque rhoncus venenatis nunc non posuere.
            </p>
            <!-- Pagination -->
            <ul class="pager pull-right">
              <li><a href="#">Previous</a></li>
              <li><a href="#">Next</a></li>
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
              Phone:  (888) 789-5330
            </p>
            <p>
              <a href="/<CFOUTPUT>#url.u#</CFOUTPUT>/contact/" class="btn btn-color"><i class="fa fa-envelope"></i> Contact Us</a>
            </p>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->

    </div> <!-- / .wrapper -->

    <CFINCLUDE template="/public/footer.cfm">