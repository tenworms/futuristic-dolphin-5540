class Mechanic < ApplicationRecord
  has_many :rides, through: :mechanic_rides
  has_many :mechanic_rides


end
