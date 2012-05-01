class JokesController < ApplicationController
  before_filter :signed_in_user 
  #before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     only: [:destroy, :review, :unapprove]
  
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
      redirect_to index_url, :success => "Joke has been created. It will be published after it is approved."
      # redirect_to @joke, :success => "Joke has been created. It will be published after it is approved."
    else
      render 'new'
    end
  end
  
  def index
    @unreviewed_jokes = Joke.where(:status => "reviewing").order("#{:created_at}")
    @unapproved_jokes = Joke.where(:status => "unapproved").order("#{:created_at}")
    @jokes = Joke.where(:status => "approved").order("#{:created_at} DESC, #{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
    #@jokes_by_date = Joke.where(:status => 1).order("#{:created_at} DESC, #{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
    #@jokes_by_author = Joke.where(:status => 1).order("#{:created_at} DESC, #{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    @joke = Joke.find(params[:id])
    if @joke.status == "approved"
      @display_status = "Published" 
    else
      @display_status = "Being reviewed"
    end
  end
  
  def my_jokes
    @jokes_approved = Joke.where(:author => current_user.username, :status => "approved").order("#{:name}").paginate(:page => params[:page], :per_page => 20)
    @jokes_unapproved = Joke.where(:author => current_user.username, :status => "unapproved").order("#{:name}").paginate(:page => params[:page], :per_page => 20)
    @jokes_review = Joke.where(:author => current_user.username, :status => "reviewing").order("#{:name}").paginate(:page => params[:page], :per_page => 20)
    @jokes = Joke.where(:author => current_user.username).order("#{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def jokes_author
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:author => @current_joke.author, :status => "approved").order("#{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def jokes_date
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:status => "approved", :created_at => @current_joke.created_at.beginning_of_day..@current_joke.created_at.end_of_day).order("#{:author}, #{:name}").paginate(:page => params[:page], :per_page => 20)
  end
  
  def jokes_by_authors
    @authors = Joke.select("DISTINCT(author)").order(:author).map(&:author) 
  end
  
  def edit
    @user = current_user
    @joke = Joke.find(params[:id])
  end
  
  def update
    @joke = Joke.find(params[:id])
    if @joke.author == current_user.username
      if @joke.update_attributes(params[:joke])
        @joke.status = "reviewing"
        @joke.message = "Needs to be reviewed again"
        @joke.save
        flash[:success] = "Joke has been Updated"
        redirect_to @joke
      else
        render 'edit'
      end
    else
      redirect_to root_url, :Notice => "You can only edit your own jokes."
    end
  end
  
  def review_jokes
    if params[:commit] == 'Approve'
      Joke.update_all(["status=?", "approved"], :id => params[:joke_ids])
      Joke.update_all(["message=?", "approved"], :id => params[:joke_ids])
      redirect_to jokes_path
    elsif params[:commit] == 'Unapprove'
      Joke.update_all(["status=?", "unapproved"], :id => params[:joke_ids])
      Joke.update_all(["message=?", "unapproved"], :id => params[:joke_ids])
      Joke.update_all(["message=?", "Please update the joke with proper language or content."], :id => params[:joke_id])
      redirect_to jokes_path     
    end
  end
  
  def review_joke
    if params[:commit] == 'Approve'
      Joke.update_all(["status=?", "approved"], :id => params[:joke_id])
      Joke.update_all(["message=?", "approved"], :id => params[:joke_id])
      redirect_to jokes_path
    elsif params[:commit] == 'Unapprove'
      Joke.update_all(["status=?", "unapproved"], :id => params[:joke_id])
      Joke.update_all(["message=?", "unapproved"], :id => params[:joke_id])
      Joke.update_all(["message=?", "Please update the joke with proper language or content."], :id => params[:joke_id])
      redirect_to jokes_path     
    end
  end
  
  # def review
  #   Joke.update_all(["status=?", "approved"], :id => params[:joke_ids])
  #   Joke.update_all(["message=?", "approved"], :id => params[:joke_ids])
  #   redirect_to jokes_path
  # end
  # 
  # def unapprove
  #   joke_id = params[:joke_id]
  #   Joke.update_all(["status=?", "unapproved"], :id => params[:joke_id])
  #   Joke.update_all(["message=?", "Please update the joke with proper language or content."], :id => params[:joke_id])
  #   redirect_to jokes_path
  # end  
  
  def destroy
    joke = Joke.find(params[:id])
    joke.destroy
    flash[:success] = "Joke #{joke.name} has been deleted."
    redirect_to jokes_path
  end

end
