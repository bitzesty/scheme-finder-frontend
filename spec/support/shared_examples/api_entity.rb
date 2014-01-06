require 'spec_helper'

shared_examples_for 'api entity for' do |filter_type|
  describe ".all" do
    around do |example|
      with_backend_api do |stubs|
        stubs.get("/api/v1/#{filter_type}.json") do
          api_response(file: "#{filter_type}.json")
        end

        example.yield
      end
    end

    it 'returns all entities' do
      expect(class_name(filter_type).all).to have_at_least(1).item
    end
  end

  def class_name(filter_type)
    filter_type.to_s.classify.constantize
  end
end
