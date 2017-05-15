module ExclusivesHelper
  def first_name(name)
    name.split(" ")[0]
  end
  def most_recent 
    order("created_at desc")
  end
end
