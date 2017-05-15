class AlterReplyMessageLimits < ActiveRecord::Migration
  def change
    change_column :replies, :message, :string, limit: 300
    change_column :replies, :portfolio_message, :string, limit: 600
  end
end
