class PagesController < ApplicationController
  def home
    @leads = Lead.all
    @exclusives = Exclusive.all
  end
end
