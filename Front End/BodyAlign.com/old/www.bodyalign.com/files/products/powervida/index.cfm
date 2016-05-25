<CFPARAM name="session.CustID" default="0">
<CFSAVECONTENT variable="customfoot">
<!--- custom stuff here. --->
<script type="text/javascript" src="/files/js/jquery.parallax-1.1.3.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	//.parallax(xPosition, speedFactor, outerHeight) options:
	//xPosition - Horizontal position of the element
	//inertia - speed to move relative to vertical scroll. Example: 0.1 is one tenth the speed of scrolling, 2 is twice the speed of scrolling
	//outerHeight (true/false) - Whether or not jQuery should use it's outerHeight option to determine when a section is in the viewport
	$('#section1').parallax("10%", 0.3);
	$('.products-bg1').parallax("65%", 0.1);
	$('#section2').parallax("50%", 0.3);
	$('.products-bg2').parallax("20%", 0.1);
	$('#section3').parallax("50%", 0.3);
	$('.products-bg3').parallax("10%", 1.3);

})
</script>
</CFSAVECONTENT>

<CFINCLUDE template="/public/header.cfm">  
<CFINCLUDE template="/public/main-nav.cfm">
<cfstoredproc procedure="pGetProductList_Public" debug="yes" datasource="#application.datasource#">		
	<cfprocresult name="pGetProductList_Result">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intBrandID" type="in" Value="#application.BrandID#">
	<cfprocparam cfsqltype="CF_SQL_INTEGER" variable="intLangID" type="in" value="#session.lang#">
</cfstoredproc>
<!-- Latest compiled and minified CSS -->
<link href='https://fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
<link href="/files/css/style.css" rel="stylesheet" type="text/css" />
<cfset tVar = ''>
<cfset tCount = 1>
<cfoutput query="pGetProductList_Result" group="CategoryTitle" >
<div id="section#tCount#" class="pos-relative">

	<div id="anchor#tCount#" class="scrollAnchor"></div>

	<div class="story">
		<div class="products-bg#tCount#"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-12"><h1>#CategoryTitle#</h1></div>
			</div>
			<div class="row">
				<cfoutput>
				<div class="col-md-4"><img class="img-responsive grow" src="/common/product/#session.langcode#/#STRPRODUCTIMG1#" alt="#strProduct#" /><a class="btn btn-lg btn-color" href="#STRURLFRIENDLY#.pv">#strProduct#</a></div>
				</cfoutput>
			</div>
		</div> 
	</div><!--.story-->
</div> <!--##first-->
<cfif tVar NEQ CategoryTitle>
	<cfset tVar = CategoryTitle>
	<cfset tCount = incrementValue(tCount)>
</cfif>
</cfoutput>
<CFINCLUDE template="/public/footer.cfm">