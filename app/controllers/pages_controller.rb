class PagesController < ApplicationController
  def home
    @leads = Lead.all
    @exclusives = Exclusive.all
    @number_of_leads_this_week = Lead.this_week.distinct.count
    @sent_this_week = @leads.this_week.map{ |lead| lead.budget.to_i }.reduce((@number_of_leads_this_week * 1000), :+) + @exclusives.this_week.map{ |exclusive| exclusive.budget.to_i }.reduce(0, :+)
    @number_of_leads_this_month = Lead.this_month.distinct.count
    @sent_this_month = @leads.this_month.map{ |lead| lead.budget.to_i }.reduce((@number_of_leads_this_month * 1000), :+) + @exclusives.this_month.map{ |exclusive| exclusive.budget.to_i }.reduce(0, :+)
    if user_signed_in?
      redirect_to people_url
    end

    # Sales Links
    if params[:coupon] == "pjrvs"
      @sales_link = 'https://workshop.memberful.com/checkout?plan=3618'
      @coupon_message = '<p class="coupon_message">Hey there, Creative Class! I too am a big fan of Paul Jarvis &hearts; so I offered his students <strong>20% off</strong> at the bottom of this page! – Robert</p>'.html_safe
    elsif params[:coupon] == "obie"
      @sales_link = 'https://workshop.memberful.com/checkout?plan=2236'
      @coupon_message = '<p class="coupon_message">Hey there! I too am a big fan of Obie Fernandez &hearts; so I offered his peeps a <strong>15-day free trial</strong> at the bottom of this page! – Robert</p>'.html_safe
    elsif params[:coupon] == "brennan"
      @sales_link = 'https://workshop.memberful.com/checkout?plan=2238'
      @coupon_message = '<p class="coupon_message">Hey there, DYFRers! I too am a big fan of Brennan Dunn &hearts; so I offered his homies a <strong>15-day free trial</strong> at the bottom of this page! – Robert</p>'.html_safe
    elsif params[:coupon] == "jfdi"
      @sales_link = 'https://workshop.memberful.com/checkout?plan=4021'
      @coupon_message = '<p class="coupon_message">Hey JFDI! You helped me start Workshop a year ago and continue to help me improve it today.<br> As a special thank you for all JFDIers, I&#39;m offering <strong>20% off and a free 15 day trial</strong> at the bottom of this page. Thanks again, you guys rock! – Robert</p>'.html_safe
    elsif params[:coupon] == "2015"
      @sales_link = 'https://workshop.memberful.com/checkout?plan=2713'
      @coupon_message = '<p class="coupon_message">Happy New Year! As a special thank you, I&#39;m offering <strong>20% off and a free 30 day trial</strong> at the bottom of this page. Thanks again, you guys rock! – Robert</p>'.html_safe
    else
      @sales_link = 'https://workshop.memberful.com/checkout?plan=1798'
    end
  end

  def help
    @faqs = Faq.all
  end
  
  def feedback
    render layout: false
  end
  
  def clientfeedback
    render layout: false
  end
end
