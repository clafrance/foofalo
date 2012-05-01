class Joke < ActiveRecord::Base
  attr_accessible :name, :content, :status, :user_id, :author, :created_at, :updated_at, :message
  
  has_one :display_object
  belongs_to :user
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
                   
  validates :content, :presence => true
  
  validates :user_id, :presence => true
                   
  validates :author, :presence => true,
                   :length => { :maximum => 50 }
                   
  validates :status, :presence => true
  
  #default_scope order: 'jokes.created_at DESC'
end
