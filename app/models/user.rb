class User < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :username, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  before_create { generate_token(:remember_token) }
  
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  valid_username_regex = /\A[a-z\d\-._]+[a-z\d]+\z/i
  valid_firstname_regex = /\A[a-z\d\-._]+[a-z\d]+\z/i
  valid_lastname_regex = /\A[a-z\d\-._]+[a-z\d]+\z/i
  
  validates :firstname, :presence => true, 
                        :format => { :with => valid_firstname_regex }, 
                        :length => { :maximum => 50 }
            
  validates :lastname, :presence => true, 
                       :format => { :with => valid_lastname_regex }, 
                       :length => { :maximum => 50 }
            
  validates :username, :presence => true, 
                       :format => { :with => valid_username_regex }, 
                       :length => { :maximum => 50 },
                       :uniqueness => { :case_sensitive => false }
  
  validates :email, :presence => true, 
                    :format => { :with => valid_email_regex },     
                    :length => { :maximum => 64 }
                    
  validates :password, :length => { :within => 6..16 }, :if => :password
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
