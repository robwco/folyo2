# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Category.all.count == 0
	Category.create([{name: 'Graphics', description: 'Branding design<br>Art Direction<br>Logo design<br>Packaging design<br>Print design<br>Illustration<br>Infographics<br>Animation design<br>Email design'},
					{name: 'Marketing', description: 'Content Creation<br>Conversion optimization<br>Copywriting<br>Search engine optimization<br>Adword'},
					{name: 'Interaction', description: 'Web design<br>Interface design<br>Mobile design<br>Usability<br>User experience'},
					{name: 'PHP', description: 'Drupal development<br>Wordpress development<br>Joomla development<br>Laravel development<br>Magento development'},
					{name: 'Javascript', description: 'Angular.js<br>Node.js<br>Meteor.js<br>Javascript<br>Jquery'},
					{name: 'Python', description: 'Django development<br>Flask development<br>Pyramid development'},
					{name: 'Ruby', description: 'Ruby on Rails development<br>Sinatra development'},
					{name: 'Mobile', description: 'Android development<br>iOS development'}])
end

if Milestone.all.count == 0
	Milestone.create([{description: 'I sent an email to a potential client about their project'},
					  {description: 'I got a reply from a client I found on Workshop'},
					  {description: 'I followed up with a prospect who replied to my email'},
					  {description: 'I landed work from a client I found on Workshop!'}])
end
