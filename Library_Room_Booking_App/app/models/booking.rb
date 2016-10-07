class Booking < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room, optional: true

  validates :to_time, :from_time, :presence => true
  validate :validate_time

  def validate_time
    if DateTime.now < self.from_time && self.from_time < self.to_time && (self.to_time - self.from_time)*24 <= 2 && (self.to_time - DateTime.now)  <= 14
      rooms_not_available = Booking.where('room_id = ? and (bookings.from_time <= ? and ? < bookings.to_time) or (bookings.from_time < ? and ? <= bookings.to_time)', self.room_id, self.from_time, self.from_time, self.to_time, self.to_time)
      if rooms_not_available
        FALSE
      else
        TRUE
      end
    else
      FALSE
    end
  end

  def self.get_rooms(building = '', from_time = '', to_time = '')
    if DateTime.now < from_time && from_time < to_time && (to_time - from_time)*24 <= 2 && (to_time - DateTime.now)  <= 14#validate_time(from_time,to_time) DateTime.current.to_datetime < from_time && from_time < to_time && (to_time - from_time)*24 <= 2 && (to_time - DateTime.current.to_datetime)  <= 14#validate_time(from_time,to_time)
      rooms_not_available = Booking.where('(bookings.from_time <= ? and ? < bookings.to_time) or (bookings.from_time < ? and ? <= bookings.to_time)', from_time, from_time, to_time, to_time).select(:room_id)
      return Room.where('building = ? and id not in (?)', building, rooms_not_available)
    else
      return FALSE
    end
  end

  def self.rooms_at_time(user_id = '', from_time ='', to_time ='')
    rooms_booked = Booking.where('user_id = ? and ((bookings.from_time <= ? and ? < bookings.to_time) or (bookings.from_time < ? and ? <= bookings.to_time))', user_id, from_time, from_time, to_time, to_time)
    if rooms_booked.length == 0
      FALSE
    else
      TRUE
    end
  end

  def self.get_user_booking(room_id = '')
    return Booking.joins(:users, :rooms).where('rooms.id=?',room_id)
  end

  def self.validate_time(from_time = '' , to_time =' ')
    if DateTime.now.to_datetime < from_time && from_time < to_time && ((to_time - from_time) / 1.hour).to_i <= 2 && (( to_time - DateTime.now) / 1.hour).to_i  <= 14 * 24
      return TRUE
    else
      return FALSE
    end
  end

  def self.check_room(booking_id = '', room_id = '', from_time = '', to_time ='')
    if DateTime.now < from_time && from_time < to_time && (to_time - from_time)*24 <= 2 && (to_time - DateTime.now)  <= 14#validate_time(from_time,to_time) DateTime.current.to_datetime < from_time && from_time < to_time && (to_time - from_time)*24 <= 2 && (to_time - DateTime.current.to_datetime)  <= 14#validate_time(from_time,to_time)
      rooms_not_available = Booking.where('id != ? and room_id = ? and (bookings.from_time <= ? and ? < bookings.to_time) or (bookings.from_time < ? and ? <= bookings.to_time)', booking_id, room_id, from_time, from_time, to_time, to_time)
      if rooms_not_available.length == 0
        return 0
      else
        return 1
      end
    else
      return 2
    end
  end

  def self.valid_params(from_time = '' , to_time =' ', room_id = '')
    if DateTime.now < from_time && from_time < to_time && (to_time - from_time)*24 <= 2 && (to_time - DateTime.now.to_datetime)*24  <= 14#validate_time(from_time,to_time) DateTime.current.to_datetime < from_time && from_time < to_time && (to_time - from_time)*24 <= 2 && (to_time - DateTime.current.to_datetime)  <= 14#validate_time(from_time,to_time)
      rooms_not_available = Booking.where('room_id = ? and (bookings.from_time <= ? and ? < bookings.to_time) or (bookings.from_time < ? and ? <= bookings.to_time)', room_id, from_time, from_time, to_time, to_time)
      if rooms_not_available
        return TRUE
      else
        return FALSE
      end
    else
      return TRUE
    end
  end

  def self.find_any_bookings(user_id = '')
    bookings = Booking.where('user_id = ? and to_time > ?', user_id, DateTime.now)
    if bookings.length == 0
      return FALSE
    else
      return TRUE
    end
  end

end
