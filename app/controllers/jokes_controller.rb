class JokesController < ApplicationController
  before_filter :signed_in_user 
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def new
    @joke = Joke.new
    @focus ="autofocus"
  end
  
  def create
    # @joke = Joke.new(params[:joke])
    # @joke.user_id = current_user.id
    @joke = current_user.jokes.build(params[:joke])
    @joke.author = current_user.username
    if @joke.save
      redirect_to @joke, :success => "Joke has been created. It will be published after it is approved."
    else
      render 'new'
    end
  end
  
  def index
    @jokes = Joke.where(:status => 1).order("#{:created_at} DESC, #{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    @title = "show_joke"
    @joke = Joke.find(params[:id])
    if @joke.status == 1
      @display_status = "Published" 
    else
      @display_status = "Being reviewed"
    end
  end
  
  def my_jokes
    @jokes = Joke.find_by_author(params[:current_user.username]) 
  end
  
  def jokes_by_author
    @title = "jokes_by_author"
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:author => @current_joke.author, :status => 1).order("#{:created_at} DESC, #{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def jokes_by_date
    @title = "jokes_by_date"
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:status => 1, :created_at => @current_joke.created_at.beginning_of_day..@current_joke.created_at.end_of_day).order("#{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def edit
    @jokes = Joke.find_by_author(params[:current_user.username]) 
    @title = "edit_joke"
  end
  
  def update
  end
  
  def destroy
    
  end

end
