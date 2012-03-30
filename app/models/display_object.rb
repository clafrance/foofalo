class DisplayObject < ActiveRecord::Base
  belongs_to :joke
  belongs_to :challenge
  belongs_to :fun_fact
end
