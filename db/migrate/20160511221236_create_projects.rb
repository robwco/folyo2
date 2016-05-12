class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :category
      t.text :goals
      t.text :examples
      t.string :deadline
      t.string :budget
      t.text :deliverables
      t.string :name
      t.string :email
      t.string :organization
      t.string :website

      t.timestamps
    end
  end
end
