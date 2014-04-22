require "spec_helper"

describe %W(
As a user
I want to use guide for teachers or for businesses
) do
  include SearchSchemeSteps
  let(:per_page) { SchemeSearch::PER_PAGE }

  before do
    with_backend_api do |stubs|
      stub_search_for_scheme_api stubs

      stubs.get("/api/v1/schemes.json?audiences%5B%5D=teachers&page=1&per_page=#{per_page}") do
        api_response(file: "schemes_auto.json")
      end
    end
  end

  specify "I am able to choose the guide on start page" do
    choose_teachers_guide
    expect_to_be_on_teachers_guide

    choose_businesses_guide
    expect_to_be_on_businesses_guide
  end

  private

  def choose_teachers_guide
    ensure_on root_path
    within_desktop do
      click_on "btn-teachers-guide"
    end
  end

  def expect_to_be_on_teachers_guide
    expect(page.current_path).to include "teachers"
    expect_to_see "teachers"
  end

  def choose_businesses_guide
    ensure_on root_path
    within_desktop do
      click_on "btn-businesses-guide"
    end
  end

  def expect_to_be_on_businesses_guide
    expect(page.current_path).to include "businesses"
    expect_to_see "businesses"
  end
end
