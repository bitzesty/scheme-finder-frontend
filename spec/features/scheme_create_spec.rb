require 'spec_helper'

describe 'Creating a scheme' do
  include SearchSchemeSteps

  let(:scheme) { build(:scheme) }

  before do
    with_backend_api do |stubs|
      stub_scheme_form_fields_api stubs

      stubs.post("/api/v1/schemes.json") do
        api_response(status: 201, file: "scheme_created.json")
      end

      # triggered on returning to schemes search
      stub_search_for_scheme_api stubs
    end
  end

  specify 'scheme can be created' do
    submit_scheme(scheme)

    expect(page).to have_content 'submitted for approval'
  end

  private

  def submit_scheme(scheme)
    visit new_scheme_path

    within("form#new_scheme") do
      fill_in 'scheme_name', with: scheme.name
      fill_in 'scheme_website', with: scheme.website
      fill_in 'scheme_description', with: scheme.description
      fill_in 'scheme_contact_name', with: scheme.contact_name
      fill_in 'scheme_contact_email', with: scheme.contact_email
      fill_in 'scheme_contact_phone', with: scheme.contact_phone
      select_by_value('scheme_location_ids', scheme.location_ids.first)
      select_by_value('scheme_sector_ids', scheme.sector_ids.first)
      select_by_value('scheme_commitment_length_ids', scheme.commitment_length_ids.first)
      select_by_value('scheme_activity_ids', scheme.activity_ids.first)
      select_by_value('scheme_company_size_ids', scheme.company_size_ids.first)
      select_by_value('scheme_age_range_ids', scheme.age_range_ids.first)
      # logo is disabled, bring back if client requests that
      # attach_file 'scheme_logo', File.join(Rails.root, 'spec', 'fixtures', 'logo.png')

      click_button 'Create Scheme'
    end
  end
end
