class AddAttachmentCompanyLogoToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :company_logo
    end
  end

  def self.down
    remove_attachment :projects, :company_logo
  end
end
