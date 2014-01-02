class SchemeSearch
  include Virtus.model

  attribute :had_direct_interactions, Boolean
  attribute :location_ids, Array[String]
  attribute :sector_ids, Array[String]
  attribute :commitment_length_ids, Array[String]
  attribute :activity_ids, Array[String]
  attribute :company_size_ids, Array[String]
  attribute :age_range_ids, Array[String]
  attribute :page, Integer, default: 1
  attribute :per_page, Integer

  def persisted?
    false
  end

  def results
    Scheme.paginated(attributes).for_kaminari
  end
end
