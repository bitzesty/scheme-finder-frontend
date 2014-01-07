require "spec_helper"

describe SchemeSearch do
  include SearchSchemeSteps

  let(:search_class) { SchemeSearch }
  let(:search) { search_class.new(search_params) }
  let(:search_params) do
    {
      sectors: ["auto"],
    }
  end

  describe ".results" do
    let(:result) { search.results }

    before do
      with_backend_api do |stubs|
        stub_search_for_scheme_api stubs,
                                   "/api/v1/schemes.json?page=1&per_page=10&sectors%5B%5D=auto",
                                   "schemes_auto.json"
      end
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

