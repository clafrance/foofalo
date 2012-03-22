class LinksController < ApplicationController
  
  before_filter :signed_in_user
  
  def index
    @categories = Link.categories
    #@links = Link.where(:user_id => current_user.id, :category => category).order(:name)
    #@catogories = Link.select("DISTINCT(author)").order(:author).map(&:author)
    #@links = Link.where(:user_id => current_user.id).order("#{:name}").paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @link = Link.new
    @focus ="autofocus"
  end

  def create
    @link = current_user.links.build(params[:link])
    #@link = Link.new(params[:link])
    if @link.save
      redirect_to links_path, :success => "Link has been saved."
    else
      render 'new'
    end
  end
  
  def edit
  end
end
