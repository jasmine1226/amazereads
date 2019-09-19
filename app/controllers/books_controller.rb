class BooksController < ApplicationController

  get '/books' do
    @books = Book.all.order('title ASC')
    erb :'/books/index'
  end

  get '/books/new' do
    if logged_in?
      erb :'/books/new'
    else
      redirect '/error'
    end
  end

  post '/books/new' do
    @book = Book.create(params)
    redirect "/books/#{@book.id}"
  end

  get '/books/:id' do
    @book = Book.find(params[:id])
    if logged_in?
      @user = User.find(session[:user_id])
      @review = Review.find_by(:book_id => @book.id, :user_id => session[:user_id])
      @book_manager = BookManager.find_by(:book_id => @book.id, :user_id => session[:user_id])
    end
    erb :'/books/show'
  end

  patch '/books/:id/favorite' do
    if logged_in?      
      book_manager = BookManager.find_or_create_by(user_id: session[:user_id], book_id: params[:id])
      book_manager[:favorited?] = !book_manager[:favorited?]
      book_manager.save
      redirect back
    else
      redirect '/error'
    end
  end  
end