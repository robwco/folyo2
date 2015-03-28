class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @people = current_user.people.all
    else
      redirect_to new_user_session_url
    end
  end

  def show
  end

  def new
    @person = current_user.people.build
  end

  def edit
  end

  def create
    @person = current_user.people.build(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end
    
    def correct_user
      @person = current_user.people.find_by(id: params[:id])
      redirect_to people_path if @person.nil?
    end

    def person_params
      params.require(:person).permit(:name)
    end
end
