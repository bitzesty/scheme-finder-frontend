module SchemeFinderFrontend
  DEFAULT_PARAMS = {
    api_access_token: "development",
    api_url: "http://scheme-finder-api.dev.bitzesty.com/api/v1",
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
  end
end
