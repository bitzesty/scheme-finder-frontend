require "spec_helper"

describe "Scheme search" do
  before do |example|
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
        api_response(file: "schemes_search.json")
      end
    end
  end

  it "uses api for searching schemes" do
    filter_by_sector("Auto")
    expect_to_see "Automotives"
  end

  private

  # Command
  #
  # filters schemes by sector
  def filter_by_sector(sector)
    ensure_on schemes_path
    select sector, from: "search_sectors"
    click_on "submit_btn"
  end
end
