<?php

require('includes/master.inc.php');

// If $TripIt not set, redirect
if (!$TripIt)
	header('Location: oauth.php');

// Total Distance Traveled
$total_distance = 0;

// Past Trips
$past_trips = $TripIt->GetTrips( array('past' => 'true') );
if (isset($past_trips->Trip->display_name)) // if single trip
	$Smarty->assign('past_trips', array($past_trips->Trip));
else
	$Smarty->assign('past_trips', $past_trips->Trip );

/*
	Calculating a Simple Distance between 'home' and
	the primary location of the trip. Proof of concept.
*/
$track_miles = true;
$home_city = $Profile->Profile->home_city;
if (!$home_city)
	$track_miles = false; // Can't calculate without city/state

if ($track_miles):
	$home_city_geo = GeoCalculator::geocodeAddress($home_city);
	foreach ($past_trips->Trip as $key => $trip):
		$lat1 = $trip->PrimaryLocationAddress->latitude;
		$lon1 = $trip->PrimaryLocationAddress->longitude;
		$distance = GeoCalculator::getGeoDistance($lat1, $lon1, $home_city_geo[0], $home_city_geo[1]);
		$past_trips->Trip[$key]->distance_traveled = $distance;
		$total_distance += ($distance * 2);
	endforeach;
	$Smarty->assign('miles_traveled', $total_distance);
else:
	$Smarty->assign('miles_traveled', 0);
endif;
$Smarty->assign('track_miles', (bool) $track_miles);

// Future Trips
$future_trips = $TripIt->GetTrips( array('past' => 'false') );
if (isset($future_trips->Trip->display_name)) // if single trip
	$Smarty->assign('future_trips', array($future_trips->Trip));
else
	$Smarty->assign('future_trips', $future_trips->Trip );

$Smarty->display('main.tpl');