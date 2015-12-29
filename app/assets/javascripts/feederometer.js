$(document).ready(function(){
	function set_background(){
		var panel = $('.panel-profile')
	    var championName = panel.attr('data-champion');

	    panel.css('background-image', 'url(http://ddragon.leagueoflegends.com/cdn/img/champion/splash/' + championName + '_0.jpg)')
	}

	set_background();

	var feedPercentage = $('.feederometer-bar').attr('data-feed');
	var widthFeed = feedPercentage + "%"
	$('.custom-bar').animate({ width: widthFeed }, 1500);
});