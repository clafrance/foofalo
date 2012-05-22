module JokesHelper
  def joke_author_count(author)
    Joke.where(:author => author, :status => "displayed").count
  end  
  
  def jokes_by_author(author)
    # Joke.find(:all, :conditions => ["author=?", theauthor]) 
    Joke.find(:all, :conditions => ["author = ?", author], :order => "name") 
  end
  
  def jokes_by_author_status(author, status)
    # Joke.find(:all, :conditions => ["author=?", theauthor]) 
    Joke.find(:all, :conditions => ["author = ? and status = ?", author, status], :order => "name") 
  end
end
