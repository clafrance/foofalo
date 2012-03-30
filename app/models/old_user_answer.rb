class UserAnswer < ActiveRecord::Base
  # 
  # attr_accessible :content, :correct, :challenge_id
  belongs_to :challenge
  # 
  # validates :challenge_id, :presence => true
  # validates :content, :presence => true,
  #                     :length => { :maximum => 50 }
  # validates :correct, :presence => true, 
  #                     :length => { :maximum => 0 }
end
