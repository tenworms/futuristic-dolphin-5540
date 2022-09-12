require 'rails_helper'

RSpec.describe "Mechanic Index Page" do
  it 'has a header and shows all attributes and average years of mechanics experience' do
    sam = Mechanic.create!(name:"Sam", years_experience: 10)
    bill = Mechanic.create!(name:"Bill", years_experience: 11)
    beth = Mechanic.create!(name:"Beth", years_experience: 12)

    visit "/mechanics"

    within "#mechanic-#{sam.id}" do
      expect(page).to have_content("Name: #{sam.name}")
      expect(page).to have_content("Years experience: #{sam.years_experience}")
      expect(page).to_not have_content("Name: #{bill.name}")
    end

    within "#mechanic-#{bill.id}" do
      expect(page).to have_content("Name: #{bill.name}")
      expect(page).to have_content("Years experience: #{bill.years_experience}")
      expect(page).to_not have_content("Name: #{sam.name}")
    end

    within "#mechanic-#{beth.id}" do
      expect(page).to have_content("Name: #{beth.name}")
      expect(page).to have_content("Years experience: #{beth.years_experience}")
      expect(page).to_not have_content("Name: #{bill.name}")
    end

    expect(page).to have_content("Average years of experience of mechanics: 11")

  end
end
