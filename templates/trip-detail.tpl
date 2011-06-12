{extends file="layout.tpl"}
{block name=title}Trip Detail{/block}
{block name=body}

<h2>{$trip->Trip->display_name}</h2>

<div class="itenerary">
	<h2>Itenerary</h2>
	{foreach $air->Segment as $k => $air_item}
	<div class="itenerary-item">
		<div class="air-travel">
			<h3>Flying {$air_item->start_city_name} to {$air_item->end_city_name}</h3>
			<p>
				<strong>Time:</strong> {$air_item->StartDateTime->time}<br />
				<strong>Date:</strong> {$air_item->StartDateTime->date|date_format}<br />
				<strong>Place:</strong> {$air_item->start_airport_code}<br />
				<strong>Airline:</strong> {$air_item->marketing_airline}<br />
				<strong>Flight Number:</strong> {$air_item->marketing_flight_number}
			</p>
		</div>
	</div>
	{/foreach}
	<div class="clear">&nbsp;</div>
	{foreach $lodging as $k => $lodging_item}
	<div class="itenerary-item">
		<div class="lodging">
			<h3>{$lodging_item->display_name}</h3>
			<p>
				<strong>Time:</strong> {$lodging_item->StartDateTime->time}<br />
				<strong>Date:</strong> {$lodging_item->StartDateTime->date|date_format}<br />
				<strong>Place:</strong> {$lodging_item->display_name}<br />
				<strong>Address:</strong> {$lodging_item->Address->address}
			</p>
		</div>
	</div>
	{/foreach}
	<div class="clear">&nbsp;</div>
	{foreach $activity as $k => $activity_item}
	<div class="itenerary-item">
		<div class="activity">
			<h3>{$activity_item->display_name}</h3>
			<strong>Time:</strong> {$activity_item->StartDateTime->time}<br />
			<strong>Date:</strong> {$activity_item->StartDateTime->date|date_format}<br />
			<strong>Place:</strong> {$activity_item->location_name}<br />
		</div>
	</div>
	{/foreach}
</div>

<div class="travelers">
	<h2>Travelers</h2>
	{foreach $traveler as $traveler_item}
	<div class="traveler">
		{if isset($traveler_item->photo_url)}
		<div class="traveler-photo"><img src="{$traveler_item->photo_url}" alt="Profile Image" /></div>
		{/if}
		<div class="traveler-info">
			<span class="traveler-name">{$traveler_item->public_display_name}</span><br />
		</div>
	</div>
	{/foreach}
</div>

{/block}