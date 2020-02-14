class SetupMovieCatalogue

	def initialize
	    index_name = "#{Rails.env}_movies_catalogue"
	    @movies_catalogue = MoviesCatalogueRepository.new(index_name: index_name)
	end

	def call
		unless @movies_catalogue.index_exists?
			@movies_catalogue.create_index! force: true
			set_movies_data
			@movies_catalogue.refresh_index!
		end
	end

	def set_movies_data
		movies_list = Movie.includes(show_timings: [:screen, :multiplex])
		movies_list.each do |movie|
			show_timings = []
			movie.show_timings.each do |st|
				show_timings << {id: st.id, start_datetime: st.start_datetime, end_datetime: st.end_datetime,
					screen_id: st.screen_id, screen_name: st.screen.name, multiplex_name: st.multiplex.name}
			end
			movie_data = MoviesCatalogue.new(id: movie.id, name: movie.name, name_suggest: movie.name.try(:downcase),
				rating: movie.rating, release_date: movie.release_date.to_date, is_active: true, show_timings: show_timings)
			@movies_catalogue.save(movie_data)
		end
	end
end