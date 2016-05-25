<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/img/favicon.png">

    <title>PowerVida - Coming Soon</title>

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

  <body class="body-green coming-soon-p">

    <div class="container">
      <div class="row">
        <div class="col-xs-12">
          <!-- Main Content -->
          <h1 class="text-center">Coming Soon...</h1>
          <p class="lead text-center">
            We are currently working on a new version of our website.<br />
            Enter your e-mail below to stay tuned.
          </p>
          <form class="form-inline text-center" role="form">
            <div class="form-group">
                <label class="sr-only" for="email">Email address</label>
              <input type="email" class="form-control border-color col-sm-12" id="email" placeholder="Email">
            </div>
            <button type="submit" class="btn btn-color">Subscribe</button>
          </form>
        </div>
      </div>
      <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
          <div id="countdown"></div>
        </div>
      </div>  <!-- / .row -->
    </div> <!-- / .container -->

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/scrolltopcontrol.js"></script>
    <script src="/js/jquery.plugin.min.js"></script>
    <script src="/js/jquery.countdown.min.js"></script>
    <script src="/js/custom.js"></script>

    <script>
    $(function () {
        var austDay = new Date();
        austDay = new Date(austDay.getFullYear() + 1, 1 - 1, 26);
        $('#countdown').countdown({until: austDay});
        $('#year').text(austDay.getFullYear());
    });
    </script>

</body></html>