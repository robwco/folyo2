class AddAnchorToFaqs < ActiveRecord::Migration
  def change
    add_column :faqs, :anchor, :string
  end
end
