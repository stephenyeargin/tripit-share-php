$(document).ready(function() {
	
		// Validator for Share form
		$('#share-form').validate();
		
		// Tool-tip for lock icon
		$('tr.private td.display-name a').attr('title', 'This trip is only visible by you.');
		
});