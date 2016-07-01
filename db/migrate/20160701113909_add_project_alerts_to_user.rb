class AddProjectAlertsToUser < ActiveRecord::Migration
  def change
    add_column :users, :project_alerts, :boolean
  end
end
