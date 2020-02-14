class Reference < ApplicationRecord
	belongs_to :referral, polymorphic: true
  	belongs_to :referred, class_name: 'User', foreign_key: :referred_id
  	validates_presence_of :referred_id, :referral_id
end
