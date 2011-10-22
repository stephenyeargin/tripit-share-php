<?php

// Site configuration
require 'config.php';

// Base classes
require 'class.error.php';
require 'class.tripit.php';
require 'class.smarty.php';
require 'class.swift.php';
require 'class.geocalculator.php';

// Globals
session_start();

// Smarty
$Smarty = new TripitShareSmarty;
$Smarty->assign('base_url', BASE_URL);
if (defined('DEBUG')):
	$Smarty->debugging = DEBUG;
endif;
if (defined('ANALYTICS_CODE')):
	$Smarty->assign('analytics_code', ANALYTICS_CODE);
else:
	$Smarty->assign('analytics_code', '');
endif;

// TripIt
$token = TripItToken::getTripItToken();

// Error
$Error = Error::getError();

// Get Token
if ($token):
	$TripIt = new TripItShare( $token );
	
	// Profile
	$Profile = $TripIt->GetProfile();
	$Smarty->assign('profile', $Profile->Profile);
	
else:
	// Don't process redirect if already on OAuth page
	if (strpos('oauth.php', $_SERVER['PHP_SELF']))
		header('Location: oauth.php');
	else
		$TripIt = null;
endif;
