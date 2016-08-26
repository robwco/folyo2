class ChargeProject
	def self.call(token, project)
		begin
		  charge = Stripe::Charge.create(
        amount:      (project.listing_package.price * 100).to_i,
        currency:    "usd",
        source:      token,
        description: "Project listing id: #{project.id}"
		  )
		  @sale = ProjectSale.create!(
        user:      project.user,
        project:	project,
        listing_package: project.listing_package,
        stripe_id:  charge.id
		  )
		  project.publish
      project.priority = 1
      project.priority_start = DateTime.now
		  return true
		rescue Stripe::CardError => e
		  # The card has been declined or
		  # some other error has occurred
		  project.errors[:base] << e.message
		  return false
		end		
	end
end
