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
  attribute :page, Integer
  attribute :per_page, Integer

  def persisted?
    false
  end

  def results
    @page ||= 1
    @per_page ||= PER_PAGE
    @results ||= Scheme.paginated(query: search_attributes)
  end

  def search_attributes
    attributes.select do |key, value|
      Array.wrap(value).reject(&:blank?).any?
    end
  end
end
