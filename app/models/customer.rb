class Customer < ActiveRecord::Base

  attr_accessible :name

  has_many :consumers

  validates_presence_of :name

end