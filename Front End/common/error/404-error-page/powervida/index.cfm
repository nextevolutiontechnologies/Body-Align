<CFPARAM name="url.u" default="">
<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/img/favicon.png">

    <title>PowerVida - 404 Error Page</title>

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

    <div class="not-found-p">
      <div class="text">
	  <CFOUTPUT>
	  		<p><a href="http://#CGI.HTTP_HOST#/#url.u#/" class="btn btn-color">Click to go Back to the Home Page</a></p>
      </CFOUTPUT>
        <p><img src="/img/main-logo.png" alt="PowerVida Logo"></p>
        <h2 class="primary-font">Page not found</h2>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/custom.js"></script>

</body></html>