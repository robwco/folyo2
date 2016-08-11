# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Category.all.count == 0
	Category.create([
    {name: 'Graphic design/mockups', description: ''},
    {name: 'Front-end development (JS)', description: ''},
		{name: 'UX/UI/Product development', description: ''},
		{name: 'Illustration', description: ''},
		{name: 'HTML/CSS', description: ''},
		{name: 'PHP', description: ''},
		{name: 'Python', description: ''},
		{name: 'Ruby', description: ''},
		{name: 'Rails', description: ''},
		{name: '.NET', description: ''},
		{name: 'Mobile (iOS / Android)', description: ''}
  ])
end

if Plan.count == 0
  Plan.create(
    { name: "Folyo", stripe_id: "folyo-free", amount: 0, published: true }
  )
end
