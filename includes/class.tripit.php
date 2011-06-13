<?php

require DOC_ROOT . '/vendor/tripit_php_v1/tripit.php';

class TripItShare extends Tripit {
	public function __construct($credential, $api_url='https://api.tripit.com') {
		parent::Tripit($credential, $api_url);
	}

	/* Data Retrieval */

	public function GetTrips( $filters ) {
		$filters['format'] = 'json';
		$response = $this->_do_request('list', 'trip', $filters );
		return json_decode($response);
	}
	
	public function GetSingleTrip( $filters ) {
		$filters['format'] = 'json';
		$filters['include_objects'] = 'true';
		$response = $this->_do_request('get', 'trip', $filters );
		return json_decode($response);
	}
	
	public function GetProfile() {
		$filters['format'] = 'json';
		$response = $this->_do_request('get', 'profile', $filters);
		return json_decode($response);
	}

	/* Data Processing */
	public function GetTravelers($object) {
		
		if (is_array($object->Trip->TripInvitees->Invitee)):
			// Build an array of actual travelers
			foreach ($object->Trip->TripInvitees->Invitee as $invited):
				if ($invited->is_traveler == 'true'):
					$traveler_list[] = $invited->{'@attributes'}->profile_ref;
				endif;
			endforeach;
		else:
			// Single traveler
			$profile = array($object->Profile);
			return $profile;
		endif;
		
		// Add only valid profiles to array
		foreach ($object->Profile as $profile):
			if (in_array($profile->{'@attributes'}->ref, $traveler_list)):
				$profiles[] = $profile;
			endif;
		endforeach;
		
		return($profiles);
		
	}
	
	public function GetAirTravel($object) {
		if (!isset($object->AirObject))
			return array();
		if (!is_array($object->AirObject))
			return array($object->AirObject);
		else
			return $object->AirObject;
	}
	
	public function GetTransport($object) {
		if (!isset($object->TransportObject))
			return array();
		if (!is_array($object->TransportObject))
			return array($object->TransportObject);
		else
			return $object->TransportObject;
	}
	
	public function GetActivities($object) {
		if (!isset($object->ActivityObject))
			return array();
		if (!is_array($object->ActivityObject))
			return array($object->ActivityObject);
		else
			return $object->ActivityObject;
	}
	
	public function GetLodging($object) {
		if (!isset($object->LodgingObject))
			return array();
		if (!is_array($object->LodgingObject))
			return array($object->LodgingObject);
		else
			return $object->LodgingObject;
	}
	
}

/**
* TripIt Token
*/
class TripItToken {
	
	function __construct() {
	}

	/**
	 * Get TripIt Token from session
	 */
	static function getTripItToken() {
		if (isset($_SESSION['tripit']['token']))
			return $_SESSION['tripit']['token'];
		else
			return false;
	}

	/**
	 * Set TripIt Token to session
	 */
	static function setTripItToken($token) {
		$_SESSION['tripit'] = array();
		$_SESSION['tripit']['token'] = $token;
	}

	/**
	 * Delete TripIt Token from session
	 */
	static function deleteTripItToken() {
		unset($_SESSION['tripit']);
		return true;
	}

}

