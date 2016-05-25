<!DOCTYPE html>

<html lang="en-US">
<head>
	<title>USPS Canned Tests</title>
	<meta charset="utf-8" />
</head>

<body>

<cfscript>
variables.uspsUserID = '305BRIAR1286';
variables.usps = New usps(isProduction=false, isSecure=false, uspsUserID=variables.uspsUserID);


// USPS Canned Test: This test cleanses an address and provides the ZIP+4 value.
variables.Verify1 = variables.usps.AddressValidate(
	Address2 = '6406 Ivy Lane',
	City = 'Greenbelt',
	State = 'MD');
WriteDump(var="#variables.Verify1#");


variables.RateV4 = variables.usps.RateV4(
	Service = 'FIRST CLASS',
	FirstClassMailType = 'LETTER',
	ZipOrigination = '44106',
	ZipDestination = '20770',
	Pounds = '0',
	Ounces = '3.5',
	Size = 'Regular'
);
WriteDump(var="#variables.RateV4#");
</cfscript>

</body>
</html>