<?php

// Site configuration
require 'config.php';

// Base classes
require 'class.tripit.php';
require 'class.smarty.php';
require 'class.swift.php';

// Globals
session_start();

// Smarty
$Smarty = new TripitShareSmarty;
$Smarty->assign('base_url', BASE_URL);
if (defined('DEBUG')):
	$Smarty->debugging = DEBUG;
endif;

// TripIt
$token = TripItToken::getTripItToken();

// Get Token
if ($token):
	$TripIt = new TripItShare( $token );
	
	// Profile
	$profile = $TripIt->GetProfile();
	$Smarty->assign('profile', $profile->Profile);
	
else:
	// Don't process redirect if already on OAuth page
	if (strpos('oauth.php', $_SERVER['PHP_SELF']))
		header('Location: oauth.php');
	else
		$TripIt = null;
endif;
