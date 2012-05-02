class User < ActiveRecord::Base
  include UsersHelper 
  
  attr_accessible :firstname, :lastname, :email, :email_confirmation, :username, :password, :password_confirmation,
                  :parent_approved, :parent_approved_at
  has_secure_password
  
  has_many :jokes
  has_many :links, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :challenges
  has_many :fun_facts
  
  USER_PRIVILEGES = ["user", "super_user", "admin", "guest"]
  
  validates_presence_of :password, :on => :create
  before_create { generate_token(:remember_token) }
  
  valid_email_regex = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i 
  #valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
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
  
  validates :privilege, :presence => true,
            :length => { :maximum => 20 }
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def send_username_reminder
    UserMailer.username_reminder(self).deliver
  end
  
  def send_inform_parents
    generate_token(:inform_parents_token)
    self.inform_parents_sent_at = Time.zone.now
    save!
    UserMailer.inform_parents(self).deliver
  end
  
  def send_parent_confirm
    self.parent_approved = "Yes"
    self.parent_approved_at = Time.zone.now
    save!
    UserMailer.registration_confirmation(self).deliver
  end
end
