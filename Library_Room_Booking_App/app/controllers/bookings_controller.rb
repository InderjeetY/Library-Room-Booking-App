class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json

  def search_room
  end

  def rooms_available
    #from_time = params[:Date].to_datetime + Time.parse(params[:from_hour_time].to_s + ':' + params[:from_minute_time].to_s).seconds_since_midnight.seconds
    #to_time = params[:Date].to_datetime + Time.parse(params[:to_hour_time].to_s + ':' + params[:to_minute_time].to_s).seconds_since_midnight.seconds
    t1 = params[:Date].to_datetime
    t2 = DateTime.current#Time.now.to_datetime
    from_time = DateTime.new(t1.year,t1.month,t1.day, params[:from_hour_time].to_i, params[:from_minute_time].to_i, 0, t2.zone)
    to_time = DateTime.new(t1.year,t1.month,t1.day, params[:to_hour_time].to_i, params[:to_minute_time].to_i, 0, t2.zone)
    @rooms = Booking.get_rooms(params[:building], from_time, to_time)
    if @rooms
      session[:from_time] = from_time
      session[:to_time] = to_time
    else
      if Time.now.to_datetime >= from_time
        redirect_to '/admin/index', notice: 'Rooms were not available for your search. from time < present time' + from_time.to_s + ', ' + Time.now.to_datetime.to_s
      elsif from_time >= to_time
        redirect_to '/admin/index', notice: 'Rooms were not available for your search. from > to'
      elsif (to_time - from_time)*24 > 2
        redirect_to '/admin/index', notice: 'Rooms were not available for your search. more than two days, ' + from_time.to_s + ',' + to_time.to_s + ', ' + Time.now.to_datetime.to_s + (to_time - from_time).to_s
      elsif (to_time - Time.now.to_datetime)*24  > 14
        redirect_to '/admin/index', notice: 'Rooms were not available for your search. more than a week, ' + from_time.to_s + ',' + to_time.to_s + ', ' + Time.now.to_datetime.to_s + ', ' + (to_time - Time.now.to_datetime).to_s + ', ' + + (to_time - from_time).to_s
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
    @user = User.find_by(email_id: session[:email_id])
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
      if @booking.update(booking_params)
        format.html { redirect_to '/admin/index', notice: 'Booking was successfully updated.' }
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
      format.html { redirect_to '/admins/index', notice: 'Booking was successfully destroyed.' }
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
