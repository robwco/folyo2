class AddAttachmentImageToLeads < ActiveRecord::Migration
  def self.up
    change_table :leads do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :leads, :image
  end
end
