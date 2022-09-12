require 'rails_helper'

RSpec.describe "Mechanic Show Page" do
  it 'shows a mechanics attributes and the rides hes worked on' do
    sam = Mechanic.create!(name:"Sam", years_experience: 10)
    bill = Mechanic.create!(name:"Bill", years_experience: 11)
    six_flags = AmusementPark.create!(name: "Six Flags")
    thriller = six_flags.rides.create!(name: "Thriller", thrill_rating: 9, open: true)
    puker = six_flags.rides.create!(name: "Puker", thrill_rating: 10, open: true)
    spinner = six_flags.rides.create!(name: "Spinner", thrill_rating: 8, open: false)
    thrower = six_flags.rides.create!(name: "Thrower", thrill_rating: 8, open: true)

    MechanicRide.create!(mechanic_id: sam.id, ride_id: puker.id)
    MechanicRide.create!(mechanic_id: sam.id, ride_id: thriller.id)
    MechanicRide.create!(mechanic_id: sam.id, ride_id: spinner.id)
    MechanicRide.create!(mechanic_id: bill.id, ride_id: thrower.id)
    visit "/mechanics/#{sam.id}"

    expect(page).to have_content("Name: #{sam.name}")
    expect(page).to_not have_content("Name: #{bill.name}")
    expect(page).to have_content("Years experience: #{sam.years_experience}")
    expect(page).to have_content("Rides currently working on: #{puker.name}")
    expect(page).to have_content("Rides currently working on: #{thriller.name}")
    expect(page).to have_content("Rides currently working on: #{spinner.name}")
    expect(page).to_not have_content("Rides currently working on: #{thrower.name}")
    expect(page).to have_content( "Puker 10" )
    expect(page).to have_content( "Thriller 9" )
  end

  it 'adds a ride to a mechanic' do
    sam = Mechanic.create!(name:"Sam", years_experience: 10)
    bill = Mechanic.create!(name:"Bill", years_experience: 11)
    six_flags = AmusementPark.create!(name: "Six Flags")
    thriller = six_flags.rides.create!(name: "Thriller", thrill_rating: 9, open: true)
    puker = six_flags.rides.create!(name: "Puker", thrill_rating: 10, open: true)
    spinner = six_flags.rides.create!(name: "Spinner", thrill_rating: 8, open: false)
    thrower = six_flags.rides.create!(name: "Thrower", thrill_rating: 8, open: true)

    MechanicRide.create!(mechanic_id: sam.id, ride_id: puker.id)
    MechanicRide.create!(mechanic_id: sam.id, ride_id: thriller.id)
    MechanicRide.create!(mechanic_id: sam.id, ride_id: spinner.id)
    MechanicRide.create!(mechanic_id: bill.id, ride_id: thrower.id)
    visit "/mechanics/#{sam.id}"

    expect(page).to have_content("Add a ride")
  end
end
