class Booking < ApplicationRecord
  belongs_to :users, optional: true
  belongs_to :rooms, optional: true

  validates :to_time, :from_time, :presence => true

  def self.get_rooms(building = '', from_time = '', to_time = '')
    if validate_time(from_time,to_time)
      #return Booking.joins(:users, :rooms).where('rooms.building=?',building)
      #return User.select('*').joins(:bookings).where('bookings.room_id = ?',room_id)
      rooms_not_available = Booking.where('(`bookings`.`from_time` <= ? and ? < `bookings`.`to_time`) or (`bookings`.`from_time` < ? and ? <= `bookings`.`to_time`)', from_time, from_time, to_time, to_time).select(:room_id)
      return Room.where('`building` = ? and `id` not in (?)', building, rooms_not_available)
      #return Room.select('*').joins(:bookings).where('bookings.room_id = room.id and room.building = ?', building)
    else
      return false
    end
  end

  def self.get_user_booking(room_id = '')
    return Booking.joins(:users, :rooms).where('rooms.id=?',room_id)
  end

  "def self.insert_data(from_time = '' , to_time = '', user_id = '', room_id ='')
    inserts = []
    inserts.push
    sql = 'INSERT into bookings VALUES #{"inserts.join("","}'
  end"

  def self.validate_time(from_time = '' , to_time =' ')
    if Time.now.to_datetime < from_time && from_time < to_time && ((to_time - from_time) / 1.hour).to_i <= 2 && (( to_time - Time.now.to_datetime) / 1.hour).to_i  <= 14 * 24
      return true
    else
      return false
    end
  end

end
