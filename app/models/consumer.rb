class Consumer < ActiveRecord::Base

  attr_accessible :name

  has_many :users

  validates_presence_of :name

  def self.seed!(consumers_and_users)
    consumers_and_users.each do |consumer_name, users|
      consumer = Consumer.find_or_create_by!(name: consumer_name)
      users.each do |user_name|
        User.find_or_create_by!(consumer: consumer, name: user_name)
      end
    end
  end

end