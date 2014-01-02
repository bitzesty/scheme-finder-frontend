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
    resp = self.class.post(self.class.collection_path, query: { scheme: attributes }, headers: SchemeFinderFrontend.api_authorization_header)

    case resp.code
    when 422
      json = JSON.parse(resp.body)
      assign_errors(json['errors'])

      false
    end
  end
end
