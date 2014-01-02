require 'api_entity'

module SchemeFinderFrontend
  DEFAULT_PARAMS = {
    api_access_token: "development",
    api_host: "scheme-finder-api.dev.bitzesty.com",
    api_path: "/api/v1",
    debug_output: false,
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

    def api_authorization_header
      { 'Authorization' => encoded_api_access_token }
    end

    def encoded_api_access_token
      ActionController::HttpAuthentication::Token.encode_credentials(
        api_access_token
      )
    end
  end
end
