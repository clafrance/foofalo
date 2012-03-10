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
end