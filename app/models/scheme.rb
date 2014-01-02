class Scheme
  include ActiveModel::Validations
  include Virtus.model

  attribute :had_direct_interactions, Boolean
  attribute :logo, String
  attribute :logo_cache, String
  attribute :contact_name, String
  attribute :contact_email, String
  attribute :contact_phone, String
  attribute :name, String
  attribute :website, String
  attribute :description, String
  attribute :location_ids, Array[String]
  attribute :sector_ids, Array[String]
  attribute :commitment_length_ids, Array[String]
  attribute :activity_ids, Array[String]
  attribute :company_size_ids, Array[String]
  attribute :age_range_ids, Array[String]

  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :contact_email, presence: true, email: true
  validates :name, presence: true
  validates :website, presence: true
  validates :description, presence: true
  validates :location_ids, presence: true
  validates :sector_ids, presence: true
  validates :activity_ids, presence: true
  validates :age_range_ids, presence: true
  validates :commitment_length_ids, presence: true
  validates :company_size_ids, presence: true

  def persisted?
    false
  end
end
