module JokesHelper
  def joke_author_count(jokes_author)
    jokes_author.jokes.where(:status => "displayed").count
  end  
  
  def jokes_by_author(jokes_author)
    jokes_author.jokes.order(:name)
  end
  
  def jokes_by_author_status(author)
    author.jokes.where(:status => "displayed").order(:name)
  end
end
