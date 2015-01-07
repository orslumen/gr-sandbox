class Organization < ActiveRecord::Base

  attr_reader :external_id # only used when joined with a original match from a specific upload, see with_matches
  after_initialize :set_external_id

  attr_accessible :consumer_id, :graydon_id

  validates_presence_of :consumer_id, :graydon_id

  belongs_to :consumer
  has_and_belongs_to_many :tags

  scope :by_upload, ->(upload) { joins('join matches ON matches.graydon_id = organizations.graydon_id').where('matches.tag_id = ?', upload.tag_id).select('organizations.*, matches.external_id AS external_id') }
  # @see http://tagging.pui.ch/post/37027745720/tags-database-schemas
  scope :with_tag,  ->(tag)      { where('EXISTS (SELECT 1 FROM organizations_tags WHERE organizations_tags.organization_id = organizations.id AND organizations_tags.tag_id = ?)', tag.id) }
  scope :with_any_tag, ->(tags)  { where('EXISTS (SELECT 1 FROM organizations_tags WHERE organizations_tags.organization_id = organizations.id AND organizations_tags.tag_id IN (?))', tags.map(&:id)) }
  scope :with_all_tags, ->(tags) { tags = tags.uniq; where('(SELECT COUNT(*) FROM organizations_tags WHERE organizations_tags.organization_id = organizations.id AND organizations_tags.tag_id IN (?)) = ?', tags.map(&:id), tags.size) }

  private

  def set_external_id
    @external_id = attributes['external_id']
  end
end