namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    User.create!(username: "username",
                 firstname: "User_firstname",
                 lastname: "User_lastname",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      #name = Faker::Name.name
      username = "username-#{n+1}"
      firstname  = "firstname-#{n+1}"
      lastname  = "lastname-#{n+1}"
      email = "example@railstutorial.org"
      password  = "password"
      User.create!(username: username,
                   firstname: firstname,
                   lastname: lastname,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end