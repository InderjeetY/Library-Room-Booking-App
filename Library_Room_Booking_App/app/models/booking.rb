class Booking < ApplicationRecord
  belongs_to :users
  belongs_to :rooms

  validates :to_time, :from_time, :presence => true

  def self.valid_dates(from_time = '', to_time = '')

  end

  def self.get_rooms(building = '', from_time = '', to_time = '')
  end

  def self.get_user_booking(room_id = '')
  end

end
