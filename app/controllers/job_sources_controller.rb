class JobSourcesController < ApplicationController
  before_action :set_job_source, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @job_sources = JobSource.all
    respond_with(@job_sources)
  end

  def show
    respond_with(@job_source)
  end

  def new
    @job_source = JobSource.new
    respond_with(@job_source)
  end

  def edit
  end

  def create
    @job_source = JobSource.new(job_source_params)
    @job_source.save
    respond_with(@job_source)
  end

  def update
    @job_source.update(job_source_params)
    respond_with(@job_source)
  end

  def destroy
    @job_source.destroy
    respond_with(@job_source)
  end

  private
    def set_job_source
      @job_source = JobSource.find(params[:id])
    end

    def job_source_params
      params.require(:job_source).permit(:name, :url)
    end
end
