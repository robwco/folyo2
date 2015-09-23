class RssController < ApplicationController
  before_action :authenticate_admin!, except: [:upload]
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  def index
	#process_opml
	@rss_links = RssLink.visible.newest.most_recent
	@rss_count = @rss_links.count
  end

  def hide
	rss_link_id = params[:rss_link_id]

	rss_link = RssLink.find(rss_link_id)
	unless rss_link.blank?
		if rss_link.hide!
			flash[:undo] = "You have removed '#{rss_link.title}'. <a href=\"/rss/unhide?rss_link_id=#{rss_link.id}\">Undo</a>".html_safe
		end
			
	end

	redirect_to "/rss"
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

  def approve
	rss_link_id = params[:rss_link_id]

	rss_link = RssLink.find(rss_link_id)
	unless rss_link.blank?
		if rss_link.approve
			#flash[:undo] = "You have approved '#{rss_link.title}'. <a href=\"/rss/disapprove?rss_link_id=#{rss_link.id}\">Undo</a>".html_safe
			flash[:notice] = "You have approved '#{rss_link.title}'."
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
