require './config/environment'

class BooksController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/books' do
    erb :books
  end

  post '/books/new' do
    erb :new_book
  end

end