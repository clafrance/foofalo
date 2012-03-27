class DisplayObject < ActiveRecord::Base
  has_one :joke
  has_one :challenge
  has_one :fun_fact
end
