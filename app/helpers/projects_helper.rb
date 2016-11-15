module ProjectsHelper
  
  def first_name(name)
    name.blank? ? "" : name.split(" ")[0]
  end

  def project_creation_path
    return admin_create_projects_path if admin_signed_in? && ["admin_new", "admin_create"].include?(action_name)
    nil
  end
end
