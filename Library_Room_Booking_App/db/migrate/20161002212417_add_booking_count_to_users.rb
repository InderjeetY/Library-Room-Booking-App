class AddBookingCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :booking_count, :integer
  end
end
