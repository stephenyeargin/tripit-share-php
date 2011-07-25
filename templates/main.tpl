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
	<strong>Name:</strong> {$profile->public_display_name}<br />
	<strong>Screen Name:</strong> <a href="http://tripit.com/{$profile->profile_url}">{$profile->screen_name}</a><br />
	<strong>Home City:</strong> {$profile->home_city}<br />
	<strong>Company:</strong> {$profile->company}
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
			<th>Private</th>
		</tr>
	</thead>
	<tbody>
	{foreach $future_trips as $trip}
		<tr class="{cycle values='odd,even'}">
			<td><a href="trip.php?trip_id={$trip->id}&amp;user={$profile->screen_name}">{$trip->display_name}</a></td>
			<td>{$trip->primary_location}</td>
			<td>{$trip->start_date|date_format}</td>
			<td>{$trip->end_date|date_format}</td>
			<td>{if $trip->is_private eq 'false'}No{else}Yes{/if}</td>
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
			<th>Private</th>
		</tr>
	</thead>
	<tbody>
	{foreach $past_trips as $trip}
		<tr class="{cycle values='odd,even'}">
			<td><a href="trip.php?trip_id={$trip->id}&amp;user={$profile->screen_name}">{$trip->display_name}</a></td>
			<td>{$trip->primary_location}</td>
			<td>{$trip->start_date|date_format}</td>
			<td>{$trip->end_date|date_format}</td>
			<td>{if $trip->is_private eq 'false'}No{else}Yes{/if}</td>
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