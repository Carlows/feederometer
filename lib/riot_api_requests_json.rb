require 'rest-client'
require 'json'

class RiotApiRequestsJSON

	def initialize(api_key)
		@api_key = "?api_key=#{api_key}"

		@handle_response = Proc.new do | response, request, result |
			case response.code
			when 200
				JSON.parse(response)
			when 404
				raise 'Summoner not found'
			else
				raise 'There was a problem getting the data from the server'
			end
		end
	end

	# url for summoner data:
	# https://lan.api.pvp.net/api/lol/lan/v1.4/summoner/by-name/summoner_name?api_key="
	def request_summoner_data(summoner_name)
		api_request_summonerid_url = "https://lan.api.pvp.net/api/lol/lan/v1.4/summoner/by-name/"

		full_url = api_request_summonerid_url + summoner_name + @api_key

		RestClient.get(full_url, &@handle_response) 
	end

	# url for current games:
	# https://lan.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/LA1/summoner_id?api_key=
	def request_current_game_data(summoner_id)
		current_game_url = "https://lan.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/LA1/"
		full_url = current_game_url + summoner_id + @api_key

		RestClient.get(full_url, &@handle_response) 
	end

	# url for recent games:
	# https://lan.api.pvp.net/api/lol/lan/v1.3/game/by-summoner/summoner_id/recent?api_key=
	def request_recent_games_data(summoner_id)
		api_request_recent_data_url = "https://lan.api.pvp.net/api/lol/lan/v1.3/game/by-summoner/"
		full_url = api_request_recent_data_url + String(summoner_id) + "/recent" + @api_key

		RestClient.get(full_url, &@handle_response)
	end
end