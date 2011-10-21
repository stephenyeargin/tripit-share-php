<?php

require('includes/master.inc.php');

// If $TripIt not set, redirect
if (!$TripIt)
	header('Location: oauth.php');

// Past Trips
$past_trips = $TripIt->GetTrips( array('past' => 'true') );
if (isset($past_trips->Trip->display_name)) // if single trip
	$Smarty->assign('past_trips', array($past_trips->Trip));
else
	$Smarty->assign('past_trips', $past_trips->Trip );

// Future Trips
$future_trips = $TripIt->GetTrips( array('past' => 'false') );
if (isset($future_trips->Trip->display_name)) // if single trip
	$Smarty->assign('future_trips', array($future_trips->Trip));
else
	$Smarty->assign('future_trips', $future_trips->Trip );

$Smarty->display('main.tpl');