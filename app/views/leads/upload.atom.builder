atom_feed do |feed|
  feed.title "Workshop Leads"
  feed.updated @leads.maximum(:updated_at)
  @leads.take(1).each do |lead|
    feed.entry lead do |entry|
  	  entry.title lead.title
  	  entry.author do |author|
  	  	author.name lead.name
  	  end
      entry.content render :partial => 'lead_render.atom.erb', :type => 'html'
    end
  end
end

