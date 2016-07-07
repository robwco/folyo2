class AddToUserIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :to_user_id, :int

	Message.all.each do |message|
		unless message.to_user_id
			if message.user_id == message.reply.user_id
				message.to_user_id = message.project.user_id
			else
				message.to_user_id = message.reply.user_id
			end

			message.save
		end
	end
  end
end
