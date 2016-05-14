module MessagesHelper
	def message_recipient(reply)
		return reply.user.name if reply.project.user == current_user
		return reply.project.user.name if reply.user == current_user
	end
	def message_sender(message)
		return "You" if message.user == current_user
		first_name message.user.name
	end
	def message_color(message)
		return "background-color: #ecf6fa;" if message.user == current_user
		"background-color: #f1f1f1;"
	end
end
