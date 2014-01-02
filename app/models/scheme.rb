class Scheme
  include ApiEntity

  attr_accessor :had_direct_interactions,
                :logo,
                :contact_name,
                :contact_email,
                :contact_phone,
                :name,
                :website,
                :description,
                :location_ids,
                :sector_ids,
                :commitment_length_ids,
                :activity_ids,
                :company_size_ids,
                :age_range_ids

  def persisted?
    false
  end

  def save
  end
end
