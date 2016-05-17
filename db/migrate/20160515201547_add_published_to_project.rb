class AddPublishedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :published, :boolean
  end
end
