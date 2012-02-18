class User < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  before_create { generate_token(:remember_token) }
  
  validates :firstname, :presence => true, :length => { :maximum => 50 }
  validates :lastname,  :presence => true, :length => { :maximum => 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, 
                    :format => { :with => valid_email_regex },
                    :length => { :maximum => 64 },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :length => { :within => 6..16 }, :if => :password
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
