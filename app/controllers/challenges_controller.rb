class ChallengesController < ApplicationController
  before_filter :signed_in_user 
  before_filter :admin_user,     :only => [:create, :new, :edit, :update, :destroy]
  # before_filter :already_answered?
  
  def new
    @challenge = Challenge.new
    @focus ="autofocus"
  end
  
  def create
    @challenge = current_user.challenges.build(params[:challenge])
    @challenge.author = current_user.username
    if @challenge.save
      id = @challenge.id
      col_name = @challenge.correct_col_name
      correct_answer = Challenge.find(:all, :select => "#{@challenge.correct_col_name}", :conditions => ["id=?", @challenge.id])
      @challenge.correct_answer = correct_answer[0][col_name]
      if @challenge.save
        flash[:success] = "Challenge has been created."
        redirect_to @challenge
      else
        render 'new'
      end
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
  
  
  def submit_answer
    challenge_id = params[:challenge_id]
    
    # check_answer = Answer.where(:user_id => current_user.id, :challenge_id => challenge_id)    

    if params[:answer].nil?
      flash[:success] = "You have to selected one answer"
      redirect_to index_url
    else
      answer = params[:answer]
      if answer.length > 1
        flash[:notice] = "You can not select more than one answer."
        redirect_to index_url
      else
        @challenge = Challenge.find_by_id(challenge_id)
        @answer = @challenge.answers.build(params[:answers])
        @answer.challenge_name = @challenge.name
        @answer.user_id = current_user.id
        @answer.answer_selected = answer[0]
        @answer.reason = params[:reason][0]
        case
        when answer[0] == @challenge.a
          @answer.answer_col_selected = "a"
        when answer[0] == @challenge.b
          @answer.answer_col_selected = "b"
        when answer[0] == @challenge.c
          @answer.answer_col_selected = "c"
        when answer[0] == @challenge.d
          @answer.answer_col_selected = "c"
        end
    
        if @challenge.correct_col_name == @answer.answer_col_selected && @challenge.correct_answer == answer[0]
          @answer.correct = "yes"
        else
          @answer.correct = "no"
        end
        @answer.save

        if @answer.correct == "yes"
          flash[:success] = "Congulation! You have selected correct answer: #{@answer.answer_col_selected}, #{@answer.answer_selected}"
          redirect_to index_url
        else
          flash[:notice] = "Sorry. The correct answer is #{@challenge.correct_col_name}, #{@challenge.correct_answer}."
          redirect_to index_url
        end
      end
    end

  end
      
  
end
