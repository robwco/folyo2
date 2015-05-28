class AdminsController < ApplicationController
	before_filter :authenticate_admin!

	def welcome

	end

end
