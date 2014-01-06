module ApiClientHelper
  def with_backend_api
    SchemeFinderFrontend.api_client = Faraday.new do |faraday|
      faraday.url_prefix = SchemeFinderFrontend.api_url
      faraday.path_prefix = SchemeFinderFrontend.api_path
      faraday.token_auth(SchemeFinderFrontend.api_access_token)

      faraday.request  :multipart
      faraday.request  :url_encoded

      faraday.response :json, content_type: /\bjson$/
      faraday.adapter :test do |s|
        yield(s)
      end
    end
  end

  def api_response(status: 200, file: nil, headers: {}, version: "v1")
    response_content = File.open(
      File.join(Rails.root, 'spec', '/fixtures/', 'api_responses', version, file)
    ).read

    [status, headers, JSON.parse(response_content)]
  end
end
