require 'net/http/post/multipart'

module SchemeFinderFrontend
  autoload :ApiEntity, 'scheme_finder_frontend/api_entity'

  DEFAULT_PARAMS = {
    api_access_token: "development",
    api_host: "scheme-finder-api.dev.bitzesty.com",
    api_path: "/api/v1",
  }

  class << self
    attr_accessor :configuration

    # Allows default params to be accessed on Progress module
    # directly to prevent chaining
    delegate(*(DEFAULT_PARAMS.keys << { to: :configuration }))

    def configure
      self.configuration ||= OpenStruct.new(DEFAULT_PARAMS)
      yield(configuration)
    end

    def api_url
      "#{api_host}#{api_path}"
    end

    def api_client
      @api_client ||= Faraday.new do |faraday|
        faraday.url_prefix = api_url
        faraday.path_prefix = api_path
        faraday.token_auth(api_access_token)

        faraday.request  :multipart
        faraday.request  :url_encoded

        faraday.response :json, content_type: /\bjson$/
        yield(faraday) if block_given?
        # faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
