class AddCategoryToRecommendedFreelancers < ActiveRecord::Migration
  def change
    add_column :recommended_freelancers, :category, :string
  end
end
