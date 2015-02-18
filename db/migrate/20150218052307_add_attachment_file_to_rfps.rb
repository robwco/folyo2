class AddAttachmentFileToRfps < ActiveRecord::Migration
  def self.up
    change_table :rfps do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :rfps, :file
  end
end
