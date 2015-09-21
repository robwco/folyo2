class CreateRssFeeds < ActiveRecord::Migration
  def change
    create_table :rss_feeds do |t|
      t.string :name
      t.string :xml_url
      t.datetime :last_updated
    end
  end
end
