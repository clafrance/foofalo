class Link < ActiveRecord::Base
  attr_accessible :name, :url, :category
  
  belongs_to :user
  
  validates :name, :presence => true,
                   :length => { :maximum => 100 },
                   :uniqueness => true
  validates :url, :presence => true
  validates :user_id, :presence => true
  
  def self.categories
    categories = ["Games", "School Works", "Home Works", "Others"]
  end
end
