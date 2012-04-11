class Challenge < ActiveRecord::Base
  attr_accessible :name, :content, :status, :a, :b, :c, :d, :e, 
                  :correct_col_name, :correct_answer, :explanation, :user_id, :author,
                  :created_at, :updated_at
  
  belongs_to :user
  has_many :answers, :dependent => :destroy
  has_one :display_object
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
  validates :content, :presence => true
  validates :status, :presence => true
  validates :a, :presence => true,
              :length => { :maximum => 128 }
  validates :b, :presence => true,
              :length => { :maximum => 128 }
  validates :c, :presence => true,
              :length => { :maximum => 128 }
  validates :d, :presence => true,
              :length => { :maximum => 128 }
  validates :e, :length => { :maximum => 128 }
  validates :explanation, :length => { :maximum => 400 }
  validates :correct_col_name, :presence => true,
              :length => { :maximum => 16 }
  # validates :correct_answer, :presence => true,
  #             :length => { :maximum => 128 }
                                 
  default_scope order: 'challenges.created_at DESC'
  
  ANSWER_COLUMNS =  ["a", "b", "c", "d"]
end
