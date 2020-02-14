class MultiplexesController < ApplicationController
	before_action :find_multiplex, only: [:edit, :update, :show]

	def index
		@multiplexes = Multiplex.includes(:screens).order('updated_at desc').page(params[:page] || 1).per(15)
	end

	def new
		@multiplex = Multiplex.new
	end

	def create
		@multiplex = Multiplex.new(multiplex_params)
		respond_to_save
	end

	def edit
	end

	def update
		@multiplex.assign_attributes(multiplex_params)
		respond_to_save
	end

	def show
		@screens = @multiplex.screens.page(params[:page] || 1).per(15)
	end

	private

	def multiplex_params
		params.require(:multiplex).permit(:name, screens_attributes: [:name, :screen_type, :_destroy, :id])
	end

	def find_multiplex
		@multiplex = Multiplex.find_by_id(params[:id])
	end

	def respond_to_save
		if @multiplex.save
		  redirect_to multiplexes_path, notice: "Multiplex #{action_name}d Successfully"
		else
		  flash.now[:alert] = @multiplex.errors.full_messages.join(', ')
		  render @multiplex.persisted? ? 'edit' : 'new'
		end
	end
end