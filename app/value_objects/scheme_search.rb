class SchemeSearch
  PER_PAGE = 10

  include Virtus.model

  attribute :had_direct_interactions, Boolean
  attribute :locations, Array[String]
  attribute :sectors, Array[String]
  attribute :commitment_lengths, Array[String]
  attribute :activities, Array[String]
  attribute :company_sizes, Array[String]
  attribute :age_ranges, Array[String]
  attribute :page, Integer, default: 1
  attribute :per_page, Integer, default: PER_PAGE

  def persisted?
    false
  end

  def results
    @results ||= Scheme.paginated(query: search_attributes)
  end

  def search_attributes
    attributes.select do |key, value|
      Array.wrap(value).reject(&:blank?).any?
    end
  end
end
