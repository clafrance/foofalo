module ChallengesHelper
  def correct_answers_by_user(username)
    user = User.where(:username => username)
    userid = user[0].id
    answers_by_user = Answer.where(:user_id => userid, :correct => "yes").count
  end
end
