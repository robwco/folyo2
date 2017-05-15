class ChangeStatusOnProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :status
    add_column :projects, :status, :integer, default: 0
  end
end
