class AddExpirationDateToSummoners < ActiveRecord::Migration
  def change
    add_column :summoners, :expiration_date, :datetime
  end
end
