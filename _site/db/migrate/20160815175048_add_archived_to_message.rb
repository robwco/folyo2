class AddArchivedToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :archived, :boolean, default: false
  end
end
