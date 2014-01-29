module SearchSchemeSteps
  def stub_search_for_scheme_api(stubs, request_url = nil, schemes_response_file_path = nil)
    # search is conducted on page load
    stubs.get("/api/v1/schemes.json?page=1&per_page=10") do
      api_response(file: "schemes_auto.json")
    end

    stub_scheme_form_fields_api stubs

    if request_url && schemes_response_file_path
      stubs.get(request_url) do
        api_response(file: schemes_response_file_path)
      end
    end
  end

  def stub_scheme_form_fields_api(stubs)
    stubs.get("/api/v1/locations.json") do
      api_response(file: "locations.json")
    end
    stubs.get("/api/v1/sectors.json") do
      api_response(file: "sectors.json")
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
