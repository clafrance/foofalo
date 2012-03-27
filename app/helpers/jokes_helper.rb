module JokesHelper
  
  def random_joke
      stored_joke = DisplayObject.where(:obj_type => "joke").first
      stored_date = stored_joke.updated_at.beginning_of_day
      current_date = Time.now().beginning_of_day

    # Change stored_joke to a new random joke
    if current_date > stored_date
      # random_joke_ids = Joke.find(:all, :select => "id", :conditions => ["status=?", 1]).map(&:id).shuffle
      random_joke_id = Joke.find(:all, :select => "id", :conditions => ["status=?", 1]).map(&:id).shuffle.first
      random_joke = Joke.find_by_id(random_joke_id)
      stored_joke.obj_id = random_joke.id
      random_joke.status = 2
      random_joke.save
      stored_joke.save
    end
    
    if random_joke.nil?
      display_joke = Joke.where(:id => stored_joke.obj_id).first
    else
      random_joke
    end
  end
end
