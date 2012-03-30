class AnswersController < ApplicationController

  before_filter :signed_in_user 
  before_filter :admin_user,     :only => [:create, :new, :edit, :update, :destroy]
  before_filter :load_challenge
  

  def new
    @answer = @challenge.answers.build(params[:answer])
  end

  def create
    @answer = @challenge.answers.build(params[:answer])
    if @answer.save
      flash[:notice] = "Answer created"
      #redirect_to @challenge
    else
      flash[:notice] = "Unable to create answer"
      redirect_to @challenge
    end
  end

  
  def edit
  end

  def update
  end
  
  private
  
    def load_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end
    
    # def button_click_counter(self.counter=0, challenge)
    #   if @challenge
    #   self.counter = self.counter + 1
    #   
    # end
end
