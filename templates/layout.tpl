<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>{block name=title}{/block} | TripIt® Share</title>
	<link rel="shortcut icon" href="{$base_url}/assets/images/favicon.ico" type="application/x-icon" />
	<link rel="stylesheet" href="{$base_url}/assets/css/reset.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="{$base_url}/assets/css/grid.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="{$base_url}/assets/css/tripit-share.css" type="text/css" media="screen" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.js"> </script>
	<script type="text/javascript" src="http://html5shiv.googlecode.com/svn/trunk/html5.js"> </script>
	<script type="text/javascript" src="{$base_url}/assets/js/tripit-share.js"> </script>
	{block name=head}{/block}
</head>
<body>

<div id="page" class="container_24">

	<div id="header" class="alpha grid_24 omega">
		<h1>TripIt® Share</h1>
		<ul>
			<li><a href="{$base_url}">Home</a></li>
			<li><a href="{$base_url}/oauth.php?logout">Logout</a></li>
		</ul>
	</div>

	<hr />

	<div id="body" class="alpha grid_18">
	{block name=body}{/block}
	</div>

	<div id="sidebar" class="grid_6 omega">
	{block name=sidebar}{/block}
	</div>

	<hr />

	<div id="footer" class="alpha grid_24 omega">
		<p>Disclaimer: This product is not affiliated with TripIt® and is provided without warranty.</p>
	{block name=foot}{/block}
	</div>

	<div class="clear">&nbsp;</div>

</div>

</body>
</html>
