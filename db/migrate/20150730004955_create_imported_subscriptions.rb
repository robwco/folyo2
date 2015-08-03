class CreateImportedSubscriptions < ActiveRecord::Migration
  def change
    create_table :imported_subscriptions do |t|
      t.integer :memberful_id
      t.string :name
      t.string :email
      t.integer :memberful_plan_id
      t.boolean :renews
      t.string :stripe_customer_id
      t.datetime :subscription_start
      t.datetime :subscription_end
      t.references :user, index: true

      t.timestamps
    end
  end
end
