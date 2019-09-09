require './config/environment'

class BooksController < ApplicationController

  get '/books' do
    @books = Book.all
    erb :'/books/index'
  end

  get '/books/new' do
    erb :'/books/new'
  end

  post '/books/new' do
    @book = Book.create(params)
    redirect "/books/#{@book.id}"
  end

  get '/books/:id' do
    @book = Book.find_by(:id => params[:id])
    erb :'/books/show'
  end

end