class ScreensController < ApplicationController
	before_action :find_screen, only: [:edit, :update, :show]

	def index
		@screens = Screen.includes(:seats).order('updated_at desc').page(params[:page] || 1).per(15)
	end

	def new
		@screen = Screen.new
	end

	def create
		@screen = Screen.new(screen_params)
		respond_to_save
	end

	def edit
	end

	def update
		@screen.assign_attributes(screen_params)
		respond_to_save
	end

	def show
		@seats = @screen.seats.page(params[:page] || 1).per(15)
	end

	private

	def screen_params
		params.require(:screen).permit(:name, :screen_type, :multiplex_id, seats_attributes: [:code, :seat_type, :cost, :_destroy, :id])
	end

	def find_screen
		@screen = Screen.find_by_id(params[:id])
	end

	def respond_to_save
		if @screen.save
			@screen.update_attribute(:seats_capacity, @screen.seats.length)
			redirect_to screens_path, notice: "Screen #{action_name}d Successfully"
		else
			flash.now[:alert] = @screen.errors.full_messages.join(', ')
		 	render @screen.persisted? ? 'edit' : 'new'
		end
	end
end