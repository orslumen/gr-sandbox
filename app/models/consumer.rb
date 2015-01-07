class Consumer < ActiveRecord::Base

  attr_accessible :customer, :name

  belongs_to :customer
  has_many :users

  validates_presence_of :name, :customer_id

end