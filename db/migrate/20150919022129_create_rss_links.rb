class CreateRssLinks < ActiveRecord::Migration
  def change
    create_table :rss_links do |t|
      t.string :title
      t.string :link
      t.text :description
      t.datetime :pub_date
      t.string :guid
      t.references :rss_feed, index: true
    end
  end
end
