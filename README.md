Multiplex system

Ruby version: ruby 2.6.3
Rails: 5.2.2.1
Elastic search: v6.0.1

First-Time Setup:
	1) Modify the database.yml file with local postgresql credentials: config/database.yml
	2) Run bundle install to install all the gems
	3) Install Elasticsearch v6.0.1 in local and run in background
	4) Run ruby db:setup to create and seed the database
	5) For Setting up movie catalogue: 
		a) Open rails console using cmd 'rails c'
		b) Run following cmds:
			s = SetupMovieCatalogue.new
			s.call
	6) Now access the app at 'http://localhost:3000'.

Handling updates:
	Run bundle install
	Run rails db:migrate