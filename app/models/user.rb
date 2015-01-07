class User < ActiveRecord::Base

  attr_accessible :consumer, :name

  belongs_to :consumer

  validates_presence_of :name, :consumer_id

end