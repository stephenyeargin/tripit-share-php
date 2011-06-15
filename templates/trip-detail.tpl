{extends file="layout.tpl"}
{block name=title}Trip Detail{/block}
{block name=body}

{if $Error ne null}
<div id="error">
	<h3>Errors</h3>
	{$Error->ul()}
</div>
{/if}

{if $trip_sent eq true}
<div id="success">
	<h3>Your trip was shared!</h3>
</div>
{/if}

<h2>{$trip->Trip->display_name}</h2>

<div class="itenerary">

	{if $air ne null}<h2 class="travel-icon travel-icon-air"><span>Air Travel</span></h2>{/if}
	{foreach $air as $k => $air_item}
	<div class="itenerary-item">
		{foreach $air_item->Segment as $k => $segment_item}
		<div class="air-travel">
			<h3>{$segment_item->start_city_name} to {$segment_item->end_city_name}</h3>
			<p>
				<strong>Airline:</strong> {$segment_item->marketing_airline}<br />
				<strong>Flight Number:</strong> {$segment_item->marketing_airline_code}  {$segment_item->marketing_flight_number}<br />
				<strong>Take-off:</strong> {$segment_item->StartDateTime->time|date_format:'%l:%M %p'} ({$segment_item->StartDateTime->date|date_format})<br />
				<strong>Landing:</strong> {$segment_item->EndDateTime->time|date_format:'%l:%M %p'} ({$segment_item->duration})<br />
				<strong>Airports:</strong> {$segment_item->start_airport_code} to {$segment_item->end_airport_code} ({$segment_item->distance})
			</p>
		</div>
		{/foreach}
	</div>
	<div class="clear">&nbsp;</div>
	{/foreach}
	
	{if $transport ne null}<h2 class="travel-icon travel-icon-transport"><span>Transportation</span></h2>{/if}
	{foreach $transport as $k => $transport_item}
	<div class="itenerary-item">
		{foreach $transport_item->Segment as $k => $segment_item}
		<div class="air-travel">
			<h3>Traveling {$segment_item->start_location_name} to {$segment_item->end_location_name}</h3>
			<p>
				<strong>Time:</strong> {$segment_item->StartDateTime->time|date_format:'%l:%M %p'}<br />
				<strong>Date:</strong> {$segment_item->StartDateTime->date|date_format}<br />
				<strong>Place:</strong> {$segment_item->StartLocationAddress->address}<br />
				<strong>Carrier:</strong> {$segment_item->carrier_name}
			</p>
		</div>
		{/foreach}
	</div>
	<div class="clear">&nbsp;</div>
	{/foreach}

	{if $car ne null}<h2 class="travel-icon travel-icon-car"><span>Car Rental</span></h2>{/if}
	{foreach $car as $k => $car_item}
	<div class="itenerary-item">
		<div class="car">
			<h3>{$car_item->display_name}</h3>
			<p>
				<strong>Vehicle:</strong> {$car_item->car_type}<br />
				<strong>Pickup:</strong> {$car_item->StartDateTime->time|date_format:'%l:%M %p'} {$car_item->StartDateTime->date|date_format}<br />
				<strong>Location:</strong> {$car_item->StartLocationAddress->address} <br />
				<strong>Drop-Off:</strong> {$car_item->EndDateTime->time|date_format:'%l:%M %p'} {$car_item->EndDateTime->date|date_format}<br />
				<strong>Location:</strong> {$car_item->EndLocationAddress->address}	
			</p>
		</div>
	</div>
	<div class="clear">&nbsp;</div>
	{/foreach}
	
	{if $lodging ne null}<h2 class="travel-icon travel-icon-lodging"><span>Lodging</span></h2>{/if}
	{foreach $lodging as $k => $lodging_item}
	<div class="itenerary-item">
		<div class="lodging">
			<h3>{$lodging_item->display_name}</h3>
			<p>
				<strong>Check-In:</strong> {$lodging_item->StartDateTime->time|date_format:'%l:%M %p'} {$lodging_item->StartDateTime->date|date_format} <br />
				<strong>Check-Out:</strong> {$lodging_item->EndDateTime->time|date_format:'%l:%M %p'} {$lodging_item->EndDateTime->date|date_format} <br />
				<strong>Address:</strong> {$lodging_item->Address->address}
			</p>
		</div>
	</div>
	<div class="clear">&nbsp;</div>
	{/foreach}
	
	{if $activity ne null}<h2 class="travel-icon travel-icon-activity"><span>Activities</span></h2>{/if}
	{foreach $activity as $k => $activity_item}
	<div class="itenerary-item">
		<div class="activity">
			<h3>{$activity_item->display_name}</h3>
			<p>
				<strong>Starts:</strong> {$activity_item->StartDateTime->time|date_format:'%l:%M %p'} {$activity_item->StartDateTime->date|date_format} <br />
				<strong>Ends:</strong> {$activity_item->end_time|date_format:'%l:%M %p'} <br />
				<strong>Address:</strong> {$activity_item->Address->address}
			</p>
		</div>
	</div>
	<div class="clear">&nbsp;</div>
	{/foreach}
	
