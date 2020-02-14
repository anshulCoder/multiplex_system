class Seat < ApplicationRecord
	belongs_to :screen
	belongs_to :movie_booking, optional: true
	scope :available, -> { where(is_available: true) }
end
