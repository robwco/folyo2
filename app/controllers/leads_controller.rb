class LeadsController < ApplicationController
  before_action :authenticate, :set_lead, only: [:show, :edit, :update, :destroy]
  def index
    @leads = Lead.all
    @exclusives = Exclusive.all
  end

  def upload
    @leads = Lead.all
    @exclusives = Exclusive.all
  end

  def onboard
    @leads = Lead.all
    @exclusives = Exclusive.all
  end

  def upload_design
    @leads = Lead.all
    @exclusives = Exclusive.all
  end

  def upload_development
    @leads = Lead.all
    @exclusives = Exclusive.all
  end

  def show
  end

  def new
    @lead = Lead.new
  end

  def edit
  end

  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if @lead.save
        format.html { redirect_to @lead, notice: 'Lead was successfully created.' }
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
      params.require(:lead).permit(:photo, :title, :url, :name, :email, :website, :twitter, :linkedin, :budget, :notes, :category, :image)
    end
    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == "workshop" && password == "sbGfKA3A9xfd/jB"
      end
    end

end
