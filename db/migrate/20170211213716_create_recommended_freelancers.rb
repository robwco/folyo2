class CreateRecommendedFreelancers < ActiveRecord::Migration
  def change
    create_table :recommended_freelancers do |t|
      t.string :name
      t.string :title
      t.text :description
      t.integer :price
      t.string :email

      t.timestamps
    end
  end
end
