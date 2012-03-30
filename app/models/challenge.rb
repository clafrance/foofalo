class Challenge < ActiveRecord::Base
  attr_accessible :name, :content, :status, :answer1, :answer2, :answer3, :answer4, :answer5, :correct, :explanation
  
  has_many :answers, :dependent => :destroy
  has_one :display_object
  #belongs_to :user
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
  validates :content, :presence => true
  validates :status, :presence => true
  validates :answer1, :presence => true,
              :length => { :maximum => 128 }
  validates :answer2, :presence => true,
              :length => { :maximum => 128 }
  validates :answer3, :presence => true,
              :length => { :maximum => 128 }
  validates :answer4, :presence => true,
              :length => { :maximum => 128 }
  validates :answer5, :length => { :maximum => 128 }
  validates :explanation, :length => { :maximum => 400 }
  validates :correct, :presence => true,
              :length => { :maximum => 16 }
                                 
  default_scope order: 'challenges.created_at DESC'
  
  ANSWER_COLUMNS =  ["answer1", "answer2", "answer3", "answer4", "answer5"]
end
