class User < ActiveRecord::Base

  attr_accessible :consumer, :name

  belongs_to :customer
  belongs_to :consumer

  before_validation :set_defaults

  validates_presence_of :name, :consumer_id

  private

  def set_defaults
    self.customer = self.consumer.customer if self.consumer
  end

end