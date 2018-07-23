require 'sinatra'
# require 'sinatra/reloader'
require 'pg'
require 'pry'
require_relative 'db_config'
require_relative 'models/book'

get '/' do
	@books = Book.all
	@reading_goal = 40
	@books_read = @books.count
	@progress_bar = (@books_read.to_f / @reading_goal.to_f * 100).to_i
 	erb :index
end

get '/books/new' do
	erb :new
end

get '/books/list' do
	@books = Book.all
	erb :list
end

post '/books' do
	# sql = "INSERT INTO dishes (name, image_url) VALUES ('#{ params[:name] }', '#{ params[:image_url] }');"
	# run_sql(sql)
	book = Book.new
	book.title = params[:title]
	book.author = params[:author]
	book.genre = params[:genre]
	book.image_url = params[:image_url]
	book.rating = params[:rating]
	book.save
	redirect '/'
end

get '/books/:id' do
	@book = Book.find(params[:id])
	erb :book_details
end

get '/books/:id/edit' do
	@book = Book.find(params[:id])
	erb :edit
end

put '/books/:id' do
	book = Book.find(params[:id])
	book.title = params[:title]
	book.author = params[:author]
	book.genre = params[:genre]
	book.image_url = params[:image_url]
	book.rating = params[:rating]
	book.save
	redirect "/books/#{ params[:id] }"
end


delete '/books/:id' do
	book = Book.find( params[:id] )
	book.destroy
	redirect '/'
end