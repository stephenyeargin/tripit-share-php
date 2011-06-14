{textformat wrap=70 style="email" wrap="\r\n"}
{$sender_name} has sent you the following trip itinerary.

-----------------------------------------

{if $message ne ''}
{$message}

-----------------------------------------
{/if}

|| {$trip->Trip->display_name} ||

{if isset($to_send.air)}
-- Air Travel --

{foreach $air as $k => $air_item}
{foreach $air_item->Segment as $k => $segment_item}
{$segment_item->start_city_name} to {$segment_item->end_city_name} 
    **Take-off:** {$segment_item->StartDateTime->time|date_format:'%l:%M %p'} ({$segment_item->StartDateTime->date|date_format}) 
    **Landing:** {$segment_item->EndDateTime->time|date_format:'%l:%M %p'} 
    **Place:** {$segment_item->start_airport_code} 
    **Airline:** {$segment_item->marketing_airline} 
    **Flight Number:** {$segment_item->marketing_airline_code}  {$segment_item->marketing_flight_number} 

{/foreach}
{/foreach}
{/if}


{if isset($to_send.transport)}
-- Transportation --

{foreach $transport as $k => $transport_item}
{foreach $transport_item->Segment as $k => $segment_item}
{$segment_item->start_location_name} to {$segment_item->end_location_name} 
    **Time:** {$segment_item->StartDateTime->time|date_format:'%l:%M %p'} 
    **Date:** {$segment_item->StartDateTime->date|date_format} 
    **Place:** {$segment_item->StartLocationAddress->address} 
    **Carrier:** {$segment_item->carrier_name} 

{/foreach}
{/foreach}
{/if}


{if $to_send.lodging eq 1}
-- Lodging --

{foreach $lodging as $k => $lodging_item}
{$lodging_item->display_name}
    **Time:** {$lodging_item->StartDateTime->time|date_format:'%l:%M %p'} 
    **Date:** {$lodging_item->StartDateTime->date|date_format} 
    **Address:** {$lodging_item->Address->address} 

{/foreach}
{/if}

{if isset($to_send.activity)}
-- Activities --

{foreach $activity as $k => $activity_item}
{$activity_item->display_name}
    **Time:** {$activity_item->StartDateTime->time|date_format:'%l:%M %p'} 
    **Date:** {$activity_item->StartDateTime->date|date_format} 
    **Address:** {$activity_item->Address->address} 

{/foreach}
{/if}

{/textformat}