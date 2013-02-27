class Game < ActiveRecord::Base
  attr_accessible :name, :option1, :option2, :option3, :option4, :option5, :option6,
                  :option7, :option8, :option9, :option10, :option11, :option12, 
                  :option13, :option14, :option15, :option16, :option17, :option18,
                  :option19, :option20, :option21, :option22
  
  belongs_to :user
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 },
                   :uniqueness => true
end
