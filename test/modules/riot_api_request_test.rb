require 'test_helper'
require './lib/riot_api_requests'

class RiotApiRequestsTest < ActionController::TestCase

	def setup
		@riot_api_class = RiotApiRequests.new
	end
end
