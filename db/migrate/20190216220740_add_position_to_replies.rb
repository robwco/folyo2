class AddPositionToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :position, :integer
  end
end
