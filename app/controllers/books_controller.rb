require './config/environment'

class BooksController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/books'
  end

  get '/books' do
    erb :index
  end

  get '/books/new' do
    erb :new
  end

  post '/books/new' do
    @book = Book.create(params)
    redirect "/books/#{@book.id}"
  end

  get '/books/:id' do
    @book = Book.find_by(:id => params[:id])
    erb :show
  end

end