class AddMessagesToReply < ActiveRecord::Migration
  def change
    add_column :replies, :biography, :string, limit: 300
    add_column :replies, :next_steps, :string, limit: 300
  end
end
