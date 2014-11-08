atom_feed do |feed|
  feed.title "Workshop Leads"
  @leads.each do |lead|
    feed.entry lead do |entry|
      entry.content render :partial => 'lead_render.html.erb'
    end
  end
end

