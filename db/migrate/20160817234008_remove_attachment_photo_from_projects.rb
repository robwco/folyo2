class RemoveAttachmentPhotoFromProjects < ActiveRecord::Migration
  def self.up
    remove_attachment :projects, :photo
  end

  def self.down
    change_table :projects do |t|
      t.attachment :photo
    end
  end
end
