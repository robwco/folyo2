class AddAttachmentPicToExclusives < ActiveRecord::Migration
  def self.up
    change_table :exclusives do |t|
      t.attachment :pic
    end
  end

  def self.down
    remove_attachment :exclusives, :pic
  end
end
