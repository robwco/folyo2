module LeadsHelper
  def first_name(name)
    name.split(" ")[0]
  end
  def advanced_search?
    !params[:advanced].blank? && params[:advanced] == "true"
  end
  def search_categories
	return [] if params[:category_ids].nil?
	params[:category_ids]
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
