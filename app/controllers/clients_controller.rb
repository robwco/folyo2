class ClientsController < ApplicationController
	def new
		@client = Client.new
	end

	def create
		@client = Client.new(params[:client])
		if @client.save
			redirect_to root_url, notice: "Thank you for signing up!"
		else
			render "new"
		end
	end
end
