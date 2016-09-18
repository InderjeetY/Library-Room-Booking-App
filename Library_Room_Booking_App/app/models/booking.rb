class Booking < ApplicationRecord
  belongs_to :users
  belongs_to :rooms

  validates :to_time, :from_time, :presence => true
end
