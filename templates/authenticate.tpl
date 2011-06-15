{extends file="layout.tpl"}
{block name=title}TripIt - Authenticate{/block}
{block name=sidebar}{/block}
{block name=body}

<p>
	<a href="https://www.tripit.com/oauth/authorize?oauth_token={$token}&amp;oauth_callback={$callback}" class="medium orange button">Authenticate with TripIt</a>
</p>

{/block}
