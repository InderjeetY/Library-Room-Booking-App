json.extract! booking, :id, :from_time, :to_time, :created_at, :updated_at
json.url booking_url(booking, format: :json)