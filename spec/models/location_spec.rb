require 'spec_helper'

describe Location do
  describe ".all" do
    it 'return all locations' do
      VCR.use_cassette('locations') do
        expect(Location.all).to have(14).items
        expect(Location.all.first.id).to eq "any"
      end
    end
  end
end
