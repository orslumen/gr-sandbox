class Match < ActiveRecord::Base

  attr_accessible :matched

  belongs_to :upload
  belongs_to :tag

  before_validation :set_defaults

  validates_presence_of :upload_id, :external_id, :graydon_id, :graydon_name, :reliability

  before_save :tag_organization!, if: -> (match) { !match.matched_was && match.matched?}

  private

  def set_defaults
    self.tag = upload.tag if upload
  end

  def tag_organization!
    organization = Organization.find_or_create_by!(consumer_id: self.upload.consumer_id, graydon_id: self.graydon_id)
    organization.tags << self.tag # directly persisted to the DB
  end

end