class AddProColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :priority, :integer, default: 0
    add_column :projects, :priority_start, :datetime
  end
end
