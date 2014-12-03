atom_feed do |feed|
  feed.title "Workshop Design Leads"
  feed.updated @leads.maximum(:updated_at)
  @leads.most_recent.take(1).each do |lead|
    feed.entry lead do |entry|
      if @exclusives.today.exists? then entry.title Time.now.strftime("Latest Gigs %d %B %Y **exclusive lead inside**") else entry.title Time.now.strftime("Latest Gigs %d %B %Y") end
  	  entry.author do |author|
  	  	author.name lead.name
  	  end
      entry.content render :partial => 'lead_render_design.atom.erb', :type => 'html'
    end
  end
end

