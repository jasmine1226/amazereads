class UsersController < ApplicationController

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users/new' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      redirect "/login"
    end
    erb :'/users/failure'
  end

  get '/users/:id/bookshelf' do
    @user = User.find(params[:id])
    @books = @user.books
    erb :'/users/bookshelf'
  end

  get "/users/:id" do
    @user = User.find(params[:id])
    @user.reviews.length > 3 ? (@count = 3) : (@count = @user.reviews.length)
    @recent_reviews = @user.reviews.last(@count)
    @favorite_books = @user.books
    erb :'/users/profile'
  end

  get "/users/:id/edit" do  
    if logged_in? && current_user.id == params[:id].to_i
        @user = User.find(params[:id])
        erb :'/users/edit'
    else
      redirect '/error'
    end
  end

  patch "/users/:id/edit" do
    @user = User.find(params[:id])
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save
    erb :'/users/profile'
  end

  delete "/users/:id/delete" do
    User.find(params[:id]).destroy
    redirect '/logout'
  end
  
end