$(document).ready(function(){
	function set_background(){
		var panel = $('.panel-team')
	    var championName = panel.attr('data-champion');

	    panel.css('background-image', 'url(http://ddragon.leagueoflegends.com/cdn/img/champion/splash/' + championName + '_0.jpg)')
	}

	set_background();

	$('.feederometer-team-bar').each(function(){
		var feedPercentage = $(this).attr('data-feed');
		$(this).children('.custom-bar').animate({ width: feedPercentage + "%" }, 2000);

		if(feedPercentage > 20){
			$(this).parents('.player').addClass('feeder');
		}
	});
}