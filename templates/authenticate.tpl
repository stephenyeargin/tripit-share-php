{extends file="layout.tpl"}
{block name=title}TripIt - Authenticate{/block}
{block name=sidebar}{/block}
{block name=body}

<div class="welcome-text">
	<p>This service allows you to access your TripIt&reg; trips and share them via e-mail with others without requiring that they have their own account. You can customize which components of your trip you want to share in the e-mail message.</p>
	<p>This is an open-source project. You can download and customize it by visiting the <a href="https://github.com/stephenyeargin/tripit-share-php">GitHub project</a>.</p>
</div>
	

<p>
	<a href="https://www.tripit.com/oauth/authorize?oauth_token={$token}&amp;oauth_callback={$callback}" class="button">Authenticate with TripIt</a>
</p>

{/block}
