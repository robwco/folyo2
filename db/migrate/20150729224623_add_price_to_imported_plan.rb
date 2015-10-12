class AddPriceToImportedPlan < ActiveRecord::Migration
  def change
    add_column :imported_plans, :price, :integer
  end
end
