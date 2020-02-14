class MovieBookingsController < ApplicationController
	before_action :find_movie, only: [:proceed_booking]

	def index
		page = params[:page] || 1
		movies = movies_catalogue_repository.search_movie_by_name(params[:search], page, 15)
		@movies = Kaminari.paginate_array(movies, total_count: movies.total).page(page).per(15)
	end

	def proceed_booking
		movie_data = movies_catalogue_repository.fetch_show_timings(params[:id]).first
		@movie_name = movie_data["name"]
		@show_timings = movie_data["show_timings"].group_by { |s| s["multiplex_name"]}
	end

	def book_movie
		booking_params[:seat_ids].map!(&:to_i)
		@movie_booking = MovieBooking.create(booking_params.slice(:seat_ids, :user_id, :show_timing_id).merge({booking_status: "Booked"}))
		@movie_booking.seats.update_all({is_available: false}) if @movie_booking.present?

		@movie_booking.user.increment!(:reward_points, 30) if @movie_booking.user.present?
		referring_user = User.find_by_id(booking_params[:user_ref_id]) if booking_params[:user_ref_id].present?
		if referring_user.present?
			@movie_booking.user.create_referred(referral_id: referring_user.id)
			@movie_booking.user.increment!(:reward_points, 10)	
		end
	end

	def fetch_seats
		@seats = Seat.available.where(screen_id: params[:screen_id])
		respond_to do |format|
			format.js {}
		end
	end

	private

	def movies_catalogue_repository
		MoviesCatalogueRepository.new
	end

	def find_movie
		movie = Movie.find_by_id(params[:id])
		redirect_to root_path if movie.blank?
	end

	def booking_params
		params.permit(:show_timing_id, :user_email, :user_phone_number, :user_ref_id, :user_id, seat_ids: [])
	end
end