<?php

// Site configuration
require 'config.php';

// Base classes
require 'class.tripit.php';
require 'class.smarty.php';

// Globals
session_start();

// Smarty
$Smarty = new TripitShareSmarty;
if (isset($_GET['debug'])):
	$Smarty->debugging = true;
endif;

// TripIt
$token = TripItToken::getTripItToken();

// Get Token
if ($token):
	$TripIt = new TripItShare( $token );
	
	// Profile
	$profile = $TripIt->GetProfile();
	$Smarty->assign('profile', $profile->Profile);
	$Smarty->debugging = true;
else:
	// Don't process redirect if already on OAuth page
	if (strpos('oauth.php', $_SERVER['PHP_SELF']))
		header('Location: oauth.php');
	else
		$TripIt = null;
endif;
