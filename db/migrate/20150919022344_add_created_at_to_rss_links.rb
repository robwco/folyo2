class AddCreatedAtToRssLinks < ActiveRecord::Migration
  def change
    add_column :rss_links, :created_at, :datetime
    add_column :rss_links, :updated_at, :datetime
  end
end
