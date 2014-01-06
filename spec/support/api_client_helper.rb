module ApiClientHelper
  def with_backend_api(
    conn = SchemeFinderFrontend.api_client.dup,
    adapter_class = Faraday::Adapter::Test,
    &stubs_block
  )
    adapter_handler = conn.builder.handlers.find {|h| h.klass < Faraday::Adapter }
    conn.builder.swap(adapter_handler, adapter_class, &stubs_block)
  end

  def api_response(status: 200, file: nil, headers: {}, version: "v1")
    response_content = File.open(
      File.join(Rails.root, 'spec', '/fixtures/', 'api_responses', version, file)
    ).read

    [status, headers, JSON.parse(response_content)]
  end
end
