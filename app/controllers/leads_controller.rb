class LeadsController < ApplicationController
  before_action :authenticate_admin!, except: [:upload, :index, :favorites, :favorite, :contacted, :need_to_email, :responded, :touch_base]
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_any!, only: [:index, :favorites, :contacted, :need_to_email, :responded, :touch_base]

    
  # Add and remove favorite lead
  # for current_user
  def favorite
    type = params[:type]
    if type == "favorite"
      @lead = Lead.find(params[:id])
      current_user.favorites << @lead unless current_user.favorites.exists?(@lead)
      redirect_to :favorites, notice: 'Added to Favorites!'
    
    elsif type == "unfavorite"
      @lead = Lead.find(params[:id])
      current_user.favorites.delete(@lead)
      redirect_to :back, notice: 'Removed from Favorites'

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

  def responded
    #render plain: "HERE HERE" and return
    @lead = current_user.favorite_leads.where(lead_id: params[:id]).first
    @lead.move_to_in_conversation! 
    redirect_to :favorites, notice: "Added lead to In Conversation!"
  end

  def contacted
    #render plain: "HERE HERE" and return
    @lead = current_user.favorite_leads.where(lead_id: params[:id]).first
    @lead.move_to_waiting_to_hear_back! 
    redirect_to :favorites, notice: "Added lead to Waiting to Hear Back!"
  end

  def need_to_email
    #render plain: "HERE HERE" and return
    @lead = current_user.favorite_leads.where(lead_id: params[:id]).first
    @lead.move_to_to_contact! 
    redirect_to :favorites, notice: "Added lead to To Contact!"
  end

  def touch_base
    #render plain: "HERE HERE" and return
    @lead = current_user.favorite_leads.where(lead_id: params[:id]).first
    @lead.move_to_staying_in_touch! 
    redirect_to :favorites, notice: "Added lead to Staying In Touch!"
  end

  def index
    @leads = Lead.includes(:category).limit(20).all unless params[:advanced].present?
    @leads = Lead.includes(:category)
		.keyword(params[:keyword]).with_category(params[:category_ids]).after(params[:after])
	    .paginate(:page => params[:page], :per_page => 10) if params[:advanced].present?
    
	  @favorites = current_user.favorites.where(id: @leads.all) if user_signed_in?
    
    @exclusives = Exclusive.all
  	#@approved_links = ApprovedLink.visible.most_recent
  	#@rss_count = RssLink.visible.newest.most_recent.count
    @lead = Lead.new
  end

  def all
    @leads = Lead.all
    @exclusives = Exclusive.all
  end
  
  def favorites
    #@leads = Lead.all
  end
  
  def upload
    @leads = Lead.all
    @exclusives = Exclusive.all
    render layout: false
  end

  def onboard
    @leads = Lead.all
    @exclusives = Exclusive.all
  end

  def upload_design
    @leads = Lead.all
    @exclusives = Exclusive.all
    render layout: false
  end

  def upload_development
    @leads = Lead.all
    @exclusives = Exclusive.all
    render layout: false
  end

  def show
  end

  def new
    @lead = Lead.new

	unless params[:approved_link_id].nil?
		@approved_lead = ApprovedLink.find(params[:approved_link_id])

		@lead.title = @approved_lead.title
		@lead.url = @approved_lead.link	
	end
  end

  def edit
  end

  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if @lead.save
		unless params[:approved_link_id].nil?
			approved_lead = ApprovedLink.find(params[:approved_link_id])
			approved_lead.hide!

			format.html { redirect_to "/approved_links", notice: 'Lead was successfully created.' }
		else
			format.html { redirect_to @lead, notice: 'Lead was successfully created.' }
		end
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Lead was successfully destroyed.' }
      format.json { head :no_content }
    end
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
      params.require(:lead).permit(:photo, :title, :url, :name, :email, :website, :twitter, :linkedin, :budget, :notes, :category, :image, :category_id, :description)
    end
    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == "workshop" && password == "sbGfKA3A9xfd/jB"
    end
  end

end
