class AddArchivedToReply < ActiveRecord::Migration
  def change
    add_column :replies, :archived, :boolean, default: false
  end
end
