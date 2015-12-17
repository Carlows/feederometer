require 'feederometer_calculations'
require 'pp'

class FeederController < ApplicationController
  def find
  	feederometer = FeederometerCalculations.new

  	unless params[:summoner_name].blank?
  		@summoner_name = params[:summoner_name]

  		begin
  			@model = feederometer.calculate_feeder_data_summoner(@summoner_name)
  		rescue
  			@message = 'The summoner name you specified was not found.'
  		end
  	end
  end
end
