module ChallengesHelper
  def correct_answers_by_user(username)
    user = User.where("username = ?", username)
    #user = User.where(:username => username)
    answers_by_user = Answer.where(:user_id => user[0].id, :correct => "yes").count
  end
end
