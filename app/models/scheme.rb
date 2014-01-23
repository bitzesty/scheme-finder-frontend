class Scheme
  include SchemeFinderFrontend::ApiEntity

  attr_accessor :id,
                :had_direct_interactions,
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

  def website_url
    if (url = website).present?
      if url.starts_with?("http")
        url
      else
        "http://#{url}"
      end
    end
  end

  def logo_for_upload
    if logo.present? && logo.kind_of?(ActionDispatch::Http::UploadedFile)
      @logo = attributes['logo'] = UploadIO.new(
        logo,
        logo.content_type,
        logo.original_filename
      )
    end
  end

  def save
    resp = SchemeFinderFrontend.api_client.post(
      self.class.collection_path,
      { scheme: attributes.merge('logo' => logo_for_upload) }
    )

    case resp.status
    when 201
      true
    when 422
      assign_errors(resp.body['errors'])

      false
    else
      false
    end
  end
end
