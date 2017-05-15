class RemoveProfileFieldsFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :organization
    remove_column :projects, :website
    remove_column :projects, :name
    remove_column :projects, :company_description
    remove_column :projects, :email
  end
end
