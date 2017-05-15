class AddMessageReadToReply < ActiveRecord::Migration
  def change
    add_column :replies, :message_read, :boolean, default: false
  end
end
