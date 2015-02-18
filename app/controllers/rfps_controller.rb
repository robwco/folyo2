class RfpsController < ApplicationController
  before_action :set_rfp, only: [:show, :edit, :update, :destroy]

  # GET /rfps
  # GET /rfps.json
  def index
    @rfps = Rfp.all
  end

  # GET /rfps/1
  # GET /rfps/1.json
  def show
  end

  # GET /rfps/new
  def new
    @rfp = Rfp.new
  end

  # GET /rfps/1/edit
  def edit
  end

  # POST /rfps
  # POST /rfps.json
  def create
    @rfp = Rfp.new(rfp_params)

    respond_to do |format|
      if @rfp.save
        format.html { redirect_to @rfp, notice: 'Rfp was successfully created.' }
        format.json { render :show, status: :created, location: @rfp }
      else
        format.html { render :new }
        format.json { render json: @rfp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rfps/1
  # PATCH/PUT /rfps/1.json
  def update
    respond_to do |format|
      if @rfp.update(rfp_params)
        format.html { redirect_to @rfp, notice: 'Rfp was successfully updated.' }
        format.json { render :show, status: :ok, location: @rfp }
      else
        format.html { render :edit }
        format.json { render json: @rfp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rfps/1
  # DELETE /rfps/1.json
  def destroy
    @rfp.destroy
    respond_to do |format|
      format.html { redirect_to rfps_url, notice: 'Rfp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rfp
      @rfp = Rfp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rfp_params
      params.require(:rfp).permit(:name, :file)
    end
end
