require "spec_helper"

describe SchemeSearch do
  let(:search_class) { SchemeSearch }
  let(:search) { search_class.new(search_params) }
  let(:search_params) do
    {
      sectors: ["auto"],
    }
  end

  describe ".results" do
    let(:result) { search.results }

    around do |example|
      with_backend_api do |stubs|
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
        stubs.get("/api/v1/schemes.json?page=1&per_page=10&sectors%5B%5D=auto") do
          api_response(file: "schemes_auto.json")
        end
      end

      example.run
    end

    it "returns response with pagination related information" do
      expect(result.total_count).to eq 1
      expect(result.current_page).to eq 1
      expect(result.limit).to eq search_class::PER_PAGE
      expect(result.records).to have(1).item
      expect(result.for_kaminari).to have(1).item
      expect(result.for_kaminari.first).to be_kind_of Scheme
    end
  end
end