</div>
{/block}

{block name=sidebar}
<div class="traveler-list">
	<h3>Travelers</h3>
	{foreach $traveler as $traveler_item}
	<div class="traveler">
		{if isset($traveler_item->photo_url)}
		<div class="traveler-photo"><img src="{$traveler_item->photo_url}" alt="Profile Image" /></div>
		{else}
		<div class="traveler-photo"><img src="{$base_url}/assets/images/default-photo.jpg" alt="Profile Image" /></div>
		{/if}
		<div class="traveler-info">
			<strong>Name:</strong> {$traveler_item->public_display_name}<br />
			<strong>Screen Name:</strong> <a href="http://tripit.com/{$traveler_item->profile_url}">{$traveler_item->screen_name}</a><br />
		</div>
	</div>
	<div class="clear">&nbsp;</div>
	{/foreach}
</div>
<div class="share-form">
	<h3>Share Your Trip</h3>
	<form method="post" id="share-form">
		<p>
			<label>Recipient's Name</label>
			<input type="text" name="recipient_name" id="recipient_name" value="{$recipient_name|escape}" class="required" />
		</p>
		<p>
			<label>Recipient's E-mail</label>
			<input type="text" name="recipient_email" id="recipient_email" value="{$recipient_email|escape}" class="required email" />
		</p>
		<p>
			<label>Your Name</label>
			<input type="text" name="sender_name" id="sender_name" value="{$sender_name|escape}" class="required" />
		</p>
		<p>
			<label>Your E-mail</label>
			<input type="text" name="sender_email" id="sender_email" value="{$sender_email|escape}" class="required email" />
		</p>
		<p>
			<label>Message (optional)</label>
			<textarea name="message" id="message">{$message|escape}</textarea>
		</p>
			{if $air ne null}<label><input type="checkbox" name="to_send[air]" value="1" checked="checked" /> Air Travel</label>{/if}
			{if $transport ne null}<label><input type="checkbox" name="to_send[transport]" value="1" checked="checked" /> Tranportation</label>{/if}
			{if $lodging ne null}<label><input type="checkbox" name="to_send[lodging]" value="1" checked="checked" /> Lodging</label>{/if}
			{if $activity ne null}<label><input type="checkbox" name="to_send[activity]" value="1" checked="checked" /> Activities</label>{/if}
			{if $car ne null}<label><input type="checkbox" name="to_send[car]" value="1" checked="checked" /> Car Rental</label>{/if}
		<p>
			<input type="hidden" name="trip_id" value="{$smarty.get.trip_id}" />
			<input type="submit" value="Send!" />
		</p>
	</form>
</div>
{/block}