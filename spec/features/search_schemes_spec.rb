require "spec_helper"

describe "Scheme search" do
  include SearchSchemeSteps

  before do
    with_backend_api do |stubs|
      stub_search_for_scheme_api stubs,
                                 "/api/v1/schemes.json?page=1&per_page=10&sectors%5B%5D=&sectors%5B%5D=auto",
                                 "schemes_search.json"
    end
  end

  it "uses api for searching schemes", js: true do
    ensure_on schemes_path
    filter_by_sector("Auto")
    expect_to_see "Automotives"
  end

  context "for mobile" do
    it "separately displays search results" do
      ensure_on schemes_path(current_agent: "mobile")

      within mobile_search_view do
        filter_by_sector("Auto")
        submit_search
      end

      expect_to_be_on_mobile_search_path
      expect_to_see "Automotives"
    end
  end

  private

  # Command
  #
  # filters schemes by sector
  def filter_by_sector(sector)
    select sector, from: "search_sectors"
  end

  def submit_search
    click_on "submit_btn"
  end

  def mobile_search_view
    ".scheme-finder-mobile-search"
  end

  def expect_to_be_on_mobile_search_path
    expect(current_path).to eq mobile_search_schemes_path(current_agent: "mobile")
  end
end
