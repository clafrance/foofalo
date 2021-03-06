# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)
# 
# 
# # User.create(
# #   id: 1, 
# #   firstname: "Christie", 
# #   lastname: "Lafrance", 
# #   email: "christie.lafrance@gmail.com", 
# #   created_at: "2012-03-28 06:34:25", 
# #   updated_at: "2012-03-28 06:34:41", 
# #   password_digest: "$2a$10$D8dMdFjKG6zz8g9jhYn98uZ6Z5G/r4giyj1p/Ru76RILqUWqtj/SO", 
# #   remember_token: "ms7t0wDkH5IA24QWvDJ-SA", 
# #   privilege: 0, 
# #   username: "aa", 
# #   password_reset_token: nil, 
# #   password_reset_sent_at: nil, 
# #   inform_parents_token: "feH5l7Mo-9kOdJ_DVS0gHA", 
# #   inform_parents_sent_at: "2012-03-28 06:34:25", 
# #   parent_approved: "Yes", 
# #   parent_approved_at: "2012-03-28 06:34:41")
# 
# Joke.create(
#   name: 'Law of Refrigerator Observation', 
#   content: 'If a cat watches a refrigerator long enough, someone will come along and take out something good to eat.', 
#   user_id: 1, 
#   author: 'clafrance', 
#   status: "approved", 
#   message: 'Approved', 
#   created_at: '2012-03-28 04:43:52', 
#   updated_at: '2012-03-28 04:43:52')
#   
# Challenge.create(
#   name: 'Triangles', 
#   content: 'The sequence of numbers 1, 6, 15, 20, ... continues with which three numbers?', 
#   a: '32, 80, 120',
#   b: '1, 6, 15',
#   c: '15 6 1',
#   d: '21 26 35',
#   e: '',
#   correct_col_name: "c",
#   correct_answer: '15 6 1',
#   explanation: "The sequence is the seventh row of the additive number triangle.",
#   status: "new", 
#   author_id: 1,
#   author: "clafrance",
#   created_at: '2012-03-28 04:43:52', 
#   updated_at: '2012-03-28 04:43:52')
#   
# FunFact.create(
#   name: 'Gravity', 
#   content: 'Because of differences in gravity, a 220 pound (100kg) person would only weigh 84 pounds (38kg) on Mars.', 
#   status: "new", 
#   user_id: 1,
#   author: "clafrance",
#   created_at: '2012-03-28 04:43:52', 
#   updated_at: '2012-03-28 04:43:52')
#   
# DisplayObject.create(obj_type: 'joke', obj_id: nil)
# DisplayObject.create(obj_type: 'challenge', obj_id: nil)
# DisplayObject.create(obj_type: 'fun_fact', obj_id: nil)

Game.create(
  name: 'magicball',
  option1: 'Without a doubt_p',
  option2: 'Ask again later_m',
  option3: 'My reply is no_n',
  option4: 'Outlok is good_p',
  option5: 'It is decidedly so_p',
  option6: 'Very doubtfull_n',
  option7: 'Better not tell you now_m',
  option8: 'Yes definitely_p',
  option9: 'Most likely_p',
  option10: 'Outlook not so good_n',
  option11: 'Cannot predict now_m',
  option12: 'Yes_p',
  option13: 'As I can see it, yes_p',
  option14: 'My sources say no_n',
  option15: 'Reply hazy, try again_m',
  option16: 'It is certain_p',
  option17: 'Signs point to yes_p',
  option18: "Don't count on it_n",
  option19: 'Concentrate and ask later_m',
  option20: 'You may relay on it_m',
  option21: 'My sources say yes_p',
  option22: "Don't want to answer this_m"  
)
