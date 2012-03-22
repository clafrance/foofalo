class Challenge < ActiveRecord::Base
  attr_accessible :name, :content, :status
  
  #belongs_to :user
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
  validates :content, :presence => true
  validates :status, :presence => true
  
  
  default_scope order: 'challenges.created_at DESC'
end
