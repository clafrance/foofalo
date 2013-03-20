class LinksController < ApplicationController
  
  before_filter :signed_in_user
  #before_filter :correct_user, :only => [ :index, :edit, :update, :destroy ]
  
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
    if @link.save
      flash[:success] = "Link has been created."
      redirect_to links_path
    else
      render 'new'
    end
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def update
    @link = Link.find(params[:id])
    if @link.user_id == current_user.id
      if @link.update_attributes(params[:link])
        flash[:success] = "Link has been Updated"
        redirect_to links_path
      else
        render 'edit'
      end
    else
      redirect_to root_url, :Notice => "You can only edit your links."
    end
  end
  
  def manage_links
    
  end
  
  def destroy
    link = Link.find(params[:id])
    if link.user_id == current_user.id
      link.destroy
      flash[:success] = "Link #{link.name} has been deleted."
      redirect_to managelinks_path
    else
      redirect_to managelinks_path, :notice => "You can only delete your links."
    end
  end
end
