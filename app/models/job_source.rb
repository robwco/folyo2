class JobSource < ActiveRecord::Base
  has_many :leads

	scope :by_most_leads, -> {
    select("job_sources.id, job_sources.url, count(leads.id) AS leads_count").
    joins(:leads).
    group("job_sources.id").
    order("leads_count DESC") }
end
