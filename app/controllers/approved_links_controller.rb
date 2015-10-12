class ApprovedLinksController < ApplicationController
  before_action :authenticate_admin!

  def index
	#process_opml
	@approved_links = ApprovedLink.visible.most_recent
	@rss_count = RssLink.visible.newest.most_recent.count
  end

  def hide
	approved_link_id = params[:approved_link_id]

	approved_link = ApprovedLink.find(approved_link_id)
	unless approved_link.blank?
		if approved_link.hide!
			flash[:undo] = "You have removed '#{approved_link.title}'. <a href=\"/approved_links/unhide?approved_link_id=#{approved_link.id}\">Undo</a>".html_safe
		end
			
	end

	redirect_to "/approved_links"
  end

  def unhide
	rss_link_id = params[:rss_link_id]

	rss_link = RssLink.find(rss_link_id)
	unless rss_link.blank?
		if rss_link.show!
			flash[:undo] = "You have re-added '#{rss_link.title}'. <a href=\"/rss/hide?rss_link_id=#{rss_link.id}\">Undo</a>".html_safe
		end
			
	end

	redirect_to "/rss"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end
    def change
      add_column :images, :image_file_name, :string
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
      params.require(:lead).permit(:photo, :title, :url, :name, :email, :website, :twitter, :linkedin, :budget, :notes, :category, :image, :category_id)
    end
    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == "workshop" && password == "sbGfKA3A9xfd/jB"
    end
  end

end
