Factory.define :user do |f|
  f.sequence(:username) { |n| "user#{n}" }
  #f.username "abc"
  f.firstname "firstname"
  f.lastname "lastname"
  f.email "christie.lafrance@gmail.com"
  f.email_confirmation "christie.lafrance@gmail.com"
  f.password "foobar"
  f.password_confirmation "foobar"
end

Factory.define :user1 do |f|
  f.username "abcd"
  f.firstname "firstname"
  f.lastname "lastname"
  f.email "christie.lafrance@gmail.com"
  f.email_confirmation "christie.lafrance@gmail.com"
  f.password "foobar"
  f.password_confirmation "foobar"
end