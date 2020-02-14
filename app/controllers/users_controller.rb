class UsersController < ApplicationController

	def verify_user
		new_user = false
		user = User.find_or_initialize_by(email: params[:email], phone_number: params[:phone_number])
		if user.new_record?
			new_user = true
			user.assign_attributes({reward_points: 50, user_tier: 'L5'})
			user.save!

		end
		render json: {new_record: new_user, user_id: user.id}, status: :ok
	end

	def validate_referral
		ref_user = User.find_by(email: params[:email])
		render json: {status: ref_user.present?, user_ref_id: ref_user.try(:id)}
	end
end