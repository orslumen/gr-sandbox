class Organization < ActiveRecord::Base

  attr_reader :external_id # only used when joined with a original match from a specific upload, see with_matches
  after_initialize :set_external_id

  attr_accessible :consumer_id, :graydon_id

  before_validation :set_defaults

  validates_presence_of :consumer_id, :graydon_id

  belongs_to :customer
  belongs_to :consumer
  has_and_belongs_to_many :tags

  scope :by_tag, ->(tag) { joins(:tags).('tags.id = ?', tag.id) }
  scope :by_upload, ->(upload) { joins('join matches ON matches.graydon_id = organizations.graydon_id').where('matches.tag_id = ?', upload.tag_id).select('organizations.*, matches.external_id AS external_id') }

  private

  def set_defaults
    self.customer = self.consumer.customer if self.consumer
  end

  def set_external_id
    @external_id = attributes['external_id']
  end
end