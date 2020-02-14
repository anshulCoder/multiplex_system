# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating multiplexes
multiplexes = Multiplex.create([{name: "Inorbit Mall"}, {name: "Oberoi Mall"}])

# Adding Screens
first_screens = multiplexes.first.screens.create([{name: "Audi 1", screen_type: "2D"}, {name: "Audi 2", screen_type: "3D"}])
second_screens = multiplexes.last.screens.create([{name: "O1", screen_type: "2D"}, {name: "O2", screen_type: "3D"}])

#Adding seats
first_screens.first.seats.create([{code: "A1", seat_type: "Box", cost: 250.0}, {code: "A2", seat_type: "Box", cost: 250.0},
{code: "A3", seat_type: "Box", cost: 250.0},{code: "A4", seat_type: "Box", cost: 250.0}])
first_screens.first.update_attribute(:seats_capacity, first_screens.first.seats.length)
first_screens.last.seats.create([{code: "A1", seat_type: "Box", cost: 250.0}, {code: "A2", seat_type: "Box", cost: 250.0},
{code: "A3", seat_type: "Box", cost: 250.0},{code: "A4", seat_type: "Box", cost: 250.0}])
first_screens.last.update_attribute(:seats_capacity, first_screens.last.seats.length)


second_screens.first.seats.create([{code: "A1", seat_type: "Box", cost: 250.0}, {code: "A2", seat_type: "Box", cost: 250.0},
{code: "A3", seat_type: "Box", cost: 250.0},{code: "A4", seat_type: "Box", cost: 250.0}])
second_screens.first.update_attribute(:seats_capacity, second_screens.first.seats.length)
second_screens.last.seats.create([{code: "A1", seat_type: "Box", cost: 250.0}, {code: "A2", seat_type: "Box", cost: 250.0},
{code: "A3", seat_type: "Box", cost: 250.0},{code: "A4", seat_type: "Box", cost: 250.0}])
second_screens.last.update_attribute(:seats_capacity, second_screens.last.seats.length)

# creating movies

movies = Movie.create([{name: "Star Wars", rating: 4.0, description: "Star wars movie", release_date: Date.today},
{name: "Die Hard 4", rating: 4.5, description: "Die hard part 4", release_date: Date.today + 2.days}])

# for movie 1
ShowTiming.create([{start_datetime: Time.now.change(hour: 10), end_datetime: Time.now.change(hour: 13), movie_id: movies.first.id, screen_id: first_screens.first.id, multiplex_id: first_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 14), end_datetime: Time.now.change(hour: 17), movie_id: movies.first.id, screen_id: first_screens.first.id, multiplex_id: first_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 18), end_datetime: Time.now.change(hour: 21), movie_id: movies.first.id, screen_id: first_screens.first.id, multiplex_id: first_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 10), end_datetime: Time.now.change(hour: 13), movie_id: movies.first.id, screen_id: first_screens.last.id, multiplex_id: first_screens.last.multiplex.id},
{start_datetime: Time.now.change(hour: 19), end_datetime: Time.now.change(hour: 22), movie_id: movies.first.id, screen_id: first_screens.last.id, multiplex_id: first_screens.last.multiplex.id},
{start_datetime: Time.now.change(hour: 10), end_datetime: Time.now.change(hour: 13), movie_id: movies.first.id, screen_id: second_screens.first.id, multiplex_id: second_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 15), end_datetime: Time.now.change(hour: 18), movie_id: movies.first.id, screen_id: second_screens.first.id, multiplex_id: second_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 10), end_datetime: Time.now.change(hour: 13), movie_id: movies.first.id, screen_id: second_screens.last.id, multiplex_id: second_screens.last.multiplex.id},
{start_datetime: Time.now.change(hour: 20), end_datetime: Time.now.change(hour: 23), movie_id: movies.first.id, screen_id: second_screens.last.id, multiplex_id: second_screens.last.multiplex.id}])



# for movie 2
ShowTiming.create([{start_datetime: Time.now.change(hour: 10), end_datetime: Time.now.change(hour: 13), movie_id: movies.last.id, screen_id: first_screens.first.id, multiplex_id: first_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 14), end_datetime: Time.now.change(hour: 17), movie_id: movies.last.id, screen_id: first_screens.first.id, multiplex_id: first_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 18), end_datetime: Time.now.change(hour: 21), movie_id: movies.last.id, screen_id: first_screens.first.id, multiplex_id: first_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 10), end_datetime: Time.now.change(hour: 13), movie_id: movies.last.id, screen_id: first_screens.last.id, multiplex_id: first_screens.last.multiplex.id},
{start_datetime: Time.now.change(hour: 19), end_datetime: Time.now.change(hour: 22), movie_id: movies.last.id, screen_id: first_screens.last.id, multiplex_id: first_screens.last.multiplex.id},
{start_datetime: Time.now.change(hour: 10), end_datetime: Time.now.change(hour: 13), movie_id: movies.last.id, screen_id: second_screens.first.id, multiplex_id: second_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 15), end_datetime: Time.now.change(hour: 18), movie_id: movies.last.id, screen_id: second_screens.first.id, multiplex_id: second_screens.first.multiplex.id},
{start_datetime: Time.now.change(hour: 10), end_datetime: Time.now.change(hour: 13), movie_id: movies.last.id, screen_id: second_screens.last.id, multiplex_id: second_screens.last.multiplex.id},
{start_datetime: Time.now.change(hour: 20), end_datetime: Time.now.change(hour: 23), movie_id: movies.last.id, screen_id: second_screens.last.id, multiplex_id: second_screens.last.multiplex.id}])