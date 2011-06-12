<?php
require('includes/master.inc.php');

if (isset($_GET['logout'])):
	TripItToken::deleteTripItToken();
endif;

$token = TripItToken::getTripItToken();

if ($token):
	$TripIt = new TripItShare( $token );
else:
	$TripIt = null;
endif;

// Render authentication page
if (!is_object($TripIt) && !isset($_GET['oauth_token'])):
	$TripItAuth = new OAuthConsumerCredential(TRIPIT_API_KEY, TRIPIT_API_SECRET);
	$TripIt = new TripItShare($TripItAuth);
	$request_token = $TripIt->get_request_token();
	$Smarty->assign('token', $request_token['oauth_token']);
	$Smarty->assign('callback', urlencode(BASE_URL . '/oauth.php?request_token_secret=' . $request_token['oauth_token_secret']));
	$Smarty->display('authenticate.tpl');
	exit;
endif;

// Token is being provided, save it to the database and reload the page
if (isset($_GET['oauth_token'])):
	// Process Request Token to Access Token
	$TripItAuth = new OAuthConsumerCredential(TRIPIT_API_KEY, TRIPIT_API_SECRET, $_GET['oauth_token'], $_GET['request_token_secret']);
	$TripIt = new TripItShare($TripItAuth);
	$token = $TripIt->get_access_token();
	$TripItAuth = new OAuthConsumerCredential(TRIPIT_API_KEY, TRIPIT_API_SECRET, $token['oauth_token'], $token['oauth_token_secret']);
	$TripIt = new TripItShare($TripItAuth);
	TripItToken::setTripItToken($TripItAuth);
	header('Location: ' . BASE_URL);
	exit;
endif;