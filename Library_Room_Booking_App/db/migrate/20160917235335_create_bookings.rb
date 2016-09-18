class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.datetime :from_time
      t.datetime :to_time

      t.references :user
      t.references :room

      t.timestamps
    end
  end
end
