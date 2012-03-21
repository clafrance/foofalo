class Joke < ActiveRecord::Base
  attr_accessible :name, :content, :status
  
  has_one :counter
  belongs_to :user
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
  validates :content, :presence => true
  validates :author, :presence => true,
                   :length => { :maximum => 50 }
  validates :status, :presence => true
  
  #default_scope order: 'jokes.created_at DESC'
end
