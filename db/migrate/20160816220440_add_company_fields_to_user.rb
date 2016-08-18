class AddCompanyFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :company_name, :string
    add_column :users, :company_website, :string
    add_column :users, :company_biography, :string, limit: 500
  end
end
