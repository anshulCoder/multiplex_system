class Screen < ApplicationRecord
	belongs_to :multiplex
	has_many :seats
	has_many :show_timings
	
	validates :name, :screen_type, presence: true


	accepts_nested_attributes_for :seats, reject_if: :seats_validation


	def seats_validation(attributes)
		attributes['code'].blank? || attributes['cost'].blank?
	end
end
