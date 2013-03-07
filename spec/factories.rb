Factory.define :user do |f|
  f.username "#{(rand(122-97) + 97).chr + (rand(122-97) + 97).chr + (rand(122-97) + 97).chr + (rand(122-97) + 97).chr + (rand(122-97) + 97).chr}"
  #f.sequence(:username) { |n| "user#{n}" }
  #f.username "abc"
  f.firstname "firstname"
  f.lastname "lastname"
  f.email "christie.lafrance@gmail.com"
  f.email_confirmation "christie.lafrance@gmail.com"
  f.password "foobar"
  f.password_confirmation "foobar"
  f.created_at "2013-01-29 06:05:49"
  f.updated_at "2013-01-31 06:05:49"
end

Factory.define :joke do |f|
  f.name "Joke About Dog"
  f.content "Why does dog cross the street?"
  f.user_id "1"
  f.author "Bob"
  f.status "Approved"
  f.message "message"
  f.created_at "2013-01-29 06:05:49"
  f.updated_at "2013-01-31 06:05:49"
end

Factory.define :challenge do |f|
  f.name "Challenge"
  f.content "The biggest challenge is this."
  f.user_id "1"
  f.author "Bob"
  f.status "Approved"
  f.a "column a"
  f.b "column b"
  f.c "column c"
  f.d "column d"
  f.correct_col_name "c"
  f.correct_answer "c is the correct answer"
  f.explanation "what ever explanation"
  f.created_at "2013-01-29 06:05:49"
  f.updated_at "2013-01-31 06:05:49"
end

Factory.define :fun_fact do |f|
  f.name "Fun Fact"
  f.content "Best time to pickup shell is during low tide."
  f.user_id "1"
  f.author "Bob"
  f.status "Approved"
  f.created_at "2013-01-29 06:05:49"
  f.updated_at "2013-01-31 06:05:49"
end

Factory.define :display_object do |f|
  f.obj_type "challenge"
  f.obj_id "1"
  f.created_at "2013-02-20 06:05:49"
  f.updated_at "2013-02-21 06:05:49"
end