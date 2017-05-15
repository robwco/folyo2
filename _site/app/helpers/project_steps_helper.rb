module ProjectStepsHelper
	def project_wizard_step_url(project)
		return preview_project_url(project) if project.status.to_s == "project_brief"

		step_id = :company_profile
		step_id = :project_brief if project.status.to_s == "company_profile"

		project_wizard_url(project_id: project.id, id: step_id)
	end
end
