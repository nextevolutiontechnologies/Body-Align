<CFINCLUDE template="/public/global_header.cfm">
<CFINCLUDE template="/public/header.cfm">
<section class="content-1-5 content-block">
<div class="container">
	<div class="row">
		<div class="col-md-6">
		<h1 class="page-header"> Contact Us
		</h1>
		</div>
		<div class="col-md-6 text-right">
<cfoutput>
<ol class="breadcrumb breadcrumb-2">
<li>
<a href="/#url.u#/">Home</a>
</li>
<li class="active">Contact Us </li>
</ol>
</cfoutput>
</div>
	</div>

	<div class="row">
		<div class="col-sm-6 col-md-5">
			<h5 class="uppercase mb0">Fill Out the Form Below to Contact Us.</h5>
			<br />
			<cfif isdefined("url.e") and url.e eq 1>
			<h5 class="alert alert-success">your request has been sent successfully.</h5>
			</cfif>
			<cfset csrfToken=CSRFGenerateToken() />
			<form class="form-email" method="post" id="contactForm" enctype="multipart/form-data" action="/<cfoutput>#url.u#</cfoutput>/contact/process/?" data-success="Thanks for your submission, we will be in touch shortly." data-error="Please fill all fields correctly.">
			<div class="form-group">
			<input type="text"  name="strFirstName" placeholder="Your First Name" />
			</div>
			<div class="form-group">
			<input type="text"  name="strLastName" placeholder="Your Last Name" />
			</div>
			<div class="form-group">
			<input type="text" class="validate-required validate-email" name="strEmail" placeholder="Email Address" />
			</div>
			<input name="csrfToken" value="<cfoutput>#csrfToken#</cfoutput>" type="hidden" >
			<div class="form-group">
			<textarea class="validate-required" name="strMessage" rows="4" placeholder="Message"></textarea>
			</div>
			<button type="submit">Send Message</button>

			</form>
		</div>
		<div class="col-sm-6 col-md-5 col-md-offset-2">
		<h4 class="uppercase">Get In Touch</h4>
		<p>
		Please feel free to contact us with any questions or concerns.
		</p>
		<hr>
		<p>
		Body Aligner: <cfif isdefined("pGetMemberWebsite_results.strfullname")><cfoutput>#pGetMemberWebsite_results.strfullname#</cfoutput></cfif>
		<br />
		Phone: <cfif isdefined("pGetMemberWebsite_results.strphone")><cfoutput>#pGetMemberWebsite_results.strphone#</cfoutput></cfif>
		<br />
		</p>
		<hr>
		<p>
		Body Align, LLC.
		<br />
		2020 General Booth Blvd. Suite 240
		<br />
		Virginia Beach, VA 23454
		<br />
		Email: support@BodyAlign.com
		<br />
		Phone: 800-655-9855
		<br />
		</p>
		<hr>
		</div>
	</div>
</div>
<br /><br /><br />
<div class="well well-sm">
<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3196.0200535684457!2d-76.01381718441608!3d36.770086377093286!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89bac19ec779add5%3A0x9fa103b6d19b9886!2s2020+General+Booth+Blvd+%23240%2C+Virginia+Beach%2C+VA+23454!5e0!3m2!1sen!2sus!4v1458950005390" width="100%" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
</div>
 </section>
<CFINCLUDE template="/public/footer.cfm">
<CFINCLUDE template="/public/global_footer.cfm">

