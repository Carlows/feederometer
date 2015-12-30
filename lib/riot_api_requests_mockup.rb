require 'json'

class RiotApiRequestsMockup
	def initialize
		carloseme_data = File.read('lib/carloseme_recent_games.json')

		@carloseme_data_hash = JSON.parse(carloseme_data)
	end

	def request_summoner_data(summoner_name)
		{
		    "carloseme" => {
		        "id" => 5740726,
		        "name" => "CarlosEME",
		        "profileIconId" => 983,
		        "summonerLevel" => 30
		    }
		}
	end

	def request_current_game_data(summoner_id)
		raise "404 not found"
	end

	def request_recent_games_data(summoner_id)
		@carloseme_data_hash
	end
end