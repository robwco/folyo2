class AddTypeToRecommendedFreelancer < ActiveRecord::Migration
  def change
    add_column :recommended_freelancers, :type, :string
  end
end
