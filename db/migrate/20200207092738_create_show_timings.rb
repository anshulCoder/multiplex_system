class CreateShowTimings < ActiveRecord::Migration[5.0]
  def change
    create_table :show_timings do |t|
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.belongs_to :movie
      t.belongs_to :screen
      t.belongs_to :multiplex

      t.timestamps
    end
  end
end
