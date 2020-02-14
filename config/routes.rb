Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"
  resources :multiplexes, :screens, except: :destroy
  get 'movie-bookings', to: "movie_bookings#index"
  get 'proceed-booking/:id', to: "movie_bookings#proceed_booking", as: :proceed_booking
  post 'book-movie', to: "movie_bookings#book_movie", as: :book_movie
  post 'fetch-seats', to: "movie_bookings#fetch_seats", as: :get_seats

  post 'verify-user', to: "users#verify_user"
  post 'validate-referral', to: "users#validate_referral"
end

