class AddActiveToListingPackage < ActiveRecord::Migration
  def change
    add_column :listing_packages, :active, :boolean
  end
end
