module LinksHelper
  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
  
  def display_links
    @my_links = Link.find(:all, :order => :name)  
  end
end
