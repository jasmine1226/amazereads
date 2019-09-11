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
    @book = Book.find(params[:id])
    erb :'/books/show'
  end

  get '/books/:id/favorite' do
    if logged_in?
      @book = Book.find(params[:id])
      @user = User.find(session[:user_id])
      @user.books.push(@book)
      erb :'/books/favorite'
    else
      redirect '/login'
    end
  end
end