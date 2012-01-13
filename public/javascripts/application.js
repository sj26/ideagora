// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function($){
	var displayPanel, lists, currentItem;
	
	// Set active inspected article
	function setActiveItem(article) {
		var orig = article,
			shown = article[0].cloneNode(true,false),
			previous = currentItem;

		previous && previous.removeClass("selected");
		displayPanel.empty().append(shown);
		orig.addClass("selected");
		currentItem = orig;
	}
	
	// Bind functionality of summary lists
	$.fn.ready(function() {
		displayPanel = $(".item-detail-panel");
		// Don't bother improving anything if the page didn't define a details area.
		if (!displayPanel.size())
			return;

		// Make the box float if we scroll past it.
		displayPanel.portamento({
			wrapper: $(".expandable-list")
		});

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

// Relative times for talks, or things that want it (had I written it that way).
(function($) {
	function timeGem(date) {
		var el = $("<span class='time-gem'></span>"), t,
			relative = new Date(date).toRelativeTime(),
			time = Math.abs(relative.time);
		
		if (relative.time >= 0) {
			el.append("<i>in </i>");
			el.addClass("future");
		}
		t = $("<time>").html(time).attr("datetime", date);
		t.append($("<span class='units'>").html(" " + relative.unit));
		el.append(t);
		el.attr("data-unit", relative.unit);
		if (relative.time < 0) {
			el.append($("<i> ago</i>"));
			el.addClass("past");
		}

		
		return el;
	}
	
	$.fn.ready(function() {
		$(".event").each(function(i, el) {
			var talk = $(el),
				time = talk.find("time[datetime]");
			talk.append(timeGem(time.attr("datetime"))).addClass("with-time-gem");
		});
	});
}(jQuery));