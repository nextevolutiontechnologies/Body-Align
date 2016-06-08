<CFPARAM name="url.u" default="home" >
<CFPARAM name="url.lang" default="1" type="numeric" >
<CFPARAM name="session.CountryCode" default="US">
<CFPARAM name="session.CartID" default="0" type="numeric" >
<CFINCLUDE template="/public/checkUserName.cfm">
<CFQUERY name="GetStateList" datasource="#Application.Datasource#" cachedwithin="#CreateTimespan(0,0,0,0)#">
SELECT * FROM StateProvince WHERE strCountryCode = '#session.CountryCode#' ORDER BY intStateID
</CFQUERY>
<cfstoredproc procedure="pGetMemberWebsite" debug="yes" datasource="#application.datasource#">
<cfprocresult name="pGetMemberWebsite_Results">
<cfprocparam variable="intMemberID" cfsqltype="cf_sql_integer" value="#session.memberID#">
</cfstoredproc>
<cfstoredproc procedure="pGetCartItems" debug="yes" datasource="#application.datasource#">
<cfprocresult name="pGetCartItems_Result">
<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intCartID" type="in" value="#session.CartID#">
</cfstoredproc>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="/files/img/favicon.png">
<meta property="og:title" content="Sharing Body Align" />
<meta property="og:type" content="Sharing Widgets" />
<meta property="og:url" content="http://www.bodyalign.com" />
<meta property="og:image" content="http://bodyalign.com/files/img/logo.png" />
<meta property="og:description" content="Follow this link and find out about Body Align." />
<meta property="og:site_name" content="Body Align Website" />
<meta name="description" content="">
<meta name="author" content=" Body Align">
<title>Body Align - Well Balanced</title>
<link href="/global/css/bootstrap-3.3.5.min.css" rel="stylesheet" type="text/css" media="all" />
<link href="/global/js/plugins/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
<link href="/global/font-awesome-4.6.1/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="/files/css/custom.css">

<link rel="stylesheet" type="text/css" href="/files/css/settings.css">
<link rel="stylesheet" type="text/css" href="/files/css/layers.css">
<link rel="stylesheet" type="text/css" href="/files/css/navigation.css">
<!--[if lt IE 9]> 
<![endif]-->
<!--- Code to allow for custom stuff --->
<cfparam name="customhead" default="" >
<cfoutput>#customhead#</cfoutput>
<!--Start Google Analytics-->
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-55560704-15', 'auto');
  ga('send', 'pageview');

</script>
<!--End Google Analytics-->
<!-- Start Visual Website Optimizer Asynchronous Code -->
<script type='text/javascript'>
var _vwo_code=(function(){
var account_id=47475,
settings_tolerance=2000,
library_tolerance=2500,
use_existing_jquery=false,
// DO NOT EDIT BELOW THIS LINE
f=false,d=document;return{use_existing_jquery:function(){return use_existing_jquery;},library_tolerance:function(){return library_tolerance;},finish:function(){if(!f){f=true;var a=d.getElementById('_vis_opt_path_hides');if(a)a.parentNode.removeChild(a);}},finished:function(){return f;},load:function(a){var b=d.createElement('script');b.src=a;b.type='text/javascript';b.innerText;b.onerror=function(){_vwo_code.finish();};d.getElementsByTagName('head')[0].appendChild(b);},init:function(){settings_timer=setTimeout('_vwo_code.finish()',settings_tolerance);var a=d.createElement('style'),b='body{opacity:0 !important;filter:alpha(opacity=0) !important;background:none !important;}',h=d.getElementsByTagName('head')[0];a.setAttribute('id','_vis_opt_path_hides');a.setAttribute('type','text/css');if(a.styleSheet)a.styleSheet.cssText=b;else a.appendChild(d.createTextNode(b));h.appendChild(a);this.load('//dev.visualwebsiteoptimizer.com/j.php?a='+account_id+'&u='+encodeURIComponent(d.URL)+'&r='+Math.random());return settings_timer;}};}());_vwo_settings_timer=_vwo_code.init();
</script>
<!-- End Visual Website Optimizer Asynchronous Code -->

</head>
<body>