require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(1.day, 'Queueing daily leads email', :at => '12:00') { Delayed::Job.enqueue DailyLeadsJob.new }
every(15.minutes, 'Loading new RSS leads') { Delayed::Job.enqueue ProcessRssFeeds.new }
