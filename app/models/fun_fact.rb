class FunFact < ActiveRecord::Base
  
  attr_accessible :name, :content, :status
  
  #belongs_to :user
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
  validates :content, :presence => true
  validates :status, :presence => true
  
  
  default_scope order: 'fun_facts.created_at DESC'
  
end
