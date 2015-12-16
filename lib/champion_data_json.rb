require 'json'
require 'pp'

class ChampionDataJson
	def initialize
		file = File.read('lib/champions.json')

		@champion_data = JSON.parse(file)
	end

	def get_champion_name_from_id(key)
		key = key.to_s

		filtered = @champion_data['data'].values.find do | champ_data |
		    champ_data['key'] == key
		  end

		pp filtered
	end
end


test = ChampionDataJson.new
test.get_champion_name_from_id(8)