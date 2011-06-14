<html>
<head>
<style>
body { font-family: sans-serif; }
</style>
</head>
<body>
{$sender_name} has sent you the following trip itinerary.

<hr />

{if $message ne ''}
{$message|nl2br}

<hr />
{/if}

<h1>{$trip->Trip->display_name}</h1>

{if isset($to_send.air)}
<h2>Air Travel</h2>

{foreach $air as $k => $air_item}
{foreach $air_item->Segment as $k => $segment_item}
<h3>{$segment_item->start_city_name} to {$segment_item->end_city_name}</h3>
<p>
    <strong>Take-off:</strong> {$segment_item->StartDateTime->time|date_format:'%l:%M %p'} ({$segment_item->StartDateTime->date|date_format}) <br />
    <strong>Landing:</strong> {$segment_item->EndDateTime->time|date_format:'%l:%M %p'} <br />
    <strong>Place:</strong> {$segment_item->start_airport_code} <br />
    <strong>Airline:</strong> {$segment_item->marketing_airline} <br />
    <strong>Flight Number:</strong> {$segment_item->marketing_airline_code}  {$segment_item->marketing_flight_number} <br />
</p>
{/foreach}
{/foreach}
{/if}


{if isset($to_send.transport)}
<h2>Transportation</h2>

{foreach $transport as $k => $transport_item}
{foreach $transport_item->Segment as $k => $segment_item}
<h3>{$segment_item->start_location_name} to {$segment_item->end_location_name}</h3>
<p>
    <strong>Time:</strong> {$segment_item->StartDateTime->time|date_format:'%l:%M %p'} <br />
    <strong>Date:</strong> {$segment_item->StartDateTime->date|date_format} <br />
    <strong>Place:</strong> {$segment_item->StartLocationAddress->address} <br />
    <strong>Carrier:</strong> {$segment_item->carrier_name} <br />
</p>
{/foreach}
{/foreach}
{/if}


{if $to_send.lodging eq 1}
<h2>Lodging</h2>

{foreach $lodging as $k => $lodging_item}
<h3>{$lodging_item->display_name}</h3>
<p>
    <strong>Time:</strong> {$lodging_item->StartDateTime->time|date_format:'%l:%M %p'} <br />
    <strong>Date:</strong> {$lodging_item->StartDateTime->date|date_format} <br />
    <strong>Address:</strong> {$lodging_item->Address->address} <br />
</p>
{/foreach}
{/if}

{if isset($to_send.activity)}
<h2>Activities</h2>

{foreach $activity as $k => $activity_item}
<h3>{$activity_item->display_name}</h3>
<p>
    <strong>Time:</strong> {$activity_item->StartDateTime->time|date_format:'%l:%M %p'} <br />
    <strong>Date:</strong> {$activity_item->StartDateTime->date|date_format} <br />
    <strong>Address:</strong> {$activity_item->Address->address} </br>
<p>
{/foreach}
{/if}
</body>
</html>