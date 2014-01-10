require "spec_helper"

describe %W(
As a user
I want to use guide for teachers or for businesses
) do
  specify "I am able to choose the guide on start page" do
    choose_teachers_guide
    expect_to_be_on_teachers_guide

    choose_businesses_guide
    expect_to_be_on_businesses_guide
  end

  private

  def choose_teachers_guide
    ensure_on root_path
    click_on "btn-teachers-guide"
  end

  def expect_to_be_on_teachers_guide
    expect(page.current_path).to include "teachers"
    expect_to_see "teachers"
  end

  def choose_businesses_guide
    ensure_on root_path
    click_on "btn-businesses-guide"
  end

  def expect_to_be_on_businesses_guide
    expect(page.current_path).to include "businesses"
    expect_to_see "businesses"
  end
end
