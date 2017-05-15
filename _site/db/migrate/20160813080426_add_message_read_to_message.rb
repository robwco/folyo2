class AddMessageReadToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :message_read, :boolean, default: false
  end
end
