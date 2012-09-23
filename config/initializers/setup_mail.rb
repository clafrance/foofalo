ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  #:user_name            => "foofalo12",
  :user_name            => "foofalo12@gmail.com",
  :password             => "firethornenimitz",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
# 
# if Rails.env.production?
  ActionMailer::Base.default_url_options[:host] = "www.foofalo.com"
  # ActionMailer::Base.default_url_options[:host] = "localhost:3000"

# ActionMailer::Base.default_url_options[:host] = "localhost:3000"
# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?