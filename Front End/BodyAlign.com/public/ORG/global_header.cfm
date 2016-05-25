<CFPARAM name="url.u" default="home" >
<CFPARAM name="url.lang" default="1" type="numeric" >
<CFPARAM name="session.CountryCode" default="US">
<CFPARAM name="session.CartID" default="0" type="numeric" >
<CFINCLUDE template="/public/checkUserName.cfm">

<CFQUERY name="GetStateList" datasource="#Application.Datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">
	SELECT * FROM StateProvince <!---WHERE strCountryCode = '#session.CountryCode#'---> ORDER BY intStateID
</CFQUERY>

<cfstoredproc procedure="pGetMemberWebsite" debug="yes" datasource="#application.datasource#">
	<cfprocresult name="pGetMemberWebsite_Results">
	<cfprocparam variable="intMemberID" cfsqltype="cf_sql_integer" value="#session.memberID#">
</cfstoredproc>

<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">
    <cfprocresult name="pGetCartItems_Result">
      <cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
		<link rel="shortcut icon" href="/files/img/favicon.png">
		<meta property="og:title" content="Sharing Powervida" />
		<meta property="og:type" content="Sharing Widgets" />
		<meta property="og:url" content="http://www.powervida.com/" />
		<meta property="og:image" content="http://www.powervida.com/img/main-logo.png" />
		<meta property="og:description" content="Follow this link and find out about the Powervida Opportunity." />
		<meta property="og:site_name" content="Powervida Website" />

        <title>PowerVida | Be healthy. Be Strong. Be Well.</title>
        <meta name="viewport" content="width=device-width, initial-scale=0.9">
        <link href="/global/css/bootstrap-3.3.5.min.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/global/js/plugins/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
        <link href="/global/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="/files/css/themify-icons.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/files/css/flexslider.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/global/css/bootstrapValidator-0.5.3.min.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/css/theme-nature.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/css/font-oswald.css" rel="stylesheet" type="text/css" media="all" />
        <link href="/css/custom.css" rel="stylesheet" type="text/css" media="all" />
        <link href='http://fonts.googleapis.com/css?family=Lato:300,400%7CRaleway:100,400,300,500,600,700%7COpen+Sans:400,500,600' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Oswald:300,400,600,700' rel='stylesheet' type='text/css'>
        <script>
					(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
					(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
					m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
					})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

					ga('create', '<cfoutput>#Application.GoogleID#</cfoutput>', 'auto');
					ga('send', 'pageview');
				</script>
    </head>
    <body>
