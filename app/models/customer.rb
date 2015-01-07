class Customer < ActiveRecord::Base

  attr_accessible :name

  has_many :consumers

  validates_presence_of :name

  def self.seed!(name, consumers_and_users)
    customer = Customer.find_or_create_by!(name: name)
    consumers_and_users.each do |consumer_name, users|
      consumer = Consumer.find_or_create_by!(customer: customer, name: consumer_name)
      users.each do |user_name|
        User.find_or_create_by!(customer: customer, consumer: consumer, name: user_name)
      end
    end
  end


end