class AddLongDescriptionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :long_description, :text
    add_column :projects, :long_description_html, :text
  end
end
