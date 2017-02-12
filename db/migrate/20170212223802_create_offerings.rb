class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :description
      t.string :contact_info
      t.string :category

      t.timestamps
    end
  end
end
