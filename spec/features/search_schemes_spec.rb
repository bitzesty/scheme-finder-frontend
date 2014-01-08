require "spec_helper"

describe "Scheme search" do
  include SearchSchemeSteps

  before do
    with_backend_api do |stubs|
      # search is conducted on page load
      stubs.get("/api/v1/schemes.json?page=1&per_page=10") do
        api_response(file: "schemes_auto.json")
      end

      # load scheme for, filter by sector
      stub_search_for_scheme_api stubs,
                                 "/api/v1/schemes.json?page=1&per_page=10&sectors%5B%5D=&sectors%5B%5D=auto",
                                 "schemes_search.json"
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
