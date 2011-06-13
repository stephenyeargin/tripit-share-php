{extends file="layout.tpl"}
{block name=title}Trip Detail{/block}
{block name=body}

<h2>{$trip->Trip->display_name}</h2>

<div class="itenerary">

	{if $air ne null}<h2 class="travel-icon travel-icon-air"><span>Air Travel</span></h2>{/if}
	{foreach $air as $k => $air_item}
	<div class="itenerary-item">
		{foreach $air_item->Segment as $k => $segment_item}
		<div class="air-travel">
			<h3>{$segment_item->start_city_name} to {$segment_item->end_city_name}</h3>
			<p>
				<strong>Take-off:</strong> {$segment_item->StartDateTime->time|date_format:'%l:%M %p'} ({$segment_item->StartDateTime->date|date_format})<br />
				<strong>Landing:</strong> {$segment_item->EndDateTime->time|date_format:'%l:%M %p'}<br />
				<strong>Place:</strong> {$segment_item->start_airport_code}<br />
				<strong>Airline:</strong> {$segment_item->marketing_airline}<br />
				<strong>Flight Number:</strong> {$segment_item->marketing_airline_code}  {$segment_item->marketing_flight_number}
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
	
	{if $lodging ne null}<h2 class="travel-icon travel-icon-lodging"><span>Lodging</span></h2>{/if}
	{foreach $lodging as $k => $lodging_item}
	<div class="itenerary-item">
		<div class="lodging">
			<h3>{$lodging_item->display_name}</h3>
			<p>
				<strong>Time:</strong> {$lodging_item->StartDateTime->time|date_format:'%l:%M %p'}<br />
				<strong>Date:</strong> {$lodging_item->StartDateTime->date|date_format}<br />
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
				<strong>Time:</strong> {$activity_item->StartDateTime->time|date_format:'%l:%M %p'}<br />
				<strong>Date:</strong> {$activity_item->StartDateTime->date|date_format}<br />
				<strong>Address:</strong> {$activity_item->Address->address}}
			</p>
		</div>
	</div>
	<div class="clear">&nbsp;</div>
	{/foreach}
	
</div>
{/block}

{block name=sidebar}
<div class="travelers">
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
{/block}