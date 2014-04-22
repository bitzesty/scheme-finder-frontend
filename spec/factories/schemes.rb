include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :name do |n|
    "Scheme #{n}"
  end

  sequence :contact_email do |n|
    "person#{n}@example.com"
  end

  factory :scheme do
    contact_name "Jim Bim"
    contact_email
    contact_phone "0771233445"
    name
    website "example.com"
    description "Host a short visit"
    had_direct_interactions { [false, true].shuffle }
    location_ids { ['north_east', 'north_west'].shuffle }
    sector_ids { ['aero', 'chemicals'].shuffle }
    audience_ids { ['businesses', 'teachers'].shuffle }
    activity_ids { ['hands_on_talks', 'inspiring_talks'].shuffle }
    company_size_ids { ['0-9', '10-249'].shuffle }
    age_range_ids { ['primary_school_children', 'secondary_school_children'].shuffle }
    logo {
      ActionDispatch::TestProcess.fixture_file_upload(
        File.join(Rails.root, 'spec', 'fixtures', 'logo.png'),
        'image/png'
      )
    }
  end
end
