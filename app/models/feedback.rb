class Feedback
  include SchemeFinderFrontend::ApiEntity

  MAX_SCORE = 5

  attr_accessor :score,
                :description,
                :scheme_id

  def persisted?
    false
  end

  def save(scheme_id)
    resp = SchemeFinderFrontend.api_client.post(
      self.class.collection_path(scheme_id: scheme_id),
      { feedback: attributes }
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

  def self.collection_route
    "schemes/:scheme_id/feedbacks.json"
  end
end
