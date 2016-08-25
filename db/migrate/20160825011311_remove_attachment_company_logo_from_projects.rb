class RemoveAttachmentCompanyLogoFromProjects < ActiveRecord::Migration
  def self.change
    remove_attachment :projects, :company_logo
  end
end
