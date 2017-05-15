module ProjectsHelper
  
  def first_name(name)
    name.blank? ? "" : name.split(" ")[0]
  end
end
