class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :stripe_id
      t.string :name
      t.text :description
	  t.integer :amount
      t.string :interval
      t.boolean :published

      t.timestamps
    end
  end
end
