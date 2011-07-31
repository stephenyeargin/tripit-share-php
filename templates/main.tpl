{extends file="layout.tpl"}
{block name=title}Main{/block}
{block name=sidebar}
<h3>Profile</h3>
{if isset($profile->photo_url)}
<div class="profile-photo"><img src="{$profile->photo_url}" alt="Photo" /></div>
{else}
<div class="profile-photo"><img src="{$base_url}/assets/images/default-photo.jpg" alt="Photo" /></div>
{/if}
<p>
	<strong>{$profile->public_display_name}</strong><br />
	{$profile->home_city}<br />
	{$profile->company}
</p>
<p>
	<strong>TripIt Profile:</strong> <a href="http://tripit.com/{$profile->profile_url}">{$profile->screen_name}</a><br />
</p>
{/block}
{block name=body}

<h2>Future Trips</h2>
<table>
	<thead>
		<tr>
			<th>Trip</th>
			<th>City</th>
			<th>Start Date</th>
			<th>End Date</th>
		</tr>
	</thead>
	<tbody>
	{foreach $future_trips as $trip}
		<tr class="{cycle values='odd,even'}{if $trip->is_private eq 'true'} private{/if}">
			<td class="display-name"><a href="trip.php?trip_id={$trip->id}&amp;user={$profile->screen_name}">{$trip->display_name}</a></td>
			<td class="primary-location">{$trip->primary_location}</td>
			<td class="start-date">{$trip->start_date|date_format}</td>
			<td class="end-date">{$trip->end_date|date_format}</td>
		</tr>
	{/foreach}
	{if $future_trips|count eq 0}
		<tr>
			<td colspan="5">No trips planned.</td>
		</tr>
	{/if}
	</tbody>
</table>


<h2>Past Trips</h2>
<table>
	<thead>
		<tr>
			<th>Trip</th>
			<th>City</th>
			<th>Start Date</th>
			<th>End Date</th>
		</tr>
	</thead>
	<tbody>
	{foreach $past_trips as $trip}
		<tr class="{cycle values='odd,even'}{if $trip->is_private eq 'true'} private{/if}">
			<td class="display-name"><a href="trip.php?trip_id={$trip->id}&amp;user={$profile->screen_name}">{$trip->display_name}</a></td>
			<td class="primary-location">{$trip->primary_location}</td>
			<td class="start-date">{$trip->start_date|date_format}</td>
			<td class="end-date">{$trip->end_date|date_format}</td>
		</tr>
	{/foreach}
	{if $past_trips|count eq 0}
		<tr>
			<td colspan="5">No past trips found.</td>
		</tr>
	{/if}
	</tbody>
</table>

{/block}