class Link < ActiveRecord::Base
  attr_accessible :name, :url, :category
  
  belongs_to :user
  
  validates :name, :presence => true,
                   :length => { :maximum => 100 },
                   :uniqueness => true
  validates :category, :presence => true
  validates :url, :presence => true
  validates :user_id, :presence => true
  
  CATEGORIES =  ["Games", "Home Works", "School Works", "Others"]
  
  def self.categories
    categories = ["Games", "Home Works", "School Works", "Others"]
  end
end
