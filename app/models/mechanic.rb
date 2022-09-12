class Mechanic < ApplicationRecord
  has_many :mechanic_rides
  has_many :rides, through: :mechanic_rides




    def self.average_years_experience
      average(:years_experience)
    end

    def open_rides
      rides.where(open: true).order(thrill_rating: :desc)
    end

    def list_of_thrill
      rides.order(thrill_rating: :desc)
    end


  end
