class ChangeRecommendedFreelancer < ActiveRecord::Migration
  def change
    rename_column :recommended_freelancer, :type, :category
  end
end
