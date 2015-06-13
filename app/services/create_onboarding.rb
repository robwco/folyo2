class CreateOnboarding
	def self.call(user)
		category_ids = user.category_ids

		if category_ids.empty?
			leads = Lead.most_recent.limit(4)
		else
			leads = Lead.most_recent.where("category_id IN (?)", category_ids).limit(4)
		end

		leads_fields = Hash.new

		leads_fields["workshop_plan"] = user.subscription.plan.stripe_id

		leads.each.with_index(1) do|lead,index|
			leads_fields["lead#{index}_photo"] = lead.photo
			leads_fields["lead#{index}_title"] = lead.title
			leads_fields["lead#{index}_url"] = lead.url
			leads_fields["lead#{index}_name"] = lead.name
			leads_fields["lead#{index}_email"] = lead.email
			leads_fields["lead#{index}_twitter"] = lead.twitter
			leads_fields["lead#{index}_linkedin"] = lead.linkedin
			leads_fields["lead#{index}_website"] = lead.website
			leads_fields["lead#{index}_budget"] = lead.budget
			leads_fields["lead#{index}_category"] = lead.category
		end

		Drip::Client.default_client.create_or_update_subscriber user.email, { 'custom_fields' => leads_fields }
	end
end
