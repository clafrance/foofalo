class UserMailer < ActionMailer::Base
   default from: "foofalo12@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    #mail(:to => user.email, :subject => "Password Reset")
    mail(:to => "#{@user.username} <#{@user.email}>", :subject => "Password Reset")
  end
  
  def username_reminder(user)
    @user = user
    email = @user.email
    @users = User.where(:email => email)
    mail(:to => "#{@user.email}", :subject => "Username Reminder")
  end
  
  def registration_confirmation(user)
    @user = user
    # attach images to confirmation email
    # attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => "#{@user.firstname} #{@user.lastname} <#{@user.email}>", :subject => "Registration Confirmation")
  end
end
