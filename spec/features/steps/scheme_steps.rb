module SchemeSteps
  # Command
  #
  # filters schemes by sector
  def filter_by_sector(sector)
    ensure_on schemes_path
    select sector, from: "search_sectors"
    VCR.use_cassette("schemes_search") do
      click_on "submit_btn"
    end
  end

  # Http request stub
  def stub_entity_response(entity)
    response = VCR::Cassette.new(entity)
                            .http_interactions
                            .interactions
                            .first
                            .response
    stub_request(:get, "#{SchemeFinderFrontend.api_url}/#{entity}.json").to_return(
      body: response.body,
      status: response.status,
      headers: response.headers
    )
  end
end
