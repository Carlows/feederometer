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

  		begin
  			@model = feederometer.calculate_feeder_data_summoner(@summoner_name)
  		rescue
  			@message = 'Summoner not found or there was a problem on the request.'
  		end
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
        #@model = {:summoner_name=>"Yukimii", :profile_icon_id=>912, :champion_data=>{:image_name=>"Morgana", :champion_name=>"Morgana"}, :team_data=>[{:summoner_name=>"Yukimii", :profile_icon_id=>912, :champion_id=>25, :champion_data=>{:image_name=>"Morgana", :champion_name=>"Morgana"}, :feeder_percentage=>80.0}, {:summoner_name=>"RTSxD", :profile_icon_id=>903, :champion_id=>51, :champion_data=>{:image_name=>"Caitlyn", :champion_name=>"Caitlyn"}, :feeder_percentage=>40.0}, {:summoner_name=>"WithoutThe0ther", :profile_icon_id=>985, :champion_id=>80, :champion_data=>{:image_name=>"Pantheon", :champion_name=>"Pantheon"}, :feeder_percentage=>20.0}, {:summoner_name=>"MCGxRagna", :profile_icon_id=>910, :champion_id=>91, :champion_data=>{:image_name=>"Talon", :champion_name=>"Talon"}, :feeder_percentage=>0.0}, {:summoner_name=>"Never0ne", :profile_icon_id=>913, :champion_id=>32, :champion_data=>{:image_name=>"Amumu", :champion_name=>"Amumu"}, :feeder_percentage=>40.0}]}
      rescue
        redirect_to action: 'find', summoner_name: params[:summoner_name]
      end
    end
  end
end
