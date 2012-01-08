// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function($){
	var displayPanel, lists;
	
	// Set active inspected article
	function setActiveItem(article) {
		var orig = article,
			shown = article[0].cloneNode(true,false);
		
		displayPanel.empty().append(shown);
	}
	
	// Bind functionality of summary lists
	$.fn.ready(function() {
		displayPanel = $("#item-details");
		// Don't bother improving anything if the page didn't define a details area.
		if (!displayPanel.size())
			return;

		displayPanel.

		lists = $(".summary-list");
		lists.children().each(function(i, el) {
			var item = $(el);
			// Bind the whole item to display details on click
			item.addClass("expandable").click(function() {
				var article = item.children().first();
				setActiveItem(article);
			});
			// Prevent clicks on the item's canonical link from taking us away from the page.
			item.find("a.item-link").click(function(e) {
				e.preventDefault();
			});
		});
	});
}(jQuery));