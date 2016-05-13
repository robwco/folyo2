class AddInitialListingPackages < ActiveRecord::Migration
  def change
	  if ListingPackage.count == 0
			ListingPackage.create!(
				title: "FREE", 
				description: "<p>Attract top talent</p>
					<ul>
						<li>Post your project immediately</li>
						<li>Get replies from top freelancers</li>
					</ul>",
				price: 0,
				active: true)

			ListingPackage.create!(
				title: "$79", 
				description: "<p>Get more replies</p>
				<ul>
					<li>We send your project to the inbox of 10,000 top freelancers</li>
					<li>We post your project on our twitter</li>
				</ul>",
				price: 79,
				active: true)

			ListingPackage.create!(
				title: "$149", 
				description: "<p>Get more replies with portfolio proposals</p>
				<ul>
					<li>Allow anyone to upload a portfolio piece</li>
					<li>Send your project out to 10,000 freelancers</li>
					<li>Post it on twitter</li>
				</ul>",
				price: 149,
				active: true)

			ListingPackage.create!(
				title: "$399", 
				description: "<p>Save hours of sorting through responses, we'll do all the work.</p>
				<ul>
					<li>We'll review your applicants, pick the top 3, schedlue 3 interviews and email you the time.</li>
				</ul>",
				price: 399,
				active: true)
	  end
  end
end
