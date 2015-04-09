class AddCategoryIdToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :category_id, :integer
  end
end
