class UserMailer < ApplicationMailer
  def mailing_details(booking_id,email)
    if email != ''
      @booking = Booking.find(booking_id)
      @user = User.find(@booking.user_id)
      @room = Room.find(@booking.room_id)
      mail to: email, subject: 'Library Room Booked'
    end
  end
end
