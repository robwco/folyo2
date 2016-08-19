class ChangeStatusOnProject < ActiveRecord::Migration
  def change
    remove_column :projects, :status
    add_column :projects, :status, :string
  end
end
