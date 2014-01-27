require 'spec_helper'

describe 'User viewing feedback' do
  let(:scheme_id) { 2 }
  let(:feedback_description) { "approved feedback" }

  before do
    with_backend_api do |stubs|
      stubs.get("/api/v1/schemes/#{scheme_id}/feedbacks.json?scheme_id=#{scheme_id}") do
        api_response(file: "scheme_feedbacks.json")
      end

      stubs.get("/api/v1/schemes/#{scheme_id}.json") do
        api_response(file: "scheme.json")
      end
    end
  end

  specify 'can see the scheme feedbacks' do
    ensure_on scheme_feedbacks_path(scheme_id: scheme_id)
    expect_to_see feedback_description
  end
end
