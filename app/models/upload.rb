require 'csv'

class Upload < ActiveRecord::Base

  # :tag_id, :consumer_id, :user_id, :claim_check, :upload_type (organizations, people), :status (uploaded, matching, matched, completed)

  attr_accessible :user_id, :claim_check, :upload_type

  belongs_to :customer
  belongs_to :consumer
  belongs_to :user
  belongs_to :tag, autosave: true

  has_many :matches

  before_validation :set_defaults, :set_tag

  after_save :match!, if: ->(upload) { upload.status == :uploaded }

  def status
    self[:status].try(:to_sym)
  end

  private

  def set_defaults
    self.consumer = self.user.consumer if self.user
    self.customer = self.consumer.customer if self.consumer
    self.status ||= :uploaded
    self.upload_type ||= :organizations
  end

  # create the tag specific for this upload
  def set_tag
    return if tag
    tag = self.tag = Tag.new
    tag.consumer_id = self.consumer_id
    tag.name = "upload_#{self.user_id}_#{Time.now.to_i}"
    tag.description = "Uploaded on #{Time.now} by #{user_id}"
    tag.nature = :consumer_upload

    true
  end

  # match the uploaded file (in background job, using a fake for now)
  def match!
    self.status = :matching
    self.save!

    CSV.foreach(claim_check, headers:true) do |row|
      # witch chance of 3/15 create multiple matches
      nr_of_matches = [1, Random.rand(15) - 12].max
      nr_of_matches.times do
        match = Match.new
        match.upload = self
        match.external_id = row['id']
        match.graydon_id = Random.rand(100_000_000)
        match.graydon_name = 'Generated :)'
        match.reliability = Random.rand(10_000).to_f / 100.0
        match.matched = nr_of_matches == 1
        match.save!
      end
    end

    self.status = :matched
    self.save!
  end

end