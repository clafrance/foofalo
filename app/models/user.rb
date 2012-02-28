class User < ActiveRecord::Base
  include UsersHelper 
  
  attr_accessor :email
  attr_accessible :firstname, :lastname, :email, :email_confirmation, :username, :password, :password_confirmation,
                  :parent_firstname, :parent_lastname, :parent_approved_at
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
                    :confirmation => true,
                    :format => { :with => valid_email_regex },     
                    :length => { :maximum => 64 }
                    
  validates :password, :length => { :within => 6..16 }, :if => :password
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def send_username_reminder
    UserMailer.username_reminder(self).deliver
  end
  
  def send_parent_confirm
    generate_token(:inform_parents_token)
    self.inform_parents_sent_at = Time.zone.now
    save!
    UserMailer.inform_parents(self).deliver
  end

  # def generate_token(column) (It has been moved to users_helper.rb)
  #   begin
  #     self[column] = SecureRandom.urlsafe_base64
  #   end while User.exists?(column => self[column])
  # end
end
