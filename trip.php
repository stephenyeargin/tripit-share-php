<?php

require('includes/master.inc.php');

// Trip Details
if (isset($_REQUEST['trip_id'])):
	$trip_id = (int) $_REQUEST['trip_id'];
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

// Trip Send
if (isset($_POST['trip_id']) && $_POST['trip_id'] > 0):
	
	if (!isset($_POST['to_send']))
		$_POST['to_send'] = array();
	
	// Load posted variables
	$recipient_name = $_POST['recipient_name'];
		$Error->blank($recipient_name, 'Recipient Name');
		$Smarty->assign('recipient_name', $recipient_name);
	$recipient_email = $_POST['recipient_email'];
		$Error->email($recipient_email, 'Recipient E-mail');
		$Smarty->assign('recipient_email', $recipient_email);
	$sender_name = $_POST['sender_name'];
		$Error->blank($sender_name, 'Sender Name');
		$Smarty->assign('sender_name', $sender_name);
	$sender_email = $_POST['sender_email'];
		$Error->email($sender_email, 'Sender E-mail');
		$Smarty->assign('sender_email', $sender_email);
	$message = $_POST['message'];
		$Smarty->assign('message', $message);
	$to_send = $_POST['to_send'];
		if (count($to_send) == 0)
			$Error->add('NO_SEND', 'You must select at least one type to send.');
		$Smarty->assign('to_send', $to_send);
	
	if ($Error->ok()):
	
		$transport = Swift_MailTransport::newInstance();
		//$transport = Swift_SendmailTransport::newInstance('/usr/sbin/sendmail -bs');
		$mailer = Swift_Mailer::newInstance($transport);
	
		$message = Swift_Message::newInstance($trip->Trip->display_name)
		  ->setTo(array($recipient_email => $recipient_name))
		  ->setFrom(array($sender_email => $sender_name))
		  ->setBody($Smarty->fetch('trip-detail-email-text.tpl'), 'text/plain')
		  ->addPart($Smarty->fetch('trip-detail-email-html.tpl'), 'text/html')
		  ;
	
		// Send the message
		$result = $mailer->send($message);
	
		if ($result):
			$Smarty->assign('trip_sent', true);
		else:
			$Smarty->assign('trip_sent', false);
			$Error->add('EMAIL_FAIL', 'The message failed to send');
		endif;

	endif;

else:
	// Set these to defaults if not a post
	$Smarty->assign('recipient_name', '');
	$Smarty->assign('recipient_email', '');
	$Smarty->assign('sender_name', '');
	$Smarty->assign('sender_email', '');
	$Smarty->assign('message', '');
	$Smarty->assign('trip_sent', false);
endif;

if (!$Error->ok())
	$Smarty->assign('Error', $Error);
else
	$Smarty->assign('Error', null);

$Smarty->display('trip-detail.tpl');