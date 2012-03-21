class JokesController < ApplicationController
  before_filter :signed_in_user 
  #before_filter :correct_user,   :only => [:edit, :update]
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
    @jokes_by_date = Joke.where(:status => 1).order("#{:created_at} DESC, #{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
    @jokes_by_author = Joke.where(:status => 1).order("#{:created_at} DESC, #{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    @joke = Joke.find(params[:id])
    if @joke.status == 1
      @display_status = "Published" 
    else
      @display_status = "Being reviewed"
    end
  end
  
  def my_jokes
    @jokes = Joke.where(:author => current_user.username, :status => 1).order("#{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def jokes_author
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:author => @current_joke.author, :status => 1).order("#{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def jokes_date
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:status => 1, :created_at => @current_joke.created_at.beginning_of_day..@current_joke.created_at.end_of_day).order("#{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def jokes_by_authors
    # @jokes_all = Joke.where(:status => 1).order("#{:name}").paginate(:page => params[:page], :per_page => 20)
    # @jokes = @jokas_all.group_by {:author}  
    #@authors = Joke.find_(:author)
    @authors = Joke.select("DISTINCT(author)").order(:author).map(&:author)
#jokes_by_author = @author.jokes
  end
  
  def jokes_by_dates
    @dates = Joke.select("DISTINCT(created_at.beginning_of_day)").map(&:created_at)
    #@jokes = Joke.where(:status => 1).order("#{:created_at} DESC, #{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def edit
    @user = current_user
    @joke = Joke.find(params[:id])
  end
  
  def update
    @joke = Joke.find(params[:id])
    if @joke.author == current_user.username
      if @joke.update_attributes(params[:joke])
        flash[:success] = "Joke has been Updated"
        redirect_to @joke
      else
        render 'edit'
      end
    else
      redirect_to root_url, :Notice => "You can only edit your jokes."
    end
  end
  
  def destroy
    
  end

end
