class Room < ApplicationRecord
  has_many :bookings

  validates :room_no, :presence => true
  validates :building, :presence => true
  validates :size, :presence => true
end
