$(document).ready(function(){
	function set_background(){
		var panel = $('.panel-profile')
	    var championName = panel.attr('data-champion');

	    panel.css('background-image', 'url(http://ddragon.leagueoflegends.com/cdn/img/champion/splash/' + championName + '_0.jpg)')
	}

	function get_text(feed_percentage){
		var amountOfGamesFeed = (feed_percentage / 100.0) * 5;
		if(feed_percentage <= 0) return feed_percentage + "%! ("+ amountOfGamesFeed +" out of 10 games) Seems like we found a tryhard!";
		else if(feed_percentage > 0 && feed_percentage <= 60) return feed_percentage + "%! ("+ amountOfGamesFeed +" out of 10 games) Well... Maybe he just got mad(?";
		else if(feed_percentage > 60 && feed_percentage <= 90) return feed_percentage + "%!! ("+ amountOfGamesFeed +" out of 10 games) This guy is a feeder, RUN!";
		else return feed_percentage + "%!!! ("+ amountOfGamesFeed +"+ out of 10 games) HOLY COW, JUST PRESS THE REPORT BUTTON!!";
	}

	function set_feederometer_color(feed_percentage){
		if(feed_percentage > 60) $('.feederometer').addClass('feeder');
	}

	set_background();

	var feedPercentage = $('.feederometer-bar').attr('data-feed');
	set_feederometer_color(feedPercentage);
	var widthFeed = feedPercentage + "%"
	$('.custom-bar').animate({ width: widthFeed }, 1500);
	$('.feederometer-phrase').text(get_text(feedPercentage));
});