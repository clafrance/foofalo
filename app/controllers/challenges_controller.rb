class ChallengesController < ApplicationController
  before_filter :signed_in_user 
  before_filter :admin_user,     :only => [:create, :new, :edit, :update, :destroy]
  
  def new
    @challenge = Challenge.new
    @focus ="autofocus"
  end
  
  def create
    @challenge = Challenge.new(params[:challenge])
    # @joke = current_user.jokes.build(params[:joke])
    # @joke.author = current_user.username
    if @challenge.save
      redirect_to @challenge, :success => "Challenge has been created."
    else
      render 'new'
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    if @challenge.status == 1
      @display_status = "It hasn't been published." 
    else
      @display_status = "It has been solved."
    end
  end

  def index
    @challenges = Challenge.find(:all)
  end
  
  def edit
    @challenge = Challenge.find(params[:id])
  end
  
  def update
    @challenge = Challenge.find(params[:id])
    if @challenge.update_attributes(params[:challenge])
      flash[:success] = "Challenge has been Updated"
      redirect_to @challenge
    else
      render 'edit'
    end
  end
  
  def destroy
    challenge = Challenge.find(params[:id])
    challenge.destroy
    flash[:success] = "Challenge #{challenge.name} has been deleted."
    redirect_to challenges_path
  end
end
