class SchemeSearch
  include Virtus.model

  attribute :had_direct_interactions, Boolean
  attribute :location, String
  attribute :sector, String
  attribute :commitment_length, String
  attribute :activity, String
  attribute :company_size, String
  attribute :age_range, String
  attribute :page, Integer, default: 1
  attribute :per_page, Integer

  def persisted?
    false
  end

  def results
    Scheme.paginated(query: search_attributes).for_kaminari
  end

  def search_attributes
    attributes.select do |key, value|
      Array.wrap(value).reject(&:blank?).any?
    end
  end
end
