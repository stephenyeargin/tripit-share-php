<?php

require('includes/master.inc.php');

// Past Trips
$trips = $TripIt->GetTrips( array('past' => 'true') );
$Smarty->assign('past_trips', $trips->Trip );
if (isset($trips->Trip->display_name)) // if single trip
	$Smarty->assign('past_trips', array($trips->Trip));

// Future Trips
$trips = $TripIt->GetTrips( array('past' => 'false') );
$Smarty->assign('future_trips', $trips->Trip );
if (isset($trips->Trip->display_name)) // if single trip
	$Smarty->assign('future_trips', array($trips->Trip));
	
$Smarty->display('main.tpl');