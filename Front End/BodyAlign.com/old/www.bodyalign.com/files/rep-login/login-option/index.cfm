<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/img/favicon.png">

    <title>PowerVida - Login In</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/color-styles.css" rel="stylesheet">
    <link href="/css/ui-elements.css" rel="stylesheet">
    <link href="/css/custom.css" rel="stylesheet">
    
    <!-- Resources -->
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Oswald:400,700,300' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,500,400italic,500italic,700italic' rel='stylesheet' type='text/css'>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
  </head>

  <body class="body-green">

    <div class="alt-p">
      <div class="container">
        <div class="row">
          <div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
            <!-- Logo -->
            <div class="logo">
              <p class="text-center"><a href="/<CFOUTPUT>#url.u#</CFOUTPUT>"><img src="/img/main-logo.png" alt="PowerVida Logo"></a></p>
            </div> <!-- / .logo -->
            <div class="sign-form">
              <h3 class="first-child text-center">Sign In To Your Account</h3>
              <hr>
              <form role="form">
                <div class="input-group">
                  <span class="input-group-addon"><i class="fa fa-user"></i></span>
                  <input type="email" class="form-control" id="email" placeholder="Enter email" data-original-title="" title="">
                </div>
                <br>
                <div class="input-group">
                  <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                  <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" data-original-title="" title="">
                </div>
                <div class="checkbox">
                  <label>
                    <input type="checkbox"> Remember me
                  </label>
                </div>
                <button type="submit" class="btn btn-color">Submit</button>
                <hr>
              </form>
              <p>Not registered? <a href="#">Create an Account.</a></p>
              <div class="pwd-lost">
                <div class="pwd-lost-q show">Lost your password? <a href="#">Click here to recover.</a></div>
                <div class="pwd-lost-f hidden">
                  <p class="text-muted">Enter your email address and we will send you a link to reset your password.</p>
                  <form class="form-inline" role="form">
                    <div class="form-group">
                      <label class="sr-only" for="email-pwd">Email address</label>
                      <input type="email" class="form-control" id="email-pwd" placeholder="Enter email">
                    </div>
                    <button type="submit" class="btn btn-color">Send</button>
                  </form>
                </div>
              </div> <!-- / .pwd-lost -->
            </div>
          </div>
        </div> <!-- / .row -->
      </div> <!-- / .container -->
    </div>

    <!-- Style Toggle -->
    <div class="style-toggle text-left hidden-xs">
      <i class="fa fa-gears style-toggle-btn"></i>
      <div class="style-toggle-header text-center">
        Navbar Type
      </div>
      <!-- Navbar Type -->
      <div class="style-toggle-body text-left">
        <fieldset disabled>
        <div class="radio">
          <label>
            <input type="radio" name="navbar" id="opt-navbar-dark" value="opt-navbar-dark" checked>
            Navbar Dark (default)
          </label>
        </div>
        <div class="radio">
          <label>
            <input type="radio" name="navbar" id="opt-navbar-white" value="opt-navbar-white">
            Navbar White
          </label>
        </div>
        <div class="radio">
          <label>
            <input type="radio" name="navbar" id="opt-navbar-mixed" value="opt-navbar-mixed">
            Navbar Mixed
          </label>
        </div>
        </fieldset>
      </div>
      <!-- Color Styles-->
      <div class="style-toggle-header text-center">
        Color Styles
      </div>
      <div class="style-toggle-body text-center">
        <ul class="colors list-inline">
          <li class="green"></li>
          <li class="blue"></li>
          <li class="orange"></li>
          <li class="red"></li>
        </ul>
      </div>
      <!-- Footer Type -->
      <div class="style-toggle-header text-center">
        Footer Type
      </div>
      <div class="style-toggle-body text-left">
        <fieldset disabled>
        <div class="radio">
          <label>
            <input type="radio" name="footer" id="opt-footer-dark" value="opt-footer-dark" checked>
            Footer Dark (default)
          </label>
        </div>
        <div class="radio">
          <label>
            <input type="radio" name="footer" id="opt-footer-white" value="opt-footer-white">
            Footer White
          </label>
        </div>
        </fieldset>
        <hr>
        <a href="theme-faq.html"><i class="fa fa-question-circle"></i> Using color schemes on a production site.</a>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/custom.js"></script>

</body></html>