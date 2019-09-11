class BooksController < ApplicationController

  get '/books' do
    @books = Book.all.order('title ASC')
    erb :'/books/index'
  end

  get '/books/new' do
    if logged_in?
      erb :'/books/new'
    else
      redirect '/login'
    end
  end

  post '/books/new' do
    @book = Book.create(params)
    redirect "/books/#{@book.id}"
  end

  get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    erb :'/books/show'
  end

end