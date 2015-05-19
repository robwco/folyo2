class AddAncestryToFaqs < ActiveRecord::Migration
  def change
    add_column :faqs, :ancestry, :string
    add_index :faqs, :ancestry
  end
end
