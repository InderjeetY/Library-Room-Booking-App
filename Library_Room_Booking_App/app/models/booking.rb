class Booking < ApplicationRecord
  has_many :users
  has_many :rooms

  validates :to_time, :from_time, :presence => true
end
