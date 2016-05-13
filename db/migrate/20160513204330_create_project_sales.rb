class CreateProjectSales < ActiveRecord::Migration
  def change
    create_table :project_sales do |t|
      t.references :user, index: true
      t.references :project, index: true
      t.references :listing_package, index: true
      t.string :stripe_id

      t.timestamps
    end
  end
end
