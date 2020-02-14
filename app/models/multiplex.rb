class Multiplex < ApplicationRecord
	has_many :screens
	has_many :show_timings
	validates_presence_of :name

	accepts_nested_attributes_for :screens, reject_if: :screens_validation, allow_destroy: true


	def screens_validation(attributes)
		attributes['name'].blank? || attributes['screen_type'].blank?
	end
end
