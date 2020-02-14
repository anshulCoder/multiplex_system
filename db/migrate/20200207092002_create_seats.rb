class CreateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :seats do |t|
      t.string :code
      t.string :seat_type
      t.float :cost
      t.boolean :is_available, default: true
      t.belongs_to :screen
      t.belongs_to :movie_booking

      t.timestamps
    end
  end
end
