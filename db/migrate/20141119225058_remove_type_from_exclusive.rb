class RemoveTypeFromExclusive < ActiveRecord::Migration
  def change
    remove_column :exclusives, :type, :string
  end
end
