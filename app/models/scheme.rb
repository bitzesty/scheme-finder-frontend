class Scheme
  include SchemeFinderFrontend::ApiEntity

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
    resp = SchemeFinderFrontend.api_client.post(
      self.class.collection_path,
      {
        scheme: attributes.merge(
          'logo' => UploadIO.new(
            attributes['logo'],
            attributes['logo'].content_type,
            attributes['logo'].original_filename
          )
        )
      }
    )

    case resp.status
    when 200
      true
    when 422
      assign_errors(resp.body['errors'])

      false
    else
      false
    end
  end
end
