require_relative "riot_api_requests_json"
require_relative "champion_data_json"

class RiotApiDataProcessor
	def initialize
		@riot_api = RiotApiRequestsJSON.new('73cb4b46-ae25-440f-bb17-da66159eff9b')
		@champion_data_json = ChampionDataJson.new
	end

	def get_recent_games_data_for_summoner_name(summoner_name)
		summoner_name = summoner_name.downcase

		summoner_data = @riot_api.request_summoner_data(summoner_name)
		summoner_id = summoner_data[summoner_name]["id"]
		recent_games_data = @riot_api.request_recent_games_data(summoner_id)

		recent_games_summoner_data = {
			:name => summoner_data[summoner_name]["name"],
			:icon_id => summoner_data[summoner_name]["profileIconId"],
			:stats_games => recent_games_data["games"].map do | item |
				{
					:deaths => item["stats"]["numDeaths"] ||= 0,
					:assists => item["stats"]["assists"] ||= 0,
					:kills => item["stats"]["championsKilled"] ||= 0,
					:win => item["stats"]["win"],
					:champion_data => get_champion_data(item["championId"])
				}
			end
		}		
	end

	def get_champion_data(id)
		@champion_data_json.get_champion_data_from_id(id)
	end

	private :get_champion_data
end