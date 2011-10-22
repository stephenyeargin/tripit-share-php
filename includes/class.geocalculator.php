<?php
/**
 * GeoCalculator
 */
class GeoCalculator {

	static $earth_radius = 3960.00; // Measured in miles
	static $GoogleMapsAPIKey = ''; // If you need to register your requests

	/**
	 * Get Geo Distance
	 *
	 * @param string $lat1 
	 * @param string $lon1 
	 * @param string $lat2 
	 * @param string $lon2 
	 * @return int
	 */
	public function getGeoDistance($lat1=0, $lon1=0, $lat2=0, $lon2=0) {
		
		// If either set is not set, distance is automatically zero.
		if ( (!$lat1 && !$lon1) || (!$lat2 && !$lon2) )
			return 0;
		
		return self::_distance_haversine($lat1, $lon1, $lat2, $lon2);
	}

	/**
	 * Geocode an Address
	 *
	 * @param string $address
	 */
	public function geocodeAddress($address) {
		
		if (!$address)
			return false;

		$api_key = self::$GoogleMapsAPIKey;
		$address = urlencode($address);
		$url = sprintf("http://maps.google.com/maps/geo?q=%s&key=%s&output=json", $address, $api_key);

		/* cURL request */
		$ch = curl_init($url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$data = curl_exec($ch);

		if (!$data)
			return false;
		
		// Decode the JSON response
		$json = json_decode($data);

		if(!isset($json->Status->code) || $json->Status->code != "200")
			return false;

		// Parse coordinates into latitude and logitude
		return ($json->Placemark[0]->Point->coordinates);

	}

	/* Private Methods */

	/**
	 * Constructor
	 */
	private function __construct() {
		// Not an instatiated object.
	}

	/**
	 * Haversine Distance Calculation
	 *
	 * @param string $lat1 
	 * @param string $lon1 
	 * @param string $lat2 
	 * @param string $lon2 
	 * @return int
	 */
	private function _distance_haversine($lat1, $lon1, $lat2, $lon2) {

		// Calculate Deltas
		$delta_lat = $lat2 - $lat1 ;
		$delta_lon = $lon2 - $lon1 ;

		$alpha		= $delta_lat/2;
		$beta			= $delta_lon/2;
		$a				= sin(deg2rad($alpha)) * sin(deg2rad($alpha)) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin(deg2rad($beta)) * sin(deg2rad($beta)) ;
		$c				= asin(min(1, sqrt($a)));
		$distance = 2*self::$earth_radius * $c;
		$distance = round($distance, 4);

		return (float) $distance;
	}

}