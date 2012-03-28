module JokesHelper
  # 
  # def random_joke
  #   stored_joke = DisplayObject.where(:obj_type => "joke").first
  #   stored_date = stored_joke.updated_at.strftime("%Y-%m-%d")
  #   current_date = Time.now().strftime("%Y-%m-%d")
  #   if stored_joke.obj_id.nil? 
  #     random_joke_id = Joke.find(:all, :select => "id", :conditions => ["status=?", 1]).map(&:id).shuffle.first
  #     the_random_joke = Joke.find_by_id(random_joke_id)
  #     the_random_joke.status = 3
  #     the_random_joke.message = "Displayed"
  #     the_random_joke.save
  #     stored_joke.obj_id = the_random_joke.id
  #     stored_joke.save
  #     the_random_joke        
  #   elsif current_date > stored_date
  #     random_joke_id = Joke.find(:all, :select => "id", :conditions => ["status=?", 1]).map(&:id).shuffle.first
  #     the_random_joke = Joke.find_by_id(random_joke_id)
  #     the_random_joke.status = 3
  #     the_random_joke.message = "Displayed"
  #     the_random_joke.save
  #     stored_joke.obj_id = the_random_joke.id
  #     stored_joke.save
  #     the_random_joke
  #   else
  #     stored_joke
  #   end
  # end  
end
