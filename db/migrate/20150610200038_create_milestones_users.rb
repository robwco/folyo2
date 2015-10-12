class CreateMilestonesUsers < ActiveRecord::Migration
  def change
    create_table :milestones_users, id: false do |t|
		t.belongs_to :milestone, index: true
		t.belongs_to :user, index: true
    end
  end
end
