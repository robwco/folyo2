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

if JobSource.all.count == 0
	JobSource.create([
		{name: "Smashing Jobs", url: "http://jobs.smashingmagazine.com/rss/all/all"},
		{name: "AuthenticJobs.com Job Listings", url: "https://authenticjobs.com/rss/custom.php?terms=&type=3,2,6&cats=&onlyremote=1&location="}, 
		{name: "Dribbble / Jobs", url: "https://dribbble.com/jobs.rss"}, 
		#{name: "Tuts+ Jobs RSS Feed", url: "https://jobs.tutsplus.com/jobs.rss?employment_type=contract&anywhere=true"}, 
		{name: "WWR: Programming Jobs", url: "https://weworkremotely.com/categories/2/jobs.rss"}, 
		{name: "WWR: Design Jobs", url: "https://weworkremotely.com/categories/1/jobs.rss"}, 
		{name: "WPhired", url: "http://feeds.feedburner.com/wphired"}, 
		{name: "Behance JobList", url: "http://feeds.feedburner.com/BehanceNetworkJoblist"}, 
		{name: "RFP Blogspot", url: "http://webservicesrfp.blogspot.com/feeds/posts/default"}, 
		{name: "Twitter 'freelance developer'", url: "https://queryfeed.net/twitter?q=freelance+developer+email&geocode="}, 
		{name: "Twitter 'freelance designer email'", url: "https://queryfeed.net/twitter?q=freelance+designer+email&geocode="}, 
		{name: "Twitter 'web dev rfp'", url: "https://queryfeed.net/twitter?q=web+development+rfp&geocode="}, 
		{name: "Motionographer Jobs", url: "http://feeds.feedburner.com/motionographer/zLzp"}, 
		{name: "Drupal Jobs", url: "https://groups.drupal.org/jobs/feed"}, 
		{name: "djangogigs.com", url: "https://djangogigs.com/feeds/gigs/"}, 
		{name: "Top Ruby Jobs", url: "https://toprubyjobs.com/jobs.atom"}, 
		{name: "Railsjob.com", url: "http://feeds.feedburner.com/railsjob"}, 
		{name: "Stackoverflow “freelance”", url: "http://careers.stackoverflow.com/jobs/feed?searchTerm=freelance&allowsremote=True"}, 
		{name: "WordPress Jobs 'Design'", url: "http://jobs.wordpress.net/job_category/design/feed/"}, 
		{name: "WordPress 'general'", url: "http://jobs.wordpress.net/job_category/general/feed/"}, 
		{name: "Railsjobbers.com", url: "http://railsjobbers.com/rss/"}, 
		{name: "Djangojobbers.com", url: "http://djangojobbers.com/rss/"}, 
		#{name: "Remojobo", url: "http://www.remojobo.com/feed/"}, 
		{name: "Krop", url: "http://www.krop.com/services/feeds/rss/latest/"}, 
		{name: "CL SD 'freelance web developer'", url: "http://sandiego.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL SD 'freelance designer'", url: "http://sandiego.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL LA 'freelance designer'", url: "http://losangeles.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "SF 'freelance designer'", url: "http://sfbay.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL SF 'freelance developer'", url: "http://sfbay.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL CHI 'freelance designer'", url: "http://chicago.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL CHI 'freelance developer'", url: "http://chicago.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL PHI 'freelance designer'", url: "http://philadelphia.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL PHI 'freelance developer'", url: "http://philadelphia.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL AUSTIN 'freelance design'", url: "http://austin.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20design&s=0&sort=rel&format=rss"}, 
		{name: "CL Austin 'freelance developer'", url: "http://austin.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "CL NYC 'freelance design'", url: "http://newyork.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20designer&s=0&sort=rel&format=rss"}, 
		{name: "CL NYC 'freelance developer'", url: "http://newyork.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20developer&s=0&sort=rel&format=rss"}, 
		{name: "Node.js Jobs", url: "http://jobs.nodejs.org/a/jbb/find-jobs-rss"}, 
		{name: "NodeJobs.com", url: "http://www.nodejobs.com/feed/rss"}, 
		{name: "PHP Telecommute", url: "http://www.phpjobs.com/php-telecommute/feeds/rss20"}, 
		{name: "SPD Job Board", url: "http://www.spd.org/job-board/atom.xml"}, 
		{name: "JS Ninja", url: "http://jobs.jsninja.com/a/jbb/find-jobs-rss?sb=1&sbo=1"}, 
		{name: "PHP Jobs", url: "http://www.phpjobs.com/search?d=1&distance=50&country_code=us&job_group_ids[14131]=1&sort_by=date&search=1&format=rss20"}, 
		{name: "CL Seattle Freelance Design", url: "http://seattle.craigslist.org/search/jjj?catAbb=jjj&is_telecommuting=1&query=freelance%20design&s=0&format=rss"}, 
		{name: "UX Jobs Board", url: "http://www.uxjobsboard.com/feed/"}, 
		{name: "UX Magazine Jobs", url: "http://uxmag.com/uxjobs/rss/feed.xml"}, 
		{name: "Usability News: Jobs", url: "http://usabilitynews.bcs.org/server.php?controller=rss&source=block&id=6585"}, 
		{name: "justUXjobs", url: "http://www.justuxjobs.com/rss/all/"}, 
		{name: "Boxes And Arrows Jobs Listing", url: "http://feeds.feedburner.com/BoxesAndArrowsJobs"}, 
		{name: "HypepotamusFreelance Archives » Hyp...", url: "http://www.hypepotamus.com/?feed=job_feed&type=freelance,part-time&location&job_categories&s"}, 
		{name: "ExpressionEngine Job Board", url: "http://feeds.feedburner.com/Director-eeJobBoard"}, 
		{name: "LaraJobs", url: "https://larajobs.com/feed"}, 
		{name: "We Love AngularJS jobs", url: "http://www.weloveangular.com/jobs/feed.atom"}, 
		{name: "Jobs allowing remote work", url: "http://careers.stackoverflow.com/jobs/feed?allowsremote=True"}, 
		{name: "Genuinejobs.com", url: "http://www.genuinejobs.com/feed/"}, 
		{name: "WFH.io Remote Software Development Jobs", url: "https://www.wfh.io/jobs/category/1/jobs.atom"}, 
		{name: "Core Intuition", url: "http://jobs.coreint.org/rss.xml"}, 
		#{name: "Startup Jobs", url: "http://marsjobs.net/jobs/feed"}, 
		{name: "Ruby and Rails jobs", url: "http://jobs.rubynow.com/rss/feed.xml"}, 
		{name: "Telecommute jobs - Jobs You can do from Home", url: "http://telecommutejobs.biz/feed/"}, 
		{name: "Job Postings from Coroflot.com", url: "http://feeds.feedburner.com/coroflot/AllJobs"}, 
		{name: "Jobmote - Telecommute jobs", url: "http://jobmote.com/feed.rss"}, 
		{name: "Freelance Jobs", url: "http://www.freelancejobopenings.com/feeds/rss20"}, 
		{name: "Freelance jobs", url: "http://www.simplyhired.com/a/jobs/rss/q-freelance"}, 
		#{name: "Job offers from javascript.jobbersnet.com", url: "http://javascript.jobbersnet.com/rss/"}, 
		#{name: "Job offers from android.jobbersnet.com", url: "http://android.jobbersnet.com/rss/"}, 
		#{name: "Job offers from ios.jobbersnet.com", url: "http://ios.jobbersnet.com/rss/"}, 
		#{name: "Job offers from php.jobbersnet.com", url: "http://php.jobbersnet.com/rss/"}, 
		{name: "Latest jobs from Ruby on Rails Jobs", url: "http://www.rorjobs.com/a/jbb/find-jobs-rss"}
	])
end
