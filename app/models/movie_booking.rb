class MovieBooking < ApplicationRecord
	belongs_to :user
	belongs_to :show_timing
	has_many :seats
end
