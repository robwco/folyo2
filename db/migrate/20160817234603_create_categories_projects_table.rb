class CreateCategoriesProjectsTable < ActiveRecord::Migration
  def change
    create_table :categories_projects, id: false do |t|
      t.references :category
      t.references :project
    end
    add_index :categories_projects, [:category_id, :project_id]
    add_index :categories_projects, :project_id
  end
end
