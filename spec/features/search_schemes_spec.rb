require "spec_helper"

describe "Scheme search" do
  include SchemeSteps

  before do
    %w(locations sectors commitment_lengths activities company_sizes age_ranges).each do |entity|
      stub_entity_response entity
    end
  end

  it "uses api for searching schemes" do
    filter_by_sector("Auto")
    expect_to_see "Automotives"
  end
end
