<CFPARAM name="url.u" default="home" >
<CFPARAM name="url.lang" default="1" type="numeric" >
<!--- <CFPARAM name="session.CountryCode" default="US"> --->
<CFINCLUDE template="/public/checkUserName.cfm">
<CFQUERY name="GetStateList" datasource="#Application.Datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">
	SELECT * FROM StateProvince WHERE strCountryCode = '#session.CountryCode#' ORDER BY intStateID 
</CFQUERY>
<cfstoredproc procedure="pGetMemberWebsite" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetMemberWebsite_Results">
	<cfprocparam variable="intMemberID" cfsqltype="cf_sql_integer" value="#session.memberID#">
</cfstoredproc>
<!DOCTYPE html>
<html lang="en">
<head>
<link href='https://fonts.googleapis.com/css?family=Glegoo' rel='stylesheet' type='text/css'>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<!--<meta http-equiv="X-UA-Compatible" content="IE=edge">-->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="/files/img/<CFOUTPUT>#application.brandname#</CFOUTPUT>/favicon.png">
<CFOUTPUT>
<meta property="og:title" content="Sharing <CFOUTPUT>#application.brandname#</CFOUTPUT>" />
<meta property="og:type" content="Sharing Widgets" />
<meta property="og:url" content="http://#cgi.server_name#/" />
<meta property="og:image" content="http://#cgi.server_name#/img/main-logo.png" />
<meta property="og:description" content="Follow this link and find out about the Powervida Opportunity." />
<meta property="og:site_name" content="#Application.ClientName# Website" />
<title>#Application.ClientName#</title>
</CFOUTPUT>
<!-- Bootstrap core CSS -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<CFOUTPUT>
<link href="/css/#application.brandname#-color-styles.css" rel="stylesheet">
<link href="/css/#application.brandname#-ui-elements.css" rel="stylesheet">
<link href="/css/#application.brandname#-custom.css" rel="stylesheet">
</CFOUTPUT>
<link rel="stylesheet" href="/common/js/plugins/datepicker/datepicker.css" type="text/css" />
<!-- Resources -->
<link href="/css/bootstrapValidator.min.css" rel="stylesheet">
<link href="/css/animate.css" rel="stylesheet">
<link href="/css/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Oswald:400,700,300' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,700,500,400italic,500italic,700italic' rel='stylesheet' type='text/css'>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="https://ws.sharethis.com/button/buttons.js"></script>
<script type="text/javascript">stLight.options({publisher: "d6e7569f-207e-4baa-9484-0da7f9bbee15",shorten:false, doNotHash: true, doNotCopy: true, hashAddressBar: false});</script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', '<cfoutput>#Application.GoogleID#</cfoutput>', 'auto');
  ga('send', 'pageview');

</script>
<meta name="google-site-verification" content="QtbRB1nxEL7DujNrIBpD2OcR-0Ed1z4jVMa9ll6ekzQ" />
</head>
<body class="body-green">