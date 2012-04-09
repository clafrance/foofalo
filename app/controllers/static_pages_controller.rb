class StaticPagesController < ApplicationController
  def home
  end
  
  def about
    
  end
  
  def terms
    
  end
  
  def index
    @the_random_challenge = random_challenge
    @the_random_fun_fact = random_fun_fact
    @the_random_joke = random_joke
    #@my_links = Link.find(:all, :order => :name)
  end
  # 
  # def submit_answer
  #   
  #   @challenge.id = params[@the_random_challenge_ids]
  #   flash[:success] = "You have selected an answer for #{@challenge.id}"
  #   redirect_to index_url
  #   
  #   #flash[:notice] = "got it #{id.length}"
  #   # if !params[@the_random_challenge_ids].nil?
  #   #   @challenge.id = params[@the_random_challenge_ids]
  #     #id = params[:answer_id]
  #     # if id.length > 1
  #     #   flash[:notice] = "You can not select more than one answer."
  #     #   redirect_to index_url
  #     # else
  #       # @challenge = @the_ramdom_challenge
  #       # @answer = @challenge.answers.build(params[:answer])
  #       # flash[:success] = "You have selected an answer for #{@challenge.id}"
  #       #       redirect_to index_url
  #   #   end
  #   # else
  #   #   flash[:success] = "You have to selected one answer"
  #   #   redirect_to index_url
  #   #end
  # end
      
    #redirect_to index_url
    # @answer = @the_ramdom_challenge.answers.build(params[:answer])
    # @answer.challenge_name = @the_ramdom_challenge.name
    # @answer.user_id = current_user.id
    # @answer.answer_selected =
    # @answer.answer_col_selected =
    # @answer.reason =
    # if  
    #   @answer.correct = "yes"
    # else
    #   @answer.correct = "no"
    # end
    # 
    # #Answer.update_all(["challenge_name=?", @challenge.name], ["answer_selected=?", @challenge])    
    # 
    # if @answer.save
    #   flash[:success] = "Congrulation! You are correct"
    #   redirect_to index_url
    # else
    #   flash[:notice] = "You didn't get the correct answer, please try again."
    #   redirect_to index_url
    # end    
  
end
