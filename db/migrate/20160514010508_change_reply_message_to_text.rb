class ChangeReplyMessageToText < ActiveRecord::Migration
  def change
	  change_column :replies, :message, :text
  end
end
