class CreateMovieBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_bookings do |t|
      t.string :booking_status
      t.text :seat_ids, array: true, default: []
      t.belongs_to :user
      t.belongs_to :show_timing

      t.timestamps
    end
  end
end
