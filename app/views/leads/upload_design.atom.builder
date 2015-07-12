atom_feed do |feed|
  feed.title "Workshop Design Leads"
  feed.updated @leads.maximum(:updated_at)
  @leads.most_recent.take(1).each do |lead|
    feed.entry lead do |entry|
      entry.title do |title|
        if @exclusives.this_week.exists? 
          then entry.title "Meet #{exclusive.name} who's looking for #{exclusive.title}…" 
          else entry.title "Meet #{lead.name} who's looking for #{lead.title}…" 
        end
      end	  
      entry.author do |author|
  	  	author.name lead.name
  	  end
      entry.content render :partial => 'lead_render_design.atom.erb', :type => 'html'
    end
  end
end

