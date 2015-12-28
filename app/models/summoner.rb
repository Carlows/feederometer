class Summoner < ActiveRecord::Base
	has_many :games, dependent: :destroy

	def expired?
		Time.now > self.expiration_date
	end
end
