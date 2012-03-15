class JokesController < ApplicationController
  def new
    @joke = Joke.new
    @focus ="autofocus"
  end
  
  def create
    @joke = Joke.new(params[:joke])
    @joke.author = current_user
    if @joke.save
      redirect_to @joke
    else
      render 'new'
    end
  end
  
  def index
   @jokes = Joke.where(:status != 0).order("#{:created_at} DESC, #{:author}, #{:name}")
  end
  
  def jokes_by_author
    @title = "jokes_by_author"
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:author => @current_joke.author, :status => 1).order("#{:created_at} DESC, #{:name}")
  end
  
  def jokes_by_date
    @title = "jokes_by_date"
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:status => 1, :created_at => @current_joke.created_at.beginning_of_day..@current_joke.created_at.end_of_day).order("#{:author}, #{:name}")
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
  
  def show_mine
    @title = "show_my_jokes"
  end
  
  def edit
    @title = "edit_joke"
  end

end
