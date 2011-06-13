<?php

require('includes/master.inc.php');

// Trip Details
if (isset($_GET['trip_id'])):
	$trip_id = (int) $_GET['trip_id'];
	$trip = $TripIt->GetSingleTrip( array('id' => (int) $trip_id) );
	$Smarty->assign('trip', $trip);
	
	// Air Travel
	$air = $TripIt->GetAirTravel($trip);
	$Smarty->assign('air', $air);
	
	// Transport
	$transport = $TripIt->GetTransport($trip);
	$Smarty->assign('transport', $transport);
		
	// Air Travel
	$lodging = $TripIt->GetLodging($trip);
	$Smarty->assign('lodging', $lodging);
	
	// Activities
	$activity = $TripIt->GetActivities($trip);
	$Smarty->assign('activity', $activity);
	
	// Traveler list
	$traveler = $TripIt->GetTravelers($trip);
	$Smarty->assign('traveler', $traveler);
	
else:
	header('Location: ' . BASE_URL);
endif;

$Smarty->display('trip-detail.tpl');