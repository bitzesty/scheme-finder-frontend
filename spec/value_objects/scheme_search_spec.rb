require "spec_helper"

describe SchemeSearch do
  let(:search_class) { SchemeSearch }
  let(:search) { search_class.new(search_params) }
  let(:search_params) do
    {
      sectors: ["life_sciences"],
    }
  end

  describe ".results" do
    let(:result) { search.results }

    it "returns response with pagination related information" do
      VCR.use_cassette("schemes") do
        expect(result.total_count).to eq 1
        expect(result.current_page).to eq 1
        expect(result.limit).to eq search_class::PER_PAGE
        expect(result.records).to have(1).item
        expect(result.for_kaminari).to have(1).item
        expect(result.for_kaminari.first).to be_kind_of Scheme
      end
    end
  end
end

