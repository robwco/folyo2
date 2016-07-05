class AddCompanyDescriptionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :company_description, :string
  end
end
