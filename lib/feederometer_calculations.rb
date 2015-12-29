require_relative "riot_api_data_processor"
require 'pp'

class FeederometerCalculations
	def initialize
		@data_processor = RiotApiDataProcessor.new
	end	

	def calculate_feeder_data_team(summoner_name)
		feederometer_data_summoner_team = @data_processor.get_data_summoner_team(summoner_name)

		feeder_team_data = feederometer_data_summoner_team.map do | item |
			{
				:summoner_name => item[:summoner_name],
				:profile_icon_id => item[:profile_icon_id],
				:champion_id => item[:champion_id],
				:champion_data => item[:champion_data],
				:feeder_percentage => calculate_feeder_percentage(item[:stats_games])
			}
		end
	end

	def calculate_feeder_data_summoner(summoner_name)
		recent_games_summoner_data = @data_processor.get_recent_games_data_summoner_name(summoner_name)

		feeder_data = {
			:name => recent_games_summoner_data[:name],
			:icon_id => recent_games_summoner_data[:icon_id],
			:last_game_data => recent_games_summoner_data[:last_game_data],
			:last_10_games_stats => recent_games_summoner_data[:stats_games],
			:feeder_percentage => calculate_feeder_percentage(recent_games_summoner_data[:stats_games])
		}
	end

	def calculate_feeder_percentage(stats_data)
		games_player_feed = stats_data.inject(0) do | total, data_item |
			deaths = data_item[:deaths]
			assists = data_item[:assists]
			kills = data_item[:kills]
			

			kda = calculate_kda(kills, deaths, assists)
			feed = feeder?(kda) ? 1 : 0
			total + feed
		end

		total_games = stats_data.count
		calculate_percentage(games_player_feed, total_games)
	end

	def calculate_kda(kills, deaths, assists)
		deaths = 1 if deaths == 0
		(kills + (assists * 0.33)) / deaths.to_f
	end

	# there's a possibility of the kda being 0, this means the player
	# went afk when the match started. we're including that as a feeder too.
	def feeder?(kda)
		kda < 0.5
	end

	def calculate_percentage(games_player_feed, total_games)
		(games_player_feed / total_games.to_f) * 100.0
	end

	private :calculate_feeder_percentage, :calculate_kda, :feeder?, :calculate_percentage
end


# feederometer = FeederometerCalculations.new

# pp feederometer.calculate_feeder_data_team("DarkRonic") 
# pp feederometer.calculate_feeder_data_summoner("Im LocoDoco")
