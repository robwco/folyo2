class AddIndexToRssLinks < ActiveRecord::Migration
  def change
    add_index :rss_links, :guid
  end
end
