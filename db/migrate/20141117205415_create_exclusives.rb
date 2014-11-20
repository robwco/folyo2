class CreateExclusives < ActiveRecord::Migration
  def change
    create_table :exclusives do |t|
      t.string :title
      t.string :url
      t.string :name
      t.string :email
      t.string :website
      t.string :twitter
      t.string :linkedin
      t.integer :budget
      t.string :type
      t.text :description
      t.text :notes

      t.timestamps
    end
  end
end
