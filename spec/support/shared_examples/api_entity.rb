require 'spec_helper'

shared_examples_for 'api entity for' do |filter_type|
  describe ".all" do
    it 'returns all entities' do
      VCR.use_cassette(filter_type) do
        expect(class_name(filter_type).all).to have_at_least(1).item
      end
    end
  end

  def class_name(filter_type)
    filter_type.to_s.classify.constantize
  end
end
