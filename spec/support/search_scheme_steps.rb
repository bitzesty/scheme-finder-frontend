module SearchSchemeSteps
  def stub_search_for_scheme_api(stubs, opts = {})
    request_url = opts[:request_url]
    schemes_response_file_path = opts[:schemes_response_file_path]
    stubs_opts = opts[:stubs] || {}
    audience = opts.fetch :audience, "businesses"
    per_page = opts.fetch :per_page, SchemeSearch::PER_PAGE

    # search is conducted on page load
    stubs.get("/api/v1/schemes.json?audiences%5B%5D=#{audience}&page=1&per_page=#{per_page}") do
      api_response(file: "schemes_auto.json")
    end

    stub_scheme_form_fields_api stubs, stubs_opts

    if request_url && schemes_response_file_path
      stubs.get(request_url) do
        api_response(file: schemes_response_file_path)
      end
    end
  end

  def stub_scheme_form_fields_api(stubs, opts = {})
    stub_audiences = opts.fetch(:stub_audiences, false)

    stubs.get("/api/v1/locations.json") do
      api_response(file: "locations.json")
    end
    stubs.get("/api/v1/sectors.json") do
      api_response(file: "sectors.json")
    end
    stubs.get("/api/v1/subjects.json") do
      api_response(file: "subjects.json")
    end

    if stub_audiences
      stubs.get("/api/v1/audiences.json") do
        api_response(file: "audiences.json")
      end
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
