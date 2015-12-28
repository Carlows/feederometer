require 'feederometer_calculations'
require 'pp'

class FeederController < ApplicationController
  def index
  end

  def find
  	feederometer = FeederometerCalculations.new

  	if params[:summoner_name].blank?
      @message = 'You have to specify a summoner name'
    else
  		@summoner_name = params[:summoner_name]
      @model = feederometer.calculate_feeder_data_summoner(@summoner_name)

  		#begin
  		#	@model = feederometer.calculate_feeder_data_summoner(@summoner_name)
  		#rescue
  		#	@message = 'The summoner name you specified was not found.'
  		#end
  	end
  end

  def find_team
    feederometer = FeederometerCalculations.new

    if params[:summoner_name].blank?
      @message = 'You have to specify a summoner name'
    else
      @summoner_name = params[:summoner_name]

      begin
        @model = feederometer.calculate_feeder_data_team(@summoner_name)
      rescue
        redirect_to action: 'find', summoner_name: params[:summoner_name]
      end
    end
  end
end
