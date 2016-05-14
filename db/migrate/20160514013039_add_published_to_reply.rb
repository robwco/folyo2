class AddPublishedToReply < ActiveRecord::Migration
  def change
    add_column :replies, :published, :boolean, default: false
  end
end
