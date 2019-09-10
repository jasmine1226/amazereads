class UsersController < ApplicationController

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      puts "session user id = #{ session[:user_id] } "
      redirect "/users/#{@user.id}"
    else
      erb :'/users/failure'
    end
  end

  get '/register' do
    erb :'/users/new'
  end

  post '/register' do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      redirect "/users/#{user.id}"
    end
      erb :'/users/failure'
    end

  get "/users/:id" do
    @user = User.find_by(:id => params[:id])
    erb :'/users/profile'
  end

  get "/users/:id/edit" do  
    if logged_in? && current_user.id == params[:id].to_i
        @user = User.find_by(:id => params[:id])
        erb :'/users/edit'
    else
      erb :'/users/error'
    end
  end

  patch "/users/:id/edit" do
    @user = User.find_by(:id => params[:id])
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.save
    erb :'/users/profile'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end