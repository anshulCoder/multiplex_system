class User < ApplicationRecord
	has_one  :referred, class_name: 'Reference', foreign_key: :referred_id
  	has_many :references, foreign_key: :referral_id, as: :referral
  	has_many :movie_bookings

  	validates_presence_of :email, :phone_number

  	after_update :check_referral_points


  	private
  	def check_referral_points
  		self.increment!(:reward_points, 50) if reward_points > 400
  		self.increment!(:reward_points, 30) if references.count > 10
  	end
end
