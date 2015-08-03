class CreateImportedPlans < ActiveRecord::Migration
  def change
    create_table :imported_plans do |t|
      t.integer :memberful_id
      t.string :name
      t.string :slug
      t.string :renewal_period
      t.string :interval_unit
      t.integer :interval_count
      t.references :plan, index: true

      t.timestamps
    end
  end
end
