class Joke < ActiveRecord::Base
  has_one :counter
  attr_accessible :name, :content, :status
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
  validates :content, :presence => true
  validates :author, :presence => true
end
