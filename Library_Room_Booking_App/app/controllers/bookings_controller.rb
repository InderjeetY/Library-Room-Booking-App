class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json

  def search_room
    user_details = User.find_by(email_id: session[:email_id])
    if Booking.find_any_bookings(user_details.id)
      if user_details.booking_count == 0
        redirect_to '/admin/index', notice: 'You are not allowed to book more rooms'# + ', ' + user_details.booking_count.to_s + ', ' + Booking.where('user_id = ? and to_time > ?', user_details.id, DateTime.now).length.to_s
      #else
      #  redirect_to '/admin/index', notice: 'You should not have been allowed to book more rooms' + ', ' + user_details.booking_count.to_s + ', ' + Booking.find_any_bookings(user_details.id).to_s
      end
    #else
    #  redirect_to '/admin/index', notice: 'You should be allowed to book more rooms' + ', ' + user_details.booking_count.to_s + ', ' + Booking.find_any_bookings(user_details.id).to_s
    end
  end

  def search_room_for_member
  end

  def rooms_available
    t1 = params[:Date].to_datetime
    t2 = DateTime.now
    from_time = DateTime.new(t1.year,t1.month,t1.day, params[:from_hour_time].to_i, params[:from_minute_time].to_i, 0, t2.zone)
    to_time = DateTime.new(t1.year,t1.month,t1.day, params[:to_hour_time].to_i, params[:to_minute_time].to_i, 0, t2.zone)
    @rooms = Booking.get_rooms(params[:building], from_time, to_time)
    if @rooms
      if params[:form_id] == '1'
        session[:_user_email_id] = params[:user_id]
      else
        session[:_user_email_id] = session[:email_id]
      end
      session[:from_time] = from_time
      session[:to_time] = to_time
    else
      if DateTime.now >= from_time
        redirect_to '/admin/index', notice: 'Rooms were not available for your search since start time was before current time'# + ', ' + DateTime.now.to_s + ', ' + from_time.to_s
      elsif from_time >= to_time
        redirect_to '/admin/index', notice: 'Rooms were not available for your search since start time was after end time'# + ', ' + to_time.to_s + ', ' + from_time.to_s
      elsif(to_time - from_time)*24 > 2
        redirect_to '/admin/index', notice: 'Rooms were not available for your search since booking is only allowed for 2 hours maximum'# + ', ' + to_time.to_s + ', ' + from_time.to_s + ', ' +(to_time - from_time).to_s
      elsif (to_time - DateTime.now)  > 14
        redirect_to '/admin/index', notice: 'Rooms can only be searched within next week'# + ', ' + DateTime.now.to_s + ', ' + from_time.to_s + ', ' + (to_time - DateTime.now).to_s
      end
    end
  end

  def my_bookings
    if params[:id]
      @user_bookings = Room.select('*').joins(:bookings).where('bookings.user_id = ?',User.find(params[:id]))
    else
      @user_bookings = Room.select('*').joins(:bookings).where('bookings.user_id = ?',User.find_by(email_id: session[:email_id]).id)
    end
  end

  def edit_booking
    @booking = Booking.find(params[:id])
    @room = Room.find(@booking.room_id)
    @from_time = @booking.from_time.in_time_zone("Eastern Time (US & Canada)")
    @to_time = @booking.to_time.in_time_zone("Eastern Time (US & Canada)")
  end

  def update_booking
    t1 = params[:Date].to_datetime
    t2 = DateTime.now
    from_time = DateTime.new(t1.year,t1.month,t1.day, params[:from_hour_time].to_i, params[:from_minute_time].to_i, 0, t2.zone)
    to_time = DateTime.new(t1.year,t1.month,t1.day, params[:to_hour_time].to_i, params[:to_minute_time].to_i, 0, t2.zone)
    @booking = Booking.find(params[:id])
    @rooms = Booking.check_room(@booking.id, @booking.room_id, from_time, to_time)
    if @rooms == 0
      Booking.where(id: params[:id]).update_all(from_time: from_time, to_time: to_time)
      redirect_to '/admin/index', notice: 'Booking updated'
    elsif @rooms == 2
      if DateTime.now >= from_time
        redirect_to '/admin/index', notice: 'Booking not updated since start time was before current time'# + ', ' + DateTime.now.to_s + ', ' + from_time.to_s
      elsif from_time >= to_time
        redirect_to '/admin/index', notice: 'Booking not updated since start time was after end time'# + ', ' + to_time.to_s + ', ' + from_time.to_s
      elsif(to_time - from_time)*24 > 2
        redirect_to '/admin/index', notice: 'Booking not updated since booking is only allowed for 2 hours maximum'# + ', ' + to_time.to_s + ', ' + from_time.to_s + ', ' +(to_time - from_time).to_s
      elsif (to_time - DateTime.now)  > 14
        redirect_to '/admin/index', notice: 'Booking not updated as it goes beyond a week'# + ', ' + DateTime.now.to_s + ', ' + from_time.to_s + ', ' + (to_time - DateTime.now).to_s
      end
    else
      redirect_to '/admin/index', notice: 'Booking not updated as room not available in that time or you did not change the timing'# + ', ' + to_time.to_s + ', ' + from_time.to_s + ', ' + @rooms.to_s
    end
  end

  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @from_time = session[:from_time]
    @to_time = session[:to_time]
    session[:from_time] = 'nil'
    session[:to_time] = 'nil'
    @user = User.find_by(email_id: session[:_user_email_id])
    #session[:_user_email_id] = 'nil'
    @room_id = params[:id]
    @booking = Booking.new
    @booking_id = @booking.id
    @booking.from_time = @from_time
    @booking.to_time = @to_time
    @booking.user_id = @user.id
    @booking.room_id = @room_id
  end

  # GET /bookings/1/edit
  def edit
  end


  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    Rails.logger.info(@booking.errors.inspect)
    respond_to do |format|
      if @booking.save!
        @booking.errors.full_messages
        format.html { redirect_to '/admin/index', notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { redirect_to '/admin/index', notice: 'Booking was not created.' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      #if Booking.valid_params(params[:from_time], params[:to_time], params[:room_id])
      #  redirect_to '/admin/index', notice: 'Timings not valid, hence booking not updated'
      #end
      if @booking.update(booking_params)
        format.html { redirect_to '/admin/index', notice: 'Booking was successfully updated.' + @booking.to_time.to_s + ', ' + @booking.from_time.to_s + ', ' + (@booking.to_time-@booking.from_time).to_s}
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/index', notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:from_time, :to_time, :user_id, :room_id)
    end
end
