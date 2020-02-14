module ApplicationHelper

	def multiplexes
		Multiplex.select(:name, :id).order("updated_at desc")
	end

	def seats_unavailable?(screen_id)
		screen_data = Screen.find_by_id(screen_id)
		(screen_data.present? && screen_data.seats.available.count>0 ? false : true)
	end
end
