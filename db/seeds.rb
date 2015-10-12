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

if RssFeed.all.count == 0
	RssFeed.create([
		{name: "Smashing Jobs", xml_url: "http://jobs.smashingmagazine.com/rss/all/all"},
		{name: "AuthenticJobs.com Job Listings", xml_url: "https://authenticjobs.com/rss/custom.php?terms=&type=3,2,6&cats=&onlyremote=1&location="}, 
		{name: "Dribbble / Jobs", xml_url: "https://dribbble.com/jobs.rss"}, 
		#{name: "Tuts+ Jobs RSS Feed", xml_url: "https://jobs.tutsplus.com/jobs.rss?employment_type=contract&anywhere=true"}, 
		{name: "WWR: Programming Jobs", xml_url: "https://weworkremotely.com/categories/2/jobs.rss"}, 
		{name: "WWR: Design Jobs", xml_url: "https://weworkremotely.com/categories/1/jobs.rss"}, 
		{name: "WPhired", xml_url: "http://feeds.feedburner.com/wphired"}, 
		{name: "Behance JobList", xml_url: "http://feeds.feedburner.com/BehanceNetworkJoblist"}, 
		{name: "RFP Blogspot", xml_url: "http://webservicesrfp.blogspot.com/feeds/posts/default"}, 
		{name: "Twitter 'freelance developer'", xml_url: "https://queryfeed.net/twitter?q=freelance+developer+email&geocode="}, 
		{name: "Twitter 'freelance designer email'", xml_url: "https://queryfeed.net/twitter?q=freelance+designer+email&geocode="}, 
		{name: "Twitter 'web dev rfp'", xml_url: "https://queryfeed.net/twitter?q=web+development+rfp&geocode="}, 
		{name: "Motionographer Jobs", xml_url: "http://feeds.feedburner.com/motionographer/zLzp"}, 
		{name: "Drupal Jobs", xml_url: "https://groups.drupal.org/jobs/feed"}, 
		{name: "djangogigs.com", xml_url: "https://djangogigs.com/feeds/gigs/"}, 
		{name: "Top Ruby Jobs", xml_url: "https://toprubyjobs.com/jobs.atom"}, 
		{name: "Railsjob.com", xml_url: "http://feeds.feedburner.com/railsjob"}, 
		{name: "Stackoverflow “freelance”", xml_url: "http://careers.stackoverflow.com/jobs/feed?searchTerm=freelance&allowsremote=True"}, 
		{name: "WordPress Jobs 'Design'", xml_url: "http://jobs.wordpress.net/job_category/design/feed/"}, 
		{name: "WordPress 'general'", xml_url: "http://jobs.wordpress.net/job_category/general/feed/"}, 
		{name: "Railsjobbers.com", xml_url: "http://railsjobbers.com/rss/"}, 
		{name: "Djangojobbers.com", xml_url: "http://djangojobbers.com/rss/"}, 
		#{name: "Remojobo", xml_url: "http://www.remojobo.com/feed/"}, 
		{name: "Krop", xml_url: "http://www.krop.com/services/feeds/rss/latest/"}, 
		{name: "CL SD 'freelance web developer'", xml_url: "http://sandiego.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL SD 'freelance designer'", xml_url: "http://sandiego.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL LA 'freelance designer'", xml_url: "http://losangeles.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "SF 'freelance designer'", xml_url: "http://sfbay.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL SF 'freelance developer'", xml_url: "http://sfbay.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL CHI 'freelance designer'", xml_url: "http://chicago.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL CHI 'freelance developer'", xml_url: "http://chicago.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL PHI 'freelance designer'", xml_url: "http://philadelphia.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL PHI 'freelance developer'", xml_url: "http://philadelphia.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL AUSTIN 'freelance design'", xml_url: "http://austin.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20design&s=0&sort=rel&format=rss"}, 
		{name: "CL Austin 'freelance developer'", xml_url: "http://austin.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL NYC 'freelance design'", xml_url: "http://newyork.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL NYC 'freelance developer'", xml_url: "http://newyork.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "Node.js Jobs", xml_url: "http://jobs.nodejs.org/a/jbb/find-jobs-rss"}, 
		{name: "NodeJobs.com", xml_url: "http://www.nodejobs.com/feed/rss"}, 
		{name: "PHP Telecommute", xml_url: "http://www.phpjobs.com/php-telecommute/feeds/rss20"}, 
		{name: "SPD Job Board", xml_url: "http://www.spd.org/job-board/atom.xml"}, 
		{name: "JS Ninja", xml_url: "http://jobs.jsninja.com/a/jbb/find-jobs-rss?sb=1&sbo=1"}, 
		{name: "PHP Jobs", xml_url: "http://www.phpjobs.com/search?d=1&distance=50&country_code=us&job_group_ids[14131]=1&sort_by=date&search=1&format=rss20"}, 
		{name: "CL Seattle Freelance Design", xml_url: "http://seattle.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20design&s=0&format=rss"}, 
		{name: "UX Jobs Board", xml_url: "http://www.uxjobsboard.com/feed/"}, 
		{name: "UX Magazine Jobs", xml_url: "http://uxmag.com/uxjobs/rss/feed.xml"}, 
		{name: "Usability News: Jobs", xml_url: "http://usabilitynews.bcs.org/server.php?controller=rss&source=block&id=6585"}, 
		{name: "justUXjobs", xml_url: "http://www.justuxjobs.com/rss/all/"}, 
		{name: "Boxes And Arrows Jobs Listing", xml_url: "http://feeds.feedburner.com/BoxesAndArrowsJobs"}, 
		{name: "HypepotamusFreelance Archives » Hyp...", xml_url: "http://www.hypepotamus.com/?feed=job_feed&type=freelance,part-time&location&job_categories&s"}, 
		{name: "ExpressionEngine Job Board", xml_url: "http://feeds.feedburner.com/Director-eeJobBoard"}, 
		{name: "LaraJobs", xml_url: "https://larajobs.com/feed"}, 
		{name: "We Love AngularJS jobs", xml_url: "http://www.weloveangular.com/jobs/feed.atom"}, 
		{name: "Jobs allowing remote work", xml_url: "http://careers.stackoverflow.com/jobs/feed?allowsremote=True"}, 
		{name: "Genuinejobs.com", xml_url: "http://www.genuinejobs.com/feed/"}, 
		{name: "WFH.io Remote Software Development Jobs", xml_url: "https://www.wfh.io/jobs/category/1/jobs.atom"}, 
		{name: "Core Intuition", xml_url: "http://jobs.coreint.org/rss.xml"}, 
		#{name: "Startup Jobs", xml_url: "http://marsjobs.net/jobs/feed"}, 
		{name: "Ruby and Rails jobs", xml_url: "http://jobs.rubynow.com/rss/feed.xml"}, 
		{name: "Telecommute jobs - Jobs You can do from Home", xml_url: "http://telecommutejobs.biz/feed/"}, 
		{name: "Job Postings from Coroflot.com", xml_url: "http://feeds.feedburner.com/coroflot/AllJobs"}, 
		{name: "Jobmote - Telecommute jobs", xml_url: "http://jobmote.com/feed.rss"}, 
		{name: "Freelance Jobs", xml_url: "http://www.freelancejobopenings.com/feeds/rss20"}, 
		{name: "Freelance jobs", xml_url: "http://www.simplyhired.com/a/jobs/rss/q-freelance"}, 
		#{name: "Job offers from javascript.jobbersnet.com", xml_url: "http://javascript.jobbersnet.com/rss/"}, 
		#{name: "Job offers from android.jobbersnet.com", xml_url: "http://android.jobbersnet.com/rss/"}, 
		#{name: "Job offers from ios.jobbersnet.com", xml_url: "http://ios.jobbersnet.com/rss/"}, 
		#{name: "Job offers from php.jobbersnet.com", xml_url: "http://php.jobbersnet.com/rss/"}, 
		{name: "Latest jobs from Ruby on Rails Jobs", xml_url: "http://www.rorjobs.com/a/jbb/find-jobs-rss"}
	])
end
