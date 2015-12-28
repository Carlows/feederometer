class AddSummonerIdToSummoners < ActiveRecord::Migration
  def change
    add_column :summoners, :summoner_id, :integer
  end
end
