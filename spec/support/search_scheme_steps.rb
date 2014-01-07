module SearchSchemeSteps
  def stub_search_for_scheme_api(stubs, request_url, schemes_response_file_path)
    stub_scheme_form_fields_api stubs

    stubs.get(request_url) do
      api_response(file: schemes_response_file_path)
    end
  end

  def stub_scheme_form_fields_api(stubs)
    stubs.get("/api/v1/locations.json") do
      api_response(file: "locations.json")
    end
    stubs.get("/api/v1/sectors.json") do
      api_response(file: "sectors.json")
    end
    stubs.get("/api/v1/commitment_lengths.json") do
      api_response(file: "commitment_lengths.json")
    end
    stubs.get("/api/v1/activities.json") do
      api_response(file: "activities.json")
    end
    stubs.get("/api/v1/company_sizes.json") do
      api_response(file: "company_sizes.json")
    end
    stubs.get("/api/v1/age_ranges.json") do
      api_response(file: "age_ranges.json")
    end
  end
end
