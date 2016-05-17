class AddPublishedAtToReply < ActiveRecord::Migration
  def change
    add_column :replies, :published_at, :datetime
  end
end
