class AddCategoryToExclusives < ActiveRecord::Migration
  def change
    add_column :exclusives, :category, :string
  end
end
