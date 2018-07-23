require 'active_record'

options = {
	adapter:'postgresql',
	database: 'booklog2018'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
