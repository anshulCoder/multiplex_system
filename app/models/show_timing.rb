class ShowTiming < ApplicationRecord
	belongs_to :movie
	belongs_to :screen
	belongs_to :multiplex
end
