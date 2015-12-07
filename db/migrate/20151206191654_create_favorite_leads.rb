class CreateFavoriteLeads < ActiveRecord::Migration
  def change
    create_table :favorite_leads do |t|
      t.integer :lead_id
      t.integer :user_id

      t.timestamps
    end
  end
end
