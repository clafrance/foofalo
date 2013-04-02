class JokesController < ApplicationController
  before_filter :signed_in_user 
  #before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     only: [:destroy, :review, :unapprove]
  
  def new
    @joke = Joke.new
    @focus ="autofocus"
  end
  
  def create
    @joke = current_user.jokes.build(params[:joke])
    @joke.author = current_user.username
    if @joke.save
      flash[:success] = "Joke has been created. It will be published after approved."
      redirect_to myjokes_url
    else
      render 'new'
    end
  end
  
  def index
    @unreviewed_jokes = Joke.where('status = :review_status', :review_status => "reviewing").order("#{:created_at}")
    @unapproved_jokes = Joke.where('status = :review_status', :review_status => "unapproved").order("#{:created_at}")
    @jokes_displayed = Joke.where('status = :review_status', :review_status => "displayed").order("#{:created_at} DESC, #{:author}, #{:name}")
    @jokes = Joke.where('status = :review_status', :review_status => "approved").order("#{:created_at} DESC, #{:author}, #{:name}")
    @display_joke = DisplayObject.where('obj_type = :display_obj', :display_obj => "joke")
    # @unreviewed_jokes = Joke.where(:status => "reviewing").order("#{:created_at}")
    # @unapproved_jokes = Joke.where(:status => "unapproved").order("#{:created_at}")
    # @jokes_displayed = Joke.where(:status => "displayed").order("#{:created_at} DESC, #{:author}, #{:name}")
    # @jokes = Joke.where(:status => "approved").order("#{:created_at} DESC, #{:author}, #{:name}")
    # @display_joke = DisplayObject.where(:obj_type => "joke")
    @total_jokes_count = Joke.count
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
    @jokes_approved = current_user.jokes.where('status = :review_status', :review_status => "approved").order("#{:name}")
    @jokes_unapproved = current_user.jokes.where('status = :review_status', :review_status => "unapproved").order("#{:name}")
    @jokes_review = current_user.jokes.where('status = :review_status', :review_status => "reviewing").order("#{:name}")
    @jokes_displayed = current_user.jokes.where('status = :review_status', :review_status => "displayed").order("#{:name}")
    @jokes = current_user.jokes.order("#{:name}")
    
    # @jokes_approved = current_user.jokes.where(:status => "approved").order("#{:name}")
    # @jokes_unapproved = current_user.jokes.where(:status => "unapproved").order("#{:name}")
    # @jokes_review = current_user.jokes.where(:status => "reviewing").order("#{:name}")
    # @jokes_displayed = current_user.jokes.where(:status => "displayed").order("#{:name}")
    # @jokes = current_user.jokes.order("#{:name}")
    # @display_joke = DisplayObject.where(:obj_type => "joke")
  end
  
  def jokes_author
    @current_joke = Joke.find(params[:joke])
    @author = User.where("id=?", @current_joke.user_id)[0]
  end
  
  def jokes_date
    @current_joke = Joke.find(params[:joke])
    @jokes = Joke.where(:status => "displayed", :created_at => beginning_of_day(@current_joke)..end_of_day(@current_joke)).order("#{:author}, #{:name}")
    @jokes_all = Joke.where(:created_at => beginning_of_day(@current_joke)..end_of_day(@current_joke)).order("#{:author}, #{:name}")
  end
  
  def jokes_by_authors
    @authors = []
    (Joke.select(:author).uniq).each do |a|
      @authors << User.find_by_username(a.author)
    end
    return @authors
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
  
  def destroy
    @display_joke = DisplayObject.where(:obj_type => "joke")
    joke = Joke.find(params[:id])
    if joke.id != @display_joke[0].obj_id
      joke.destroy
      flash[:success] = "Joke #{joke.name} has been deleted."
      redirect_to jokes_path
    else
      flash[:notice] = "Can't delete the joke, it is displayed in the Home page."
      redirect_to jokes_path
    end
  end
  
  private
  
end
