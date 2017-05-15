module LeadsHelper
  def first_name(name)
    name.split(" ")[0]
  end
  def advanced_search?
    !params[:advanced].blank? && params[:advanced] == "true"
  end
  def tutorial?
    !params[:tutorial].blank? && params[:tutorial] == "true"
  end
  def category_checked?(c)
	return true if params[:category_ids].nil?
	params[:category_ids].include?(c.id.to_s)
  end
  def search_period_options 
	[
		["all time", ""],
		["this week", Date.today.beginning_of_week(:sunday)],
		["this month", Date.today.beginning_of_month],
		["last 30 days", Date.today - 30]
	]
  end
end
