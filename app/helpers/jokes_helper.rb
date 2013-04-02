module JokesHelper
  def joke_author_count(jokes_author)
    # jokes_author.jokes.where(:status => "displayed").count
    jokes_author.jokes.where('status = :display_status', :display_status => "displayed").count
  end  
  
  def jokes_by_author(jokes_author)
    jokes_author.jokes.order(:name)
  end
  
  def jokes_by_author_status(jokes_author, status)
    jokes_author.jokes.where('status = :display_status', :display_status => status).order(:name)
    # jokes_author.jokes.where(:status => status).order(:name)
  end
  
  def jokes_entered_by_user(username)
    jokes_by_user = Joke.where('author = :the_author', :the_author => username).count
    # jokes_by_user = Joke.where(:author => username).count
  end
end
