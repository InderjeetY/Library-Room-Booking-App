class Room < ApplicationRecord
  has_many :bookings

  validates :room_no, :presence => true
  validates :building, :presence => true
  validates :size, :presence => true

  def self.get_all_booking_room (room_id ='')
    return Booking.joins('INNER JOIN `users` ON `bookings`.`user_id` = `users`.`id`').joins('INNER JOIN `rooms` ON `rooms`.`id` = ', room_id)
  end

  def self.find_room_details(building = '', room_no = '', room_size = '')
    return Room.where('room_no LIKE ? and building LIKE? and size LIKE?', '%' + room_no.to_s +  '%', '%' + building.to_s + '%', '%' + room_size.to_s + '%')
  end

end
