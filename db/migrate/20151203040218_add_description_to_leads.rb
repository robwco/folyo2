class AddDescriptionToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :description, :text
  end
end
