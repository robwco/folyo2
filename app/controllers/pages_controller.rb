class PagesController < ApplicationController
  def home
    @leads = Lead.all
    @exclusives = Exclusive.all
    @sent_this_week = @leads.this_week.map{ |lead| lead.budget.to_i }.reduce(0, :+) + @exclusives.this_week.map{ |exclusive| exclusive.budget.to_i }.reduce(0, :+)
  end
  def about
	end
	def help
	end
	def popular
	end
	def successful_order
	end
end