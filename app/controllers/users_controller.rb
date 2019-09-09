require './config/environment'

class UsersController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views/users'
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    end
      erb :failure
  end

  get '/register' do
    erb :new
  end

  post '/register' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      redirect "/users/#{user.id}"
    end
      erb :failure
    end

  get "/users/:id" do
    @current_user = User.find_by(:id => session[:user_id])
    if @current_user
      erb :profile
    else
      erb :failure
    end
  end

  get "/users/:id/edit" do
    @user = User.find_by(:id => params[:id])
    erb :edit
  end

  patch "/users/:id/edit" do
    @user = User.find_by(:id => params[:id])
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    erb :profile
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end