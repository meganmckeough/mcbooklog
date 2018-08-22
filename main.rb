require 'sinatra'
#comment out before push to heroku
require 'sinatra/reloader'
require 'pg'
require 'pry'
require_relative 'db_config'
require_relative 'models/book'

enable :sessions

helpers do 
	def current_user
		User.find_by(id: session[:user_id])
	end

	def logged_in?
		!!current_user
	end
end

get '/login' do
	erb :login
end

get '/' do
	@books = Book.all
	@reading_goal = 40
	@books_read = @books.count
	@progress_bar = (@books_read.to_f / @reading_goal.to_f * 100).to_i
 	erb :index
end

get '/books/new' do
	redirect '/login' unless logged_in?
	erb :new
end

get '/books/list' do
	@books = Book.all
	erb :list
end

post '/books' do
	redirect '/login' unless logged_in?
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
	redirect '/login' unless logged_in?
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
	redirect '/login' unless logged_in?
	book = Book.find( params[:id] )
	book.destroy
	redirect '/'
end