class AddListingPackageToProject < ActiveRecord::Migration
  def change
    add_column :projects, :listing_package_id, :int
  end
end
