class PagesController < ApplicationController
  def home
    @leads = Lead.all
    @exclusives = Exclusive.all
    @number_of_leads_this_week = Lead.this_week.distinct.count
    @sent_this_week = @leads.this_week.map{ |lead| lead.budget.to_i }.reduce((@number_of_leads_this_week * 1000), :+) + @exclusives.this_week.map{ |exclusive| exclusive.budget.to_i }.reduce(0, :+)

    # Sales Links
    if params[:coupon] == "pjrvs"
      @sales_link = 'https://workshop.memberful.com/checkout?plan=3618'
      @coupon_message = '<p class="coupon_message">Hey there, Creative Class! I too am a big fan of Paul Jarvis&hearts; so I offered his students 20% off at the bottom of this page! – Robert</p>'.html_safe
    end
    if params[:coupon] == "obie"
      @sales_link = 'https://workshop.memberful.com/checkout?plan=2236'
      @coupon_message = '<p class="coupon_message">Hey there! I too am a big fan of Obie Fernandez&hearts; so I offered his peeps 20% off at the bottom of this page! – Robert</p>'.html_safe
    end
    if params[:coupon] == "brennan"
      @sales_link = 'https://workshop.memberful.com/checkout?plan=2238'
      @coupon_message = '<p class="coupon_message">Hey there, DYFRers! I too am a big fan of Brennan Dunn&hearts; so I offered his homies 20% off at the bottom of this page! – Robert</p>'.html_safe
    else
      @sales_link = 'https://workshop.memberful.com/checkout?plan=1775'
    end
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
