# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DisplayObject.create(obj_type: 'joke', obj_id: nil)
DisplayObject.create(obj_type: 'challenge', obj_id: nil)
DisplayObject.create(obj_type: 'fun_fact', obj_id: nil)


Joke.create(
  name: 'Law of Refrigerator Observation', 
  content: 'If a cat watches a refrigerator long enough, someone will come along and take out something good to eat.', 
  user_id: 1, 
  author: 'aa', 
  status: 1, 
  message: 'Approved', 
  approved_at: '2012-03-28 04:43:52', 
  created_at: '2012-03-28 04:43:52', 
  updated_at: '2012-03-28 04:43:52')
  
Challenge.create(
  name: 'Triangles', 
  content: 'The sequence of numbers 1, 6, 15, 20, ... continues with which three numbers?', 
  answer1: '32, 80, 120'
  answer2: '1, 6, 15'
  answer3: '15 6 1'
  answer4: '21 26 35'
  answer5: ''
  correct: "answer3"
  explaination: "The sequence is the seventh row of the additive number triangle."
  status: 1, 
  created_at: '2012-03-28 04:43:52', 
  updated_at: '2012-03-28 04:43:52')
  
FunFact.create(
  name: 'Gravity', 
  content: 'Because of differences in gravity, a 100kg (220 pound) person would only weigh 38kg (84 pounds) on Mars.', 
  status: 1, 
  created_at: '2012-03-28 04:43:52', 
  updated_at: '2012-03-28 04:43:52')
