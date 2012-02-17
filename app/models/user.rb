# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  firstname  :string(255)
#  lastname   :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token
  
  validates :firstname, :presence => true, :length => { :maximum => 50 }
  validates :lastname,  :presence => true, :length => { :maximum => 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, 
                    :format => { :with => valid_email_regex },
                    :length => { :maximum => 64 },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :length => { :within => 6..16 }, :if => :password
  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
