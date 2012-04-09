class Answer < ActiveRecord::Base
  attr_accessible :challenge_name, :answer_selected, :answer_col_selected, :reason, :correct
  
  belongs_to :user
  belongs_to :challenge
end
