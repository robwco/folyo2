class AddBiographyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :biography, :string, limit: 300
  end
end
