class AddGetAlertsToUser < ActiveRecord::Migration
  def change
    add_column :users, :gets_alert, :boolean, default: false
  end
end
