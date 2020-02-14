class CreateScreens < ActiveRecord::Migration[5.0]
  def change
    create_table :screens do |t|
      t.string :name, index: true
      t.string :screen_type
      t.integer :seats_capacity
      t.belongs_to :multiplex
      t.timestamps
    end
  end
end
