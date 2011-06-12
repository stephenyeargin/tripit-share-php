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
	//if ($_SERVER['SCRIPT_NAME'] != 'oauth.php')
	//	header('Location: oauth.php');
//	else
		$TripIt = null;
endif;
