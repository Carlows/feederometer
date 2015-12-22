require_relative "riot_api_requests_json"
require_relative "champion_data_json"
require 'erb'
require 'pp'

class RiotApiDataProcessor
	def initialize
		@riot_api = RiotApiRequestsJSON.new('73cb4b46-ae25-440f-bb17-da66159eff9b')
		@champion_data_json = ChampionDataJson.new
	end

	def get_recent_games_data_summoner_name(summoner_name)
		summoner_name = summoner_name.downcase
		summoner_name = remove_spaces(summoner_name)
		summoner_name_encoded = url_encode_summoner_name(summoner_name)

		summoner_data = @riot_api.request_summoner_data(summoner_name_encoded)
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

	def get_data_summoner_team(summoner_name)
		summoner_name = clean_summoner_name(summoner_name)
		summoner_name_encoded = url_encode_summoner_name(summoner_name)

		summoner_data = @riot_api.request_summoner_data(summoner_name_encoded)
		summoner_id = summoner_data[summoner_name]["id"]
		current_game_data_summoner = @riot_api.request_current_game_data(summoner_id)
		participants_data = current_game_data_summoner["participants"]
		summoner_team_data = get_team_data(participants_data, summoner_id).map do | item | 
			summoner_id = item["summonerId"]
			recent_games_data = @riot_api.request_recent_games_data(summoner_id)

			result = {
				:summoner_id => summoner_id,
				:summoner_name => item["summonerName"],
				:profile_icon_id => item["profileIconId"],
				:champion_id => item["championId"],
				:champion_data => get_champion_data(item["championId"]),
				:stats_games => recent_games_data["games"].map do | game_item |
					{
						:deaths => game_item["stats"]["numDeaths"] ||= 0,
						:assists => game_item["stats"]["assists"] ||= 0,
						:kills => game_item["stats"]["championsKilled"] ||= 0
					}
				end
			}
		end
	end

	def get_champion_data(id)
		@champion_data_json.get_champion_data_from_id(id)
	end

	def get_team_data(participants, summoner_id)
		team_id_summoner = get_summoner_team_id(participants, summoner_id)

		team_data = participants.select { | item | item["teamId"] == team_id_summoner }
	end

	def get_summoner_team_id(participants, summoner_id)
		summoner_id.to_s
		summoner_data = participants.find { | item | item["summonerId"] == summoner_id }
		team_id = summoner_data["teamId"]
	end

	def url_encode_summoner_name(summoner_name)
		ERB::Util.url_encode(summoner_name).to_s
	end

	def clean_summoner_name(summoner_name)
		summoner_name = summoner_name.downcase
		summoner_name = remove_spaces(summoner_name)
	end

	def remove_spaces(summoner_name)
		summoner_name.gsub(/\s+/, "")
	end

	private :get_champion_data, :get_summoner_team_id, :get_team_data, :url_encode_summoner_name, :remove_spaces, :clean_summoner_name
end
