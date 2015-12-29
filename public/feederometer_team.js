$(document).ready(function(){
	function set_background(){
		var panel = $('.panel-team')
	    var championName = panel.attr('data-champion');

	    panel.css('background-image', 'url(http://ddragon.leagueoflegends.com/cdn/img/champion/splash/' + championName + '_0.jpg)');
	}

	set_background();

	$('.feederometer-team-bar').each(function(){
		var currentBar = $(this);
		var feedPercentage = currentBar.attr('data-feed');
		currentBar.children('.custom-bar').animate({ width: feedPercentage + "%" }, 
		1500, function(){
			// animation completed
			if(feedPercentage <= 0){
				currentBar.next().text(parseInt(feedPercentage) + "%! Such Tryhard");				
			}
			else if(feedPercentage > 0 && feedPercentage <= 60){
				currentBar.addClass('normal');
				currentBar.parents('.player').addClass('normal');
				currentBar.next().text(parseInt(feedPercentage) + "%!");				
			}
			else if(feedPercentage > 60){
				currentBar.addClass('feeder');
				currentBar.parents('.player').addClass('feeder');
				currentBar.next().text(parseInt(feedPercentage) + "%! REPORT!!!");
			}
		});

	});
});