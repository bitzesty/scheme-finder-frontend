require "spec_helper"

describe "Scheme search" do
  it "uses api for searching schemes" do
    VCR.use_cassette("schemes_search") do
      filter_by_sector("Auto")
      expect_to_see "Automotives"
    end
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
