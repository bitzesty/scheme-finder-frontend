require 'spec_helper'

describe 'User submitting feedback' do
  include SearchSchemeSteps

  let(:feedback) { build(:feedback) }
  let(:scheme_name) { "name" }
  let(:scheme_id) { 2 }

  before do
    with_backend_api do |stubs|
      stub_search_for_scheme_api stubs,
                                 "/api/v1/schemes.json?page=1&per_page=10",
                                 "schemes_auto.json"

      stubs.post("/api/v1/schemes/#{scheme_id}/feedbacks.json") do
        api_response(status: 201, file: "feedback_created.json")
      end

      stubs.get("/api/v1/schemes/#{scheme_id}/feedbacks.json?scheme_id=#{scheme_id}") do
        api_response(file: "scheme_feedbacks.json")
      end

      stubs.get("/api/v1/schemes/#{scheme_id}.json") do
        api_response(file: "scheme.json")
      end
    end
  end

  specify 'can leave it for scheme' do
    go_to_feedback_form

    submit_feedback feedback

    expect_to_see 'submitted for approval'
  end

  private

  def go_to_feedback_form
    ensure_on search_schemes_path
    expect_to_see scheme_name

    click_on "leave_feedback"
    expect(page).to have_css("#new_feedback")
  end

  def submit_feedback(feedback)
    within("form#new_feedback") do
      choose "feedback_score_#{feedback.score}"
      fill_in "feedback_description", with: feedback.description

      click_on "submit_btn"
    end
  end
end
