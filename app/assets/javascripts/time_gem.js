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
		t = $("<time>").attr("datetime", date);
		t.append($("<span class='value'>").html(time));
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
		$(":not(form).event").each(function(i, el) {
			var talk = $(el),
				time = talk.attr("data-start"),
				timestamp = parseInt(time,10)*1000,
				date = new Date(timestamp);
			talk.append(timeGem(date)).addClass("with-time-gem");
		});
	});
}(jQuery));
