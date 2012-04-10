module StaticPagesHelper
  def random_joke
    displayed_joke = DisplayObject.where(:obj_type => "joke").first
    displayed_date = displayed_joke.updated_at.strftime("%Y-%m-%d")
    current_date = Time.now().strftime("%Y-%m-%d")
    random_joke_id = Joke.find(:all, :select => "id", :conditions => ["status=?", 1]).map(&:id).shuffle.first
    if !random_joke_id.nil?
      if displayed_joke.obj_id.nil? || (current_date > displayed_date)
        the_random_joke = Joke.find_by_id(random_joke_id)
        the_random_joke.status = 3
        the_random_joke.message = "Displayed"
        the_random_joke.save
        displayed_joke.obj_id = the_random_joke.id
        displayed_joke.save
        the_random_joke        
      else
        joke = Joke.find_by_id(displayed_joke.obj_id)
      end
    elsif displayed_joke.obj_id.nil? || ((Date.parse(current_date) - Date.parse(displayed_date)) > 7)
      id = Joke.find(:all, :select => "id", :conditions => ["status=?", 3]).map(&:id).shuffle.first
      displayed_joke.obj_id = id
      displayed_joke.save 
      the_random_joke = Joke.find_by_id(id)     
    else 
      joke = Joke.find_by_id(displayed_joke.obj_id)
    end
  end
  
  def random_challenge
    displayed_challenge = DisplayObject.where(:obj_type => "challenge").first
    displayed_date = displayed_challenge.updated_at.strftime("%Y-%m-%d")
    current_date = Time.now().strftime("%Y-%m-%d")
    random_challenge_id = Challenge.find(:all, :select => "id", :conditions => ["status=?", 1]).map(&:id).shuffle.first
    if !random_challenge_id.nil?
      if displayed_challenge.obj_id.nil? || ((Date.parse(current_date) - Date.parse(displayed_date)) > 7)
        the_random_challenge = Challenge.find_by_id(random_challenge_id)
        the_random_challenge.status = 3
        the_random_challenge.save
        displayed_challenge.obj_id = the_random_challenge.id
        displayed_challenge.save
        the_random_challenge       
      else 
        challenge = Challenge.find_by_id(displayed_challenge.obj_id)
      end
    elsif displayed_challenge.obj_id.nil? || ((Date.parse(current_date) - Date.parse(displayed_date)) > 7)
      id = Challenge.find(:all, :select => "id").map(&:id).shuffle.first
      displayed_challenge.obj_id = id
      displayed_challenge.save
      the_random_challenge = Challenge.find_by_id(id)       
    else 
      challenge = Challenge.find_by_id(displayed_challenge.obj_id)
    end
  end

  # def random_challenge
  #   displayed_challenge = DisplayObject.where(:obj_type => "challenge").first
  #   displayed_date = displayed_challenge.updated_at.strftime("%Y-%m-%d")
  #   current_date = Time.now().strftime("%Y-%m-%d")
  #   random_challenge_id = Challenge.find(:all, :select => "id", :conditions => ["status=?", 1]).map(&:id).shuffle.first
  #   if !random_challenge_id.nil?
  #     if displayed_challenge.obj_id.nil? || ((Date.parse(current_date) - Date.parse(displayed_date)) > 7)
  #       the_random_challenge = Challenge.find_by_id(random_challenge_id)
  #       the_random_challenge.status = 3
  #       the_random_challenge.save
  #       displayed_challenge.obj_id = the_random_challenge.id
  #       displayed_challenge.save
  #       the_random_challenge       
  #     else 
  #       challenge = Challenge.find_by_id(displayed_challenge.obj_id)
  #     end
  #   else  
  #     if displayed_challenge.obj_id.nil? || ((Date.parse(current_date) - Date.parse(displayed_date)) > 7)
  #       id = Challenge.find(:all, :select => "id").map(&:id).shuffle.first
  #       displayed_challenge.obj_id = id
  #       displayed_challenge.save
  #       the_random_challenge = Challenge.find_by_id(id)       
  #     else 
  #       challenge = Challenge.find_by_id(displayed_challenge.obj_id)
  #     end
  #   end
  # end
  
  
  def random_fun_fact
    displayed_fun_fact = DisplayObject.where(:obj_type => "fun_fact").first
    displayed_date = displayed_fun_fact.updated_at.strftime("%Y-%m-%d")
    current_date = Time.now().strftime("%Y-%m-%d")
    random_fun_fact_id = FunFact.find(:all, :select => "id", :conditions => ["status=?", 1]).map(&:id).shuffle.first
    if !random_fun_fact_id.nil?
      if displayed_fun_fact.obj_id.nil? || current_date > displayed_date
        the_random_fun_fact = FunFact.find_by_id(random_fun_fact_id)
        the_random_fun_fact.status = 3
        the_random_fun_fact.save
        displayed_fun_fact.obj_id = the_random_fun_fact.id
        displayed_fun_fact.save
        the_random_fun_fact       
      else 
        fun_fact = FunFact.find_by_id(displayed_fun_fact.obj_id)
      end    
    elsif displayed_fun_fact.obj_id.nil? || ((Date.parse(current_date) - Date.parse(displayed_date)) > 7)
      id = FunFact.find(:all, :select => "id").map(&:id).shuffle.first
      displayed_fun_fact.obj_id = id
      displayed_fun_fact.save
      the_random_fun_fact = FunFact.find_by_id(id)      
    else 
      fun_fact = FunFact.find_by_id(displayed_fun_fact.obj_id)
    end
  end
  # 
  # def already_answered?
  #   check_answer = Answer.where(:user_id => current_user.id, :challenge_id => challenge_id) 
  #   check_answer.length >= 1
  # end
end
