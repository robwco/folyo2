class RemoveUnusedFieldsFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :category, :string
    remove_column :projects, :examples, :text
    remove_column :projects, :deadline, :string
    remove_column :projects, :deliverables, :text
    remove_column :projects, :spirit_animal, :string
  end
end
