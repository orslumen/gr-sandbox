class Tag < ActiveRecord::Base

  # :name, :nature, :consumer_id, :parent_id, :description

  # attr_accessible :name, :consumer_id, :parent_id, :description

  before_validation :set_defaults

  def nature
    self[:nature].try(:to_sym)
  end

  validates_presence_of :name, :nature
  validates_presence_of :consumer_id, unless: ->(tag) { tag.nature == :graydon }

  belongs_to :consumer
  has_and_belongs_to_many :organizations

  belongs_to :parent, class_name: 'Tag'
  has_many   :children, foreign_key: 'parent_id', class_name: 'Tag'

  private

  def set_defaults
    self.nature ||= :consumer
  end

end