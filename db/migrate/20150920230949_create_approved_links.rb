class CreateApprovedLinks < ActiveRecord::Migration
  def change
    create_table :approved_links do |t|
      t.string :title
      t.string :link
      t.text :description
      t.datetime :pub_date
      t.string :guid
      t.boolean :hidden
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
