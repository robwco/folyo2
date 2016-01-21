class AddJobSourcesToLeads < ActiveRecord::Migration
  def change
    add_reference :leads, :job_source, index: true
  end
end
