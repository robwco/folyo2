class AddHiddenToRssLink < ActiveRecord::Migration
  def change
    add_column :rss_links, :hidden, :boolean
    add_column :rss_links, :approved, :boolean
  end
end
