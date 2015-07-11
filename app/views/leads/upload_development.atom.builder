atom_feed do |feed|
  feed.title "Workshop Development Leads"
  feed.updated @leads.maximum(:updated_at)
  @leads.most_recent.take(1).each do |lead|
    feed.entry lead do |entry|
      entry.title do |title|
        entry.title "Meet #{lead.name} who's looking for #{lead.title}…"
      end
      entry.author do |author|
  	  	author.name lead.name
  	  end
      entry.content render :partial => 'lead_render_development.atom.erb', :type => 'html'
    end
  end
end

