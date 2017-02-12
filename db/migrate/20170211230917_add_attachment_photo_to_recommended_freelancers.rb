class AddAttachmentPhotoToRecommendedFreelancers < ActiveRecord::Migration
  def self.up
    change_table :recommended_freelancers do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :recommended_freelancers, :photo
  end
end
