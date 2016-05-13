class CreateListingPackages < ActiveRecord::Migration
  def change
    create_table :listing_packages do |t|
      t.string :title
      t.string :description
      t.decimal :price

      t.timestamps
    end
  end
end
