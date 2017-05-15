class AddAttachmentPhotoToOfferings < ActiveRecord::Migration
  def self.up
    change_table :offerings do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :offerings, :photo
  end
end
