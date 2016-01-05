class AddStateStringToFavoriteLeads < ActiveRecord::Migration
  def change
    add_column :favorite_leads, :state, :string
  end
end
