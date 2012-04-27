module LinksHelper
  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
  
  def display_links
    # @my_links = Link.find(:all, :order => :name)
   
    @my_links = Link.where(:user_id => current_user.id).order(:name)  
  end
end
