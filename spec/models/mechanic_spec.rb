require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it {should have_many(:mechanic_rides)}
    it {should have_many(:rides).through(:mechanic_rides)}

  end

  describe 'model methods' do
    it 'averages years of experience' do
      beth = Mechanic.create!(name:"Beth", years_experience: 12)
      sam = Mechanic.create!(name:"Sam", years_experience: 10)
      bill = Mechanic.create!(name:"Bill", years_experience: 11)


      expect(Mechanic.average_years_experience).to eq(11)
    end

    it 'shows open rides' do
      sam = Mechanic.create!(name:"Sam", years_experience: 10)
      six_flags = AmusementPark.create!(name: "Six Flags")
      puker = six_flags.rides.create!(name: "Puker", thrill_rating: 10, open: true)
      thriller = six_flags.rides.create!(name: "Thriller", thrill_rating: 9, open: true)
      spinner = six_flags.rides.create!(name: "Spinner", thrill_rating: 8, open: false)

      MechanicRide.create!(mechanic_id: sam.id, ride_id: puker.id)
      MechanicRide.create!(mechanic_id: sam.id, ride_id: thriller.id)
      MechanicRide.create!(mechanic_id: sam.id, ride_id: spinner.id)

      expect(sam.open_rides).to eq([puker, thriller])
    end

    it 'lists rides by thrill rating desceding' do
      sam = Mechanic.create!(name:"Sam", years_experience: 10)
      six_flags = AmusementPark.create!(name: "Six Flags")
      thriller = six_flags.rides.create!(name: "Thriller", thrill_rating: 9, open: true)
      spinner = six_flags.rides.create!(name: "Spinner", thrill_rating: 8, open: false)
      puker = six_flags.rides.create!(name: "Puker", thrill_rating: 10, open: true)

      MechanicRide.create!(mechanic_id: sam.id, ride_id: puker.id)
      MechanicRide.create!(mechanic_id: sam.id, ride_id: thriller.id)
      MechanicRide.create!(mechanic_id: sam.id, ride_id: spinner.id)

      expect(sam.list_of_thrill).to eq([puker, thriller, spinner])

    end
  end
end
