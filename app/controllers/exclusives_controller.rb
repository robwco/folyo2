class ExclusivesController < ApplicationController
  before_action :set_exclusive, only: [:show, :edit, :update, :destroy]

  # GET /exclusives
  # GET /exclusives.json
  def index
    @exclusives = Exclusive.all
  end

  # GET /exclusives/1
  # GET /exclusives/1.json
  def show
  end

  # GET /exclusives/connect
  def connect
    @exclusive = Exclusive.new
  end  # GET /exclusives/new

  def new
    @exclusive = Exclusive.new
  end

  # GET /exclusives/1/edit
  def edit
  end

  # POST /exclusives
  # POST /exclusives.json
  def create
    @exclusive = Exclusive.new(exclusive_params)

    respond_to do |format|
      if @exclusive.save
        format.html { redirect_to @exclusive, notice: 'Exclusive was successfully created.' }
        format.json { render :show, status: :created, location: @exclusive }
      else
        format.html { render :new }
        format.json { render json: @exclusive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exclusives/1
  # PATCH/PUT /exclusives/1.json
  def update
    respond_to do |format|
      if @exclusive.update(exclusive_params)
        format.html { redirect_to @exclusive, notice: 'Exclusive was successfully updated.' }
        format.json { render :show, status: :ok, location: @exclusive }
      else
        format.html { render :edit }
        format.json { render json: @exclusive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exclusives/1
  # DELETE /exclusives/1.json
  def destroy
    @exclusive.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Exclusive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exclusive
      @exclusive = Exclusive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exclusive_params
      params.require(:exclusive).permit(:title, :url, :name, :email, :website, :twitter, :linkedin, :budget, :category, :description, :notes, :pic)
    end
end
