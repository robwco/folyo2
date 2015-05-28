class AddCancelingToUser < ActiveRecord::Migration
  def change
    add_column :users, :canceling, :boolean
  end
end
