require 'json'

class ChampionDataJson
	def initialize
		file = File.read('lib/champions.json')

		@champion_data = JSON.parse(file)
	end

	def get_champion_data_from_id(key)
		key = key.to_s

		filtered = @champion_data['data'].values.find do | champ_data |
		    champ_data['key'] == key
		  end

		champion_data = {
			:image_name => filtered["id"],
			:champion_name => filtered["name"]
		}
	end
end