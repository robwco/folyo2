require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

class ProcessRssFeeds
	def perform
		RssFeed.all.each do |feed|
			#test_feed(feed)
			process_feed(feed)
		end
		""
	end

	def test_feed(rss_feed)
		begin
			content = ""
			open(rss_feed.xml_url,{ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}) do |s| content = s.read end
		rescue Exception => e
			puts "#{rss_feed.xml_url}   #{e.message} \n"
		end
	end

	def process_feed(rss_feed)
		max_pub_date = nil

		begin
			content = ""
			open(rss_feed.xml_url) do |s| content = s.read end
			rss = RSS::Parser.parse(content, false)

			rss.items.each do |i|
				guid = i.guid.content
				if RssLink.where(:guid => guid).count == 0

					rss_link = RssLink.new

					rss_link.title = i.title
					rss_link.link = i.link
					rss_link.description = i.description
					rss_link.pub_date = i.pubDate
					rss_link.guid = guid
					rss_link.rss_feed_id = rss_feed.id

					if rss_link.save
						max_pub_date = [max_pub_date || i.pubDate, i.pubDate].max
					end
				end

				rss_feed.updated(max_pub_date) unless max_pub_date.nil?
			end
		rescue Exception => e
			puts "#{rss_feed.xml_url}   #{e.message} \n"
		end
	end	
end
