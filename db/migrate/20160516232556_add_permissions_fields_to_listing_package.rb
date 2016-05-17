class AddPermissionsFieldsToListingPackage < ActiveRecord::Migration
  def change
    add_column :listing_packages, :unlimited_portfolio_replies, :boolean, default: false
    add_column :listing_packages, :send_to_twitter, :boolean, default: false
    add_column :listing_packages, :send_to_email_list, :boolean, default: false
    add_column :listing_packages, :done_for_you, :boolean, default: false
  end
end
