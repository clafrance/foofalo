module UsersHelper
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def jokes_entered_by_user(username)
    jokes_by_user = Joke.where(:author => username).count
  end
  
  def correct_answers_by_user(username)
    user = User.where(:username => username)
    userid = user[0].id
    answers_by_user = Answer.where(:user_id => userid, :correct => "yes").count
  end
  # 
  # def non_current_users
  #   users = User.all
  #   users.reject { |u| u.id == current_user.id }   
  # end
end
