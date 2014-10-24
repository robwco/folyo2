class AddCategoryToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :category, :string
  end
end
